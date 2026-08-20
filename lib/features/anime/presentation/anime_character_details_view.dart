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
import 'package:denuanime/utils/app_web_view.dart';
import 'package:denuanime/utils/datetime_formatter.dart';
import 'package:denuanime/utils/truncate_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
          return CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              //* ====== appbar
              SliverAppBar(
                expandedHeight: 500,
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
                      backgroundColor: WidgetStatePropertyAll(Colors.black38),
                    ),
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {},
                  ),
                  IconButton(
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.black38),
                    ),
                    icon: const Icon(Icons.share),
                    onPressed: () {},
                  ),
                ],

                //* ========== app bar titles and desc
                flexibleSpace: LayoutBuilder(
                  builder: (context, constraints) {
                    final currentHeight = constraints.maxHeight;

                    final isExpanded = currentHeight > kToolbarHeight + 100;
                    final opacity = ((currentHeight - kToolbarHeight) / 300)
                        .clamp(0.0, 1.0);

                    return Stack(
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
                        if (isExpanded)
                          Positioned(
                            left: 16,
                            right: 16,
                            bottom: 20,
                            child: Opacity(
                              opacity: opacity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    character.name ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(color: Colors.white),
                                  ),
                                  Text(
                                    character.name_kanji ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(color: Colors.white),
                                  ),
                                  Text(
                                    widget.role,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                          ),

                        //* Collapsed title
                        if (!isExpanded)
                          Positioned(
                            left: 56,
                            right: 56,
                            bottom: 12,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                character.name ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
              //* ====== refresh
              CupertinoSliverRefreshControl(
                refreshTriggerPullDistance: 180,

                onRefresh: () async {
                  //get character details full
                  context.read<CharacterCubit>().loadCharacter(widget.id);
                },
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute<AppWebView>(
                                        builder: (_) => AppWebView(url: url),
                                      ),
                                    );
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
