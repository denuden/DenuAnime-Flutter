sealed class Async<T> {
  const Async();
}

class AsyncIdle<T> extends Async<T> {
  const AsyncIdle();
}

class AsyncLoading<T> extends Async<T> {
  const AsyncLoading();
}

class AsyncData<T> extends Async<T> {
  final T value;
  const AsyncData(this.value);
}

class AsyncFailure<T> extends Async<T> {
  final String message;
  const AsyncFailure(this.message);
}
