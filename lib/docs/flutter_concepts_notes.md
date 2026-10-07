# Flutter + Bloc Concepts — Study Notes

Notes from the denuanime refactor. Every topic has four parts:

- **Technical** — how it actually works
- **Simple** — the dumbed-down version
- **Interview** — what to say out loud, short
- **Kotlin** — how the same thing works in Android / Compose

---

## Part 1 — State and rebuilds

### 1. Why every BlocBuilder rebuilds

**Technical**
A cubit holds one state object and exposes one stream. Every `emit` pushes a whole new state object onto that stream. A `BlocBuilder` subscribes to the stream and, by default, re-runs its `builder` for every new state.

It has no idea which fields the builder reads. The builder is just a function body, not a widget with parameters that can be compared. So with one big state class, a change to *any* field rebuilds *every* `BlocBuilder` on that cubit — including ones reading unrelated fields. Widgets outside a `BlocBuilder` are not affected.

Real example: `HomeView` had 4 builders on `AnimeCubit`. The initial load fired ~9 emits → ~36 builder runs, of which ~9 were needed. The carousel rebuilt 10 cards because the *genre list* finished loading.

**Simple**
A cubit is a group chat. Every message makes every member's phone buzz, even when the message isn't about them.

**Interview**
"In Bloc, everything listens to the whole state object, not individual fields. Change one field and every BlocBuilder on that cubit rebuilds, even the parts that don't use it."

**Kotlin**
Compose doesn't work this way — see #3.

---

### 2. `buildWhen` and `listenWhen`

**Technical**
`buildWhen: (previous, current) => bool` runs before each rebuild. Return `true` → the builder runs. Return `false` → skipped. `listenWhen` is the same thing for `BlocListener`.

Write it by listing every field the builder reads:

```dart
buildWhen: (p, c) => p.genres != c.genres,
```

Things to know:
- The **first** build always runs. `buildWhen` only gates later ones.
- Skipped states aren't lost. The next time it returns `true`, the builder gets the *latest* state.
- It only gates **state changes**. If the parent widget rebuilds (a `setState` above it), the builder runs anyway with the current state.
- The one real footgun: forget a field the builder reads, and that part of the UI goes stale.

**Simple**
Muting the group chat with a personal rule: "only buzz me if the genre part changed."

**Interview**
"buildWhen tells a builder which part of the state it depends on. It compares previous and current, and only rebuilds when that part actually changed."

**Kotlin**
No equivalent needed — Compose infers it from parameters (see #3). The closest Flow version is collecting only a slice:

```kotlin
state.map { it.genres }.distinctUntilChanged().collect { ... }
```

Other Flutter tools for the same idea: `BlocSelector`, `context.select`, Riverpod's `ref.watch(provider.select(...))`.

---

### 3. How Compose avoids the problem (comparison)

**Technical**
Compose re-runs a composable when a `State` it *reads* changes. Then, when it calls each child composable, it compares that child's parameters with last time using `equals()`. Unchanged → the child is skipped. So the screen-level composable may recompose, but recomposition stops at every child whose arguments didn't change.

On top of that:
- `data class` gives you structural `equals()` for free.
- `StateFlow` drops any new value that `equals()` the current one, so no-change updates never emit.

Caveat — passing the whole state down kills skipping:

```kotlin
TransactionList(transactions = state.transactionList) // skips correctly
TransactionList(state = state)                         // recomposes every time
```

**Simple**
Compose checks what each composable was handed. Same thing as last time → skip it.

**Interview**
"In Compose, a composable only redraws when what you passed into it changes. In Bloc, everything listens to the whole state object, so change one field and everything rebuilds. buildWhen is how I say which field I actually care about. Same goal — Compose figures it out from what you pass in, Bloc makes you say it."

Key phrase to remember: **"whole state object, not individual fields."**

---

### 4. Equality (`==`) vs `buildWhen` — two different jobs

**Technical**
There are two separate mechanisms:

1. **Does the emit happen at all?** Bloc's `emit` skips if `newState == currentState`. Without an `==` override, Dart compares *identity*, and `copyWith` always makes a new object — so every emit goes through, even ones that changed nothing.
2. **Does this particular builder rebuild?** Decided per builder by `buildWhen`.

`==` (via Equatable or freezed) fixes #1 only. It compares the *whole* state, and one changed field makes the whole state different, so it can never tell one builder "your part didn't change."

Hand-writing `==` means every field, `listEquals` for lists (plain `==` on lists is identity), and a matching `hashCode`. Don't — use Equatable (`props` list) or freezed.

| Tool | Stops duplicate emits | Stops unrelated rebuilds | Prevents impossible states |
|---|---|---|---|
| `==` / Equatable | ✅ | ❌ | ❌ |
| `buildWhen` | ❌ | ✅ | ❌ |
| `Async<T>` | ❌ | makes `buildWhen` one line | ✅ |

**Simple**
`==` decides whether a message gets sent at all. `buildWhen` decides whose phone buzzes.

**Interview**
"`==` compares the whole state, so it only stops emits where nothing changed at all. It can't tell one builder that the part it cares about is unchanged — that's a per-field question, and that's what buildWhen answers."

**Kotlin**
`data class` equals = Equatable for free. `StateFlow` conflation = Bloc's equal-state skip. Compose's parameter skipping = `buildWhen`, done automatically.

---

### 5. `copyWith` and references

**Technical**
`copyWith` makes a new state object, but untouched fields are passed through **by reference**:

```dart
genres: genres ?? this.genres,
```

So after an emit that only changed `animes`, `previous.genres` and `current.genres` are the *same object*. `p.genres != c.genres` is `false` → the genre builder skips. This is identity comparison, and it's enough — as long as you always **replace** collections, never **mutate** them:

```dart
// ✅ new list → new reference → rebuild fires
emit(state.copyWith(genres: AsyncData(updatedList)));

// ❌ mutated in place → same reference → no rebuild, stale UI
list.add(item);
emit(state.copyWith(genres: AsyncData(list)));
```

Safe ways to build a new list: `.map(...).toList()`, `[...old, ...newItems]`.

Footgun: declaring a `copyWith` parameter but forgetting its constructor line. That field silently resets to its default on every copy. (Happened twice: `seasonalAnimeUpcomingList`, then `recents` — the schedules stayed on a skeleton forever.) Check every param appears in both places, or use freezed (#28).

**Simple**
`copyWith` reuses everything you didn't touch. Same object = "nothing changed here."

**Interview**
"copyWith carries unchanged fields by reference, so a cheap identity check tells me which parts changed. The rule is: replace collections, never mutate them, or the UI won't see the change."

**Kotlin**
`data class.copy()` behaves the same — shallow copy, untouched properties keep their references. Same rule with a `MutableList` inside a `StateFlow`: mutate it and nothing emits.

---

## Part 2 — `Async<T>` and Dart patterns

### 6. `Async<T>` — one sealed type per async value

**Technical**
Replaces three fields per piece of data (`list`, `isLoading`, `error`) with one field that is exactly one of four shapes:

```dart
sealed class Async<T> {
  const Async();
}
class AsyncIdle<T> extends Async<T> { const AsyncIdle(); }
class AsyncLoading<T> extends Async<T> { const AsyncLoading(); }
class AsyncData<T> extends Async<T> {
  final T value;
  const AsyncData(this.value);
}
class AsyncFailure<T> extends Async<T> {
  final String message;
  const AsyncFailure(this.message);
}
```

Three loose fields allow nonsense combinations (loading **and** error **and** data, all at once), and every widget has to defend against them with if-chains in the right order. The sealed type only allows real states — "make illegal states unrepresentable." `sealed` also makes `switch` exhaustive: forget a case and it won't compile. The `<T>` just means one class works for genres, anime, characters, anything.

What does **not** go inside it:
- **Pagination flags** (`hasNextPage`, `isLoadingMore`) — they describe a list that's already loaded. During load-more the old items must stay on screen, which `AsyncLoading` (no data) can't express.
- **Form input** (text fields) — a text field is never "loading" or "failed."

`Async<void>` = an action with loading and errors but no data to show, like the login button. On success it goes back to `AsyncIdle`; the signed-in user arrives through the auth stream instead.

Bonus: switching tabs now clears the old list automatically, because `AsyncLoading` carries no data to accidentally show.

**Simple**
Before: three variables describing one thing. Now: one variable that can be one of four shapes. It's basically a `Result` that also knows about loading.

**Interview**
"I model each async piece of state as a sealed type — idle, loading, data, failure — so impossible combinations can't exist, and the compiler forces the UI to handle every case."

**Kotlin**
Same pattern you've already written:

```kotlin
sealed interface UiState<out T> {
    data object Idle : UiState<Nothing>
    data object Loading : UiState<Nothing>
    data class Data<T>(val value: T) : UiState<T>
    data class Failure(val message: String) : UiState<Nothing>
}
```

`Async<void>` = `UiState<Unit>`. Difference: in Kotlin you'd often have one `StateFlow` per slice, so each collector only hears its own. Bloc has one stream for the whole cubit, which is why `buildWhen` is still needed.

---

### 7. Switch expressions and pattern matching

**Technical**

```dart
return switch (state.genres) {
  AsyncIdle() || AsyncLoading() => const Skeleton(),
  AsyncFailure(:final message) => Text(message),
  AsyncData(:final value) when value.isEmpty => const EmptyView(),
  AsyncData(:final value) => GenreList(value),
};
```

- `AsyncFailure(:final message)` — "if it's an `AsyncFailure`, pull its `message` field into a local called `message`." The `:` means match by property name. To rename: `AsyncFailure(message: final err)`.
- `||` — either pattern matches.
- `when` — a guard; extra condition on the same pattern. Arms are checked top to bottom.
- Arms in a switch **expression** must be expressions, so `=>` is required — you can't use `{}` there. Keep arms short by extracting big ones into methods (`AsyncData(:final value) => _buildContent(context, value)`).
- Exhaustive: add a fifth `Async` subclass and every switch that doesn't handle it becomes a compile error.

**Simple**
A switch that checks the type and unpacks the value in one step.

**Interview**
"Dart 3 patterns let me match a sealed type and destructure it in one line, and the compiler checks I handled every case."

**Kotlin**

```kotlin
when (val s = state.genres) {
    is UiState.Failure -> Text(s.message)
    is UiState.Data -> GenreList(s.value)
    // ...
}
```

Kotlin smart-casts after `is`. Dart's destructuring syntax is its way of getting the value out in the same step.

---

### 8. Type promotion — why `is` sometimes doesn't "stick"

**Technical**
Dart promotes **local variables** after an `is` check. It does not promote public fields or getters like `state.genres`, because in theory they could return something different between the check and the use. Fix: copy to a local first.

```dart
final genres = state.genres;
if (genres is! AsyncData<List<GenreModel>>) return;
genres.value; // now a plain List<GenreModel>
```

`is!` with an early return keeps the happy path un-nested.

**Simple**
Check a local copy, not a property.

**Interview**
"Dart only promotes locals, so I assign to a local, guard with `is!` and return early, then use the promoted value."

**Kotlin**
Same rule, same fix. Smart cast fails on a `var` property or a custom getter ("smart cast is impossible because it's a mutable property"), and you solve it with `val local = ...`.

---
## Part 3 — Bloc widgets

### 9. `BlocBuilder` vs `BlocListener` vs `BlocConsumer`

**Technical**
- **`BlocBuilder`** returns widgets. Re-runs on state changes (and when its parent rebuilds).
- **`BlocListener`** runs code once per state change — snackbars, navigation, dialogs. Returns nothing; its `child` is not rebuilt.
- **`BlocConsumer`** is both in one widget. Purely convenience:

```dart
BlocListener(listener: ..., child: BlocBuilder(builder: ...))
// same as
BlocConsumer(listener: ..., builder: ...)
```

Rule of thumb: *"If this ran twice, would it be a bug?"* Rebuilding a button twice is harmless → builder. Showing a snackbar twice or navigating twice is a bug → listener.

Why never show a snackbar inside a builder: builders can re-run at any time (parent rebuild, rotation), and you'd show it again with no new error.

Examples in the app:
- `LoginView` button spinner → `BlocBuilder`
- `LoginView` error snackbar → `BlocListener`
- `AuthGate` picks the root screen **and** pops pages on top → `BlocConsumer`

**Simple**
Builder draws. Listener does. Consumer does both.

**Interview**
"BlocBuilder for UI, BlocListener for one-time side effects like navigation or snackbars, and BlocConsumer when the same spot needs both."

**Kotlin**
Builder ≈ a composable reading state. Listener ≈ `LaunchedEffect` collecting a one-off events `Channel`/`SharedFlow` (the "single events" pattern).

---

## Part 4 — Scoping and dependency injection

### 10. Which cubit a screen actually gets

**Technical**
`context.read<T>()` gets the nearest provider **above** that widget in the tree. Pages pushed with `Navigator.push` are **siblings** under the Navigator, not children of the page that pushed them:

```
MainApp
└─ BlocProvider<PeopleCubit>        ← app-level
   └─ MaterialApp
      └─ Navigator
         ├─ HomeView
         ├─ BlocProvider<PeopleCubit>  ← search's own
         │  └─ SearchPersonView
         └─ PersonDetailsView          ← pushed from search, but NOT inside search's provider
```

So a `BlocProvider` created inside one route only covers that route. A page pushed from it only sees providers above `MaterialApp`.

The bug it caused: every `PersonDetailsView` shared the app-level `PeopleCubit`. Person A → character → VA → person B → back, back → person A's page shows person B. The old shared loading flag also flipped Home's people row to a skeleton whenever any person page loaded.

**Simple**
The person page you open from search doesn't get search's cubit. It gets the app's.

**Interview**
"Providers created in one route aren't visible to routes pushed after it, so per-page state needs a provider created together with that page's route."

**Kotlin**
Like ViewModel scoping: a ViewModel scoped to one `NavBackStackEntry` isn't shared with the next destination. If you scope it to the activity instead, every destination shares it — which is exactly the bug above.

---

### 11. Static `route()` method

**Technical**

```dart
static Route<void> route(int id) {
  return MaterialPageRoute<void>(
    builder: (context) {
      return BlocProvider(
        create: (context) {
          return PeopleCubit(peopleRepo: context.read<PeopleRepo>());
        },
        child: PersonDetailsView(id: id),
      );
    },
  );
}

// caller
Navigator.of(context).push(PersonDetailsView.route(id));
```

Nothing is "detected" — it's a plain function that builds and returns a route. You call it and hand the result to `push`, exactly as if you'd typed the `MaterialPageRoute` inline. Common names: **static route method**, or the **factory method** pattern. It's the same shape the bloc library uses in its own examples.

Why it lives on the page: the page knows it needs its own cubit, so it builds its own route. Three screens open person details; none of them can forget the provider.

If you remove the app-level cubit and miss a caller, it throws "could not find the correct Provider" the moment that screen opens — annoying, but it points straight at the spot.

**Simple**
The page builds its own route, with its own cubit, so nobody calling it can get it wrong.

**Interview**
"Each detail page exposes a static route() that wraps itself in its own BlocProvider. One place to get scoping right, and every caller gets it for free."

**Kotlin**
A `companion object` function, like the classic `companion object { fun newIntent(context: Context, id: Int): Intent }`.

---

### 12. `static` vs `const`

| Kotlin | Dart | Meaning |
|---|---|---|
| `companion object { fun x() }` | `static x()` | Belongs to the class; call it without an instance. Runs at **runtime**. |
| `const val` | `const` | Value fixed at **compile time**. |

A companion object is *not* compile-time — it's just class-level. `route()` builds a fresh route every call.

---

### 13. Repos vs cubits — what to share

**Technical**
- **Repositories have no state.** They just fetch; same input, same output, no matter who calls. One shared instance is correct. `MultiRepositoryProvider` at the root makes them readable anywhere with `context.read<PeopleRepo>()` — that's how every `route()` gets a repo to build its cubit.
- **Cubits hold state.** That's what leaks between screens. Scope them to the screen, unless the state truly belongs to the whole app (auth session, the home screen's data).

`AuthCubit` is app-level **on purpose**: who's signed in is app-wide.

**Simple**
Share the fetchers. Don't share the memory.

**Interview**
"Repositories are app-wide singletons provided at the root. Cubits are scoped per screen, except genuinely global state like authentication."

**Kotlin**
Repos = Hilt `@Singleton`s. `MultiRepositoryProvider` ≈ your Hilt module. Cubits ≈ ViewModels.

---

## Part 5 — Async correctness

### 14. Guarding async work

**Technical**
- **`if (isClosed) return;`** after every `await` in a cubit, before `emit`. Emitting after the cubit closes throws a `StateError`.
- **`if (!mounted) return;`** (or `context.mounted`) after every `await` in a widget, before using `context`.
- **Grab dependencies before `await`**: `final cubit = context.read<AuthCubit>();` then await. The page may be popping by the time the await finishes.
- **Loading guards** stop spam taps and stacked requests: `if (state.recents is AsyncLoading) return;` at the top of the cubit method. Also disable the control in the UI — e.g. `onPressed: null`, or `onSelectionChanged: null` for a `SegmentedButton`. Put the guard in the cubit too, because the button isn't the only caller (pull-to-refresh).
- **Stale responses**: type fast, two searches in flight, the older one lands last and wins. Fix with a token:

```dart
final token = ++_searchToken;
final result = await repo.search(...);
if (isClosed || token != _searchToken) return;
```

**Simple**
After waiting, check the screen/cubit is still alive and the answer is still the one you want.

**Interview**
"After every await I check the cubit isn't closed or the widget is still mounted, I guard against duplicate in-flight requests, and for search I drop out-of-order responses with a request token."

**Kotlin**
`viewModelScope` cancels coroutines when the ViewModel clears, and lifecycle-aware scopes stop UI work — Dart has neither built in, hence the manual checks. The stale-response fix in Kotlin is `collectLatest`, `flatMapLatest`, or cancelling the previous `Job`.

---

### 15. Pagination: only advance on success

**Technical**
Compute the next page into a local, request with a copy, and only commit after success:

```dart
final nextPage = (_currentRequest.page ?? 1) + 1;
final nextRequest = _currentRequest.copyWith(page: () => nextPage);
final result = await repo.searchAnime(nextRequest);
_currentRequest = nextRequest; // only after success
```

Bumping the counter before the call means a failed page 2 is skipped forever — the next scroll asks for page 3. Append with `[...old, ...new]` (new list → rebuild fires). Keep `isLoadingMore` separate from `Async` so existing items stay visible.

**Simple**
Don't turn the page until it actually loaded.

**Interview**
"I only advance the page cursor after a successful fetch, so a failure retries the same page instead of skipping it."

**Kotlin**
Same idea by hand. Paging 3 handles it for you through `LoadResult` and retry.

---

## Part 6 — Errors

### 16. `try` / `on` / `catch` order and `rethrow`

**Technical**
When something is thrown, Dart checks the clauses **top to bottom** and runs **only the first match**.

```dart
try {
  ...
} on FirebaseAuthException catch (e) {   // 1st check
  throw AuthFailure(e.message ?? "...", code: e.code);
} on AuthFailure {                       // 2nd check
  rethrow;
} catch (e) {                            // 3rd — matches anything
  throw AuthFailure("Failed: $e");
}
```

| What's thrown | Which clause runs | Result |
|---|---|---|
| Wrong password (`FirebaseAuthException`) | 1st | `AuthFailure(firebase message)` |
| Your own null-user `AuthFailure` | 2nd | passed up untouched |
| No internet, anything else | 3rd | `AuthFailure("Failed: ...")` |

- `catch (e)` matches **everything**, so it must be last — and it would also catch your own `AuthFailure` and double-wrap it. The `on AuthFailure { rethrow; }` line exists only to let it through.
- No catch-all → no `rethrow` line needed. Uncaught errors just propagate up on their own.
- `rethrow` keeps the **original stack trace**. `throw e` restarts it from the catch block. `rethrow` only works inside a `catch` and always means "the one I just caught."

Layering: the repo converts platform errors (`FirebaseAuthException`, `DioException`) into **one** domain error (`AuthFailure`) with a message the UI can show. The cubit only knows that one type; the UI never sees Firebase.

**Simple**
First matching catch wins. The catch-all goes last, and anything you want to pass through untouched needs its own line above it.

**Interview**
"Catch clauses are checked in order and only the first match runs. My repos translate platform exceptions into a single domain error type, and I use rethrow when an error should pass through unchanged, because it preserves the stack trace."

**Kotlin**
`catch (e: FirebaseAuthException)` → `on FirebaseAuthException catch (e)`. Same top-to-bottom matching. One difference: on the JVM, `throw e` keeps the original trace (it's captured when the exception is created). In Dart you need `rethrow` for that.

---

### 17. Error messages: `code` vs `message`

**Technical**
`FirebaseAuthException` has a `code` (stable identifier) and a `message` (human text). Dart has only `message` — no separate `localizedMessage`; on Android those two are usually the same text.

Choice made: pass `e.message` through, like the Kotlin version did with `localizedMessage`. Trade-offs to know:
- Messages are written by Firebase and can differ by platform and SDK version. Codes are the stable contract.
- If you localize later with `.arb` files, codes become your translation keys.
- Keep a debug log of both: `debugPrint('${e.code} — ${e.message}')`.

**Email enumeration protection** (default for new projects since Sept 2023): sign-in returns `invalid-credential` instead of `user-not-found` / `wrong-password`, so the app can't reveal which emails have accounts. The emulator may show it as `INVALID_LOGIN_CREDENTIALS`.

Where the codes are listed: the pub.dev API reference for each method (e.g. `FirebaseAuth.signInWithEmailAndPassword`), plus Firebase's Flutter "Error handling" guide.

**Simple**
Code = what went wrong, for the program. Message = what went wrong, for a person.

**Interview**
"I translate platform errors into a domain error at the repository boundary, so the UI only deals with one error type and one message, regardless of the backend."

---
## Part 7 — Streams

### 18. `map` vs `listen`, `.first`, cancelling

**Technical**
- `.map(...)` **transforms** a stream and returns a new stream. It doesn't start anything.
- `.listen(...)` **starts** it and returns a `StreamSubscription`. Cancel it when done — in a cubit, inside `close()`.
- `.first` listens, takes one value, and stops by itself.

The auth chain:

```dart
auth.authStateChanges()                               // datasource: Stream<User?>
    .map((u) => u == null ? null : _toAppUser(u))     // repo: Stream<AppUserModel?>
authRepo.authStateChanges().listen((user) { ... })    // cubit: actually listening
```

The repo returns a stream (not a value) so the caller decides when to start listening. The repo's job is hiding Firebase; the cubit's job is reacting.

**Simple**
`map` builds the pipe. `listen` turns on the tap.

**Interview**
"Repositories expose streams and only transform them; the cubit subscribes and cancels the subscription in close()."

**Kotlin**
Same as Flow: `map` = `Flow.map` (cold, nothing runs), `listen` = `collect`, `.first` = `first()`, cancelling = cancelling the `Job` (which `viewModelScope` does for you).

---

## Part 8 — Firebase

### 19. Setup and initialization

**Technical**
- **`firebase-tools`** (npm) = the general Firebase CLI, the `firebase` command: login, deploy, emulators.
- **FlutterFire CLI** (Dart) = the `flutterfire` command. `flutterfire configure` registers the apps and generates `firebase_options.dart`. It uses `firebase-tools` underneath, so you need both.

```bash
npm install -g firebase-tools
firebase login
dart pub global activate flutterfire_cli
flutterfire configure
```

If `flutterfire` isn't found, add `~/.pub-cache/bin` to your PATH.

Initialize **once**, in `main`, before `runApp`:

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MainApp());
}
```

Everywhere else uses singletons: `FirebaseAuth.instance`, `FirebaseFirestore.instance`. Pass the instance into the datasource like `dio`; cubits never touch Firebase.

Providers are enabled in the console under Authentication → **Get started** (first time only — providers don't appear until you click it) → Sign-in method.

**Simple**
Two CLIs: one talks to your Google account, one wires Firebase into the Flutter project. Start Firebase once at launch, then just use `.instance`.

**Interview**
"Firebase is initialized once in main before runApp. The SDK objects are singletons that I inject into the data layer, so nothing above the repository depends on Firebase."

**Kotlin**
Android auto-initializes Firebase through the google-services Gradle plugin, so there's no explicit call. Flutter needs `Firebase.initializeApp`.

---

### 20. Auth state: streams vs `currentUser`

**Technical**
- **`authStateChanges()`** — fires on sign-in and sign-out, including once at startup after the saved session is restored.
- **`userChanges()`** — all of the above **plus** profile updates like `updateDisplayName`. Use this one, or a display name set right after registration never reaches your state.
- **`currentUser`** — instant snapshot. In Flutter it can briefly be `null` at launch before the session restores (especially on web). Fine for later checks, like reading the `uid` when saving a favorite.
- **Safe `Future` version**: `await auth.authStateChanges().first` waits for the restored value.
- In the Android docs it's listed as **`getCurrentUser()`** (Java-style); Kotlin exposes it as the property `currentUser`.

Design used here: the stream is the **single source of truth** for who's signed in. `signInWithEmail` only manages the button's loading/error state; it never sets the status. `AuthGate` switches the root screen from the stream and `popUntil(isFirst)` on every status change, so a pushed `LoginView` doesn't stay on top of `HomeView`.

**Simple**
Don't ask "is someone logged in?" once. Subscribe, and let Firebase tell you every time it changes.

**Interview**
"I drive auth from Firebase's user stream, so app start, login, logout, and session expiry all go through one code path. The login method only tracks its own loading and error state."

**Kotlin**
Same stream exists (`addAuthStateListener`, or a `callbackFlow` around it). On Android, `currentUser` is reliable right after startup; in Flutter, prefer the stream at launch.

---

### 21. Google sign-in needs its own package

**Technical**
`firebase_auth` only consumes a token. The native Google account picker comes from `google_sign_in`. On logout, sign out of `GoogleSignIn` too, or the picker auto-selects the old account.

`google_sign_in` v7 was a big breaking change: `GoogleSignIn.instance`, `initialize()`, `authenticate()`. Many tutorials still show the old `GoogleSignIn().signIn()` — check the version.

Setup gotchas: Android needs your **SHA-1** in Firebase project settings (#1 reason it silently fails). iOS needs `REVERSED_CLIENT_ID` from `GoogleService-Info.plist` as a URL scheme. Apple sign-in needs a paid developer account and the capability in Xcode; if you offer Google on iOS, check App Store guideline 4.8.

**Kotlin**
You also had a separate dependency on Android: Credential Manager (`androidx.credentials` + `googleid`). `google_sign_in` is the Flutter equivalent of that.

---

### 22. The API key in `firebase_options.dart`

**Technical**
Not a secret. It identifies your Firebase project; it doesn't grant access. It's the same key as `google-services.json` and ships inside every APK. GitHub's scanner flags anything shaped like a Google API key. Real protection:

1. **Security Rules** — never leave Firestore in test mode.

```
match /users/{uid}/favorites/{malId} {
  allow read, write: if request.auth != null && request.auth.uid == uid;
}
```

2. **Restrict the key** in Google Cloud Console (package name + SHA-1, bundle ID, allowed APIs) — matters most if paid APIs like Maps share the project.
3. **App Check**, later, to block requests not from your real app.

**Simple**
The key is the address, not the house key. Security Rules are the lock.

**Interview**
"Firebase client keys are public identifiers; access control lives in Security Rules, key restrictions, and App Check."

---

## Part 9 — Forms and UI patterns

### 23. `Form`, validators, autofill

**Technical**
- **`Form` + `GlobalKey<FormState>`** → `_formKey.currentState?.validate()` runs every `TextFormField`'s `validator`, shows the error text under failing fields, and returns `false` if any failed.
- **`AutofillGroup` + `autofillHints`** → tells the password manager (iOS Keychain, Google Password Manager) these fields belong together: fill both with one tap, offer to save.
- **`TextInput.finishAutofillContext()`** (from `flutter/services.dart`) after a successful login → triggers the "Save password?" prompt reliably. It's static, so no `context` needed.
- Two feedback layers: validators catch empty/malformed input instantly, before any request; the snackbar shows what the server rejected.
- Login only checks the password isn't empty. Strength rules belong on **sign-up**, or you lock out users whose older passwords don't meet a newer rule.

**Simple**
`Form` checks all fields at once. `AutofillGroup` lets the phone fill and save them together.

**Kotlin**
Views use `android:autofillHints`. Compose has its own autofill content types. Validation is usually manual state in the ViewModel.

---

### 24. Passing callbacks

**Technical**

```dart
onTap: _onNavigate,                    // tear-off: passes the function
onTap: (id) { _onNavigate(context, id); },  // calls it with arguments

onTap: (id) => _onNavigate,            // ❌ BUG: returns the function, never calls it
```

Making a child widget call the parent: add a `final VoidCallback onReset;` (or `void Function(int)`) parameter and call `widget.onReset()`.

**Kotlin**
`onClick = ::navigate` vs `onClick = { navigate(id) }`. The same bug in Kotlin is `onClick = { ::navigate }`.

---

### 25. Bottom sheets and dialogs are separate routes

**Technical**
A sheet gets its arguments when it opens. A parent `setState` does **not** rebuild an open sheet, so a "reset" callback that changes the parent's variable leaves the sheet showing old values. Instead:
- keep a **draft copy** inside the sheet (`late var _draft = widget.request;`), edit that, and `Navigator.pop(context, _draft)` on Apply;
- or pop with a fresh default to "reset and close".

The parent reads the result: `final result = await showModalBottomSheet<T>(...); if (result != null) setState(...);`

**Simple**
The sheet works on its own copy and hands the answer back when it closes.

**Kotlin**
Like an Activity/Fragment result: the caller gets a value back when the screen finishes, rather than the screen editing the caller's state live.

---

### 26. One source of truth

**Technical**
Don't track the same value in both a widget's `setState` and the cubit (e.g. `_selectedIndex` vs `selectedVoiceIndex`). They drift apart. Rough split:
- **Widget state**: purely visual — expanded/collapsed, current carousel page, scroll and page controllers.
- **Cubit state**: data, and anything derived from data or needed by logic.

Also: an inner `BlocBuilder` should read data from **its own** `state`, not from a variable captured from an outer builder — otherwise a refresh can leave it showing old data when its `buildWhen` skips.

**Kotlin**
Same as `remember`/`rememberSaveable` (UI) vs ViewModel state (data). Hoist state to one owner.

---

### 27. Loading and error screens need a way out

**Technical**
If the back button lives in a `SliverAppBar` inside the success content, loading and error states have no back button. iOS has no system back button, and few users know to swipe. Wrap non-data states with a back button, and give errors a **retry**. Prefer honest messages ("Couldn't load this anime") over guesses ("not found") — most failures are timeouts or rate limits.

---

## Part 10 — Maintenance and the API

### 28. Hand-written `copyWith` → freezed

**Technical**
A hand-written `copyWith` with many fields fails silently: declare a param, forget the constructor line, and the field resets every copy. **freezed** generates `copyWith`, `==`, `hashCode`, `toString`, and sealed unions from a short annotated class:

```dart
@freezed
class AnimeState with _$AnimeState {
  const factory AnimeState({
    @Default(AsyncIdle()) Async<List<GenreModel>> genres,
    // ...
  }) = _AnimeState;
}
```

Cost: a `build_runner` step (`dart run build_runner watch`) and generated `.freezed.dart` files.

**Kotlin**
`data class` gives you `copy`/`equals` built in. freezed is Dart's code-generated version — same trade-off as kapt/KSP.

---

### 29. Rate limits (Jikan)

**Technical**
Jikan counts **all** requests together (roughly 3/second, 60/minute), across every endpoint. Firing people + genres + anime + recommendations + schedules at startup through one `Dio` can hit 429s — that's what the 3-second delay was working around. Better options: run startup calls in sequence, retry with backoff on 429, and cache data that rarely changes (genres).

---

## Cheat sheet: Kotlin / Android → Flutter / Bloc

| Kotlin / Android | Flutter / Bloc |
|---|---|
| ViewModel | Cubit / Bloc |
| `StateFlow<UiState>` | Cubit state + its stream |
| `data class` + `copy()` | class + hand-written `copyWith` (or freezed) |
| `data class` equals | Equatable / freezed |
| StateFlow drops equal values | `emit` skips when `==` (needs Equatable) |
| Compose parameter skipping | `buildWhen` (manual) |
| `map{}.distinctUntilChanged()` | `buildWhen` / `BlocSelector` / `context.select` |
| `LaunchedEffect` + one-off events | `BlocListener` |
| `sealed interface UiState<T>` | `sealed class Async<T>` |
| `UiState<Unit>` | `Async<void>` |
| `when` + smart cast | `switch` expression + destructuring |
| `val local = prop` for smart cast | `final local = prop` for promotion |
| Hilt module / `@Singleton` repos | `MultiRepositoryProvider` |
| ViewModel scoped to nav destination | `BlocProvider` inside the page's `route()` |
| `companion object` function | `static` method |
| `const val` | `const` |
| `Flow.map` / `collect` / `first()` | `Stream.map` / `listen` / `.first` |
| `viewModelScope` auto-cancel | manual `isClosed` / `mounted` checks |
| `collectLatest` / cancel old Job | request token check |
| `catch (e: X)` | `on X catch (e)` |
| `throw e` (keeps trace on JVM) | `rethrow` |
| Credential Manager | `google_sign_in` |
| `google-services.json` + plugin auto-init | `firebase_options.dart` + `Firebase.initializeApp` |
| `getCurrentUser()` / `currentUser` | `FirebaseAuth.instance.currentUser` |
| `android:autofillHints` | `AutofillGroup` + `autofillHints` |
