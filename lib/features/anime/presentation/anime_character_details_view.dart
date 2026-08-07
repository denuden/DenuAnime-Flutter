import 'package:denuanime/features/character/domain/cubits/character_cubit.dart';
import 'package:denuanime/features/character/domain/cubits/character_state.dart';
import 'package:denuanime/features/common/presentation/custom_image_network.dart';
import 'package:denuanime/features/common/presentation/skeleton/about_voice_actor_skeleton.dart';
import 'package:denuanime/features/common/presentation/skeleton/character_details_view_skeleton.dart';
import 'package:denuanime/features/common/presentation/spoler_text.dart';
import 'package:denuanime/features/people/domain/entities/people_model.dart';
import 'package:denuanime/features/people/presentation/common/person_card_language_item.dart';
import 'package:denuanime/features/people/presentation/person_details_view.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:denuanime/utils/datetime_formatter.dart';
import 'package:denuanime/utils/truncate_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AnimeCharacterDetailsView extends StatefulWidget {
  final int id;
  final String role;
  const AnimeCharacterDetailsView({
    super.key,
    required this.id,
    required this.role,
  });

  @override
  State<AnimeCharacterDetailsView> createState() =>
      _AnimeCharacterDetailsViewState();
}

class _AnimeCharacterDetailsViewState extends State<AnimeCharacterDetailsView> {
  bool _expanded = false;
  int _selectedIndex = 0;
  //for detecting spoiler tag
  final regex = RegExp(r'\[Spoiler\](.*?)\[/Spoiler\]', dotAll: true);

  bool _showWebView = false;
  bool _isLoading = false;
  bool _hasError = false;
  late final WebViewController _webviewControler;

  //? ========== functions
  void _onNavigateToPersonDetails(int id) {
    Navigator.of(context).push(
      MaterialPageRoute<PersonDetailsView>(
        builder: (context) => PersonDetailsView(id: id),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //get character details full
    context.read<CharacterCubit>().loadCharacter(widget.id);

    //* initialize webview
    _webviewControler = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(true)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            setState(() {
              _isLoading = true;
              _hasError = false;
            });
          },
          onPageFinished: (_) {
            setState(() {
              _isLoading = false;
            });
          },

          onWebResourceError: (_) {
            setState(() {
              _isLoading = false;
            });
          },
          onHttpError: (HttpResponseError error) {
            setState(() {
              _isLoading = false;
              _hasError = true;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<CharacterCubit, CharacterState>(
        builder: (context, state) {
          if (state.isCharacterDetailsLoading) {
            return const CharacterDetailsViewSkeleton();
          }

          if (state.characterDetailsError.isNotEmpty) {
            return Center(child: Text(state.characterDetailsError));
          }

          final character = state.characterDetails;
          final voices = character.voices ?? [];

          //*========= start body
          return Stack(
            children: [
              //*===============
              CustomScrollView(
                slivers: [
                  //* ====== appbar
                  SliverAppBar(
                    expandedHeight: 350,
                    pinned: true,
                    backgroundColor: Colors.black,

                    leading: const BackButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.black38),
                      ),
                    ),

                    actions: [
                      IconButton(
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Colors.black38,
                          ),
                        ),
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {},
                      ),
                      IconButton(
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Colors.black38,
                          ),
                        ),
                        icon: const Icon(Icons.share),
                        onPressed: () {},
                      ),
                    ],

                    //* ========== app bar titles and desc
                    flexibleSpace: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Background image
                        CustomImageNetwork(
                          character.images?.jpg?.image_url ?? '',
                          height: double.maxFinite,
                        ),
                        // Dark gradient
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black],
                              stops: [0.4, 1],
                            ),
                          ),
                        ),

                        //* Character name
                        Positioned(
                          left: 16,
                          right: 16,
                          bottom: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                character.name ?? '',
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(color: Colors.white),
                              ),
                              Text(
                                character.name_kanji ?? '',
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(color: Colors.white),
                              ),
                              Text(
                                widget.role,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //* ========== main body
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //* About
                          const Text("About"),
                          const SizedBox(height: 12),
                          Text("Nicknames: ${character.nicknames?.join(", ")}"),
                          AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: SpoilerText(
                              text: _expanded
                                  ? character.about ?? "No about available."
                                  : truncateAbout(character.about!, 400),
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(height: 1.5),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _expanded = !_expanded;
                                });
                              },
                              child: Text(
                                _expanded ? "Hide" : "See more",
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),

                          //*voice actors
                          const SizedBox(width: 12),

                          Row(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: secondary,
                                ),
                                child: const Padding(
                                  padding: EdgeInsetsGeometry.all(8),
                                  child: Icon(
                                    Icons.mic_none_outlined,
                                    color: primaryGlow,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "Voice Actors",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: white,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),

                          //? ----- voice actor list
                          if (voices.isEmpty == true)
                            const Text("No voice actor/actress found.")
                          else
                            SizedBox(
                              height: 160,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: voices.length,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    width: 300,
                                    child: PersonCardLanguageItem(
                                      voiceActorModel: voices[index],
                                      isSelected: _selectedIndex == index,
                                      onSelect: () {
                                        setState(() {
                                          _selectedIndex = index;
                                        });

                                        context
                                            .read<CharacterCubit>()
                                            .selectVoiceActor(index);
                                      },
                                      onClickWebProfile: (url) {
                                        _webviewControler.loadRequest(
                                          Uri.parse(url),
                                        );

                                        setState(() {
                                          _showWebView = true;
                                        });
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),

                          //? voice actor about
                          const SizedBox(height: 4),

                          if (state.isPeopleLoading)
                            const AboutVoiceActorSkeleton()
                          else
                            _AboutVoiceActor(state.selectedVoiceActor),

                          const SizedBox(height: 32),
                        ], //*end
                      ),
                    ),
                  ),
                ], //?end slivers
              ),

              //* =========== webview
              if (_showWebView)
                SafeArea(
                  bottom: false,
                  child: Material(
                    color: secondary,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _showWebView = false;
                                  _isLoading = false;
                                  _hasError = false;
                                });
                              },
                              icon: const Icon(Icons.close),
                            ),

                            const Expanded(
                              child: Text(
                                "Browser",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),

                        Expanded(
                          child: WebViewWidget(controller: _webviewControler),
                        ),
                      ],
                    ),
                  ),
                ),

              if (_isLoading) const Center(child: CircularProgressIndicator()),

              if (_hasError) const Center(child: Text("Cannot load website")),
            ],
          );
        },
      ),
    );
  }

  Widget _AboutVoiceActor(PeopleModel peopleModel) {
    return Card.outlined(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: textHint),
        borderRadius: BorderRadiusGeometry.circular(20),
      ),
      color: secondary,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.info_outline, color: primaryGlow),
                const SizedBox(width: 8),
                Text(
                  "About the Voice Actor/Actress",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: inversePrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  "Birthdate: ${DateTimeFormatter.formatFromIso(peopleModel.birthday ?? "---", "MMM dd, yyyy")}\nFavorites: ${NumberFormat("#,###").format(peopleModel.favorites ?? 0)}",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: white, height: 1.5),
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    //GO to person page
                    _onNavigateToPersonDetails(peopleModel.mal_id ?? -1);
                  },
                  child: Text(
                    "See more",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
