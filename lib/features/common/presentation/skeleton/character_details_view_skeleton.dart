import 'package:denuanime/features/anime/domain/entities/voice_actor_model.dart';
import 'package:denuanime/features/people/presentation/common/person_card_language_item.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CharacterDetailsViewSkeleton extends StatelessWidget {
  const CharacterDetailsViewSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        Skeletonizer.sliver(
          enabled: true,
          child: SliverAppBar(
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

            flexibleSpace: Stack(
              fit: StackFit.expand,
              children: [
                // Background image
                const Bone.square(size: double.maxFinite),
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
                        "asdadadsa",
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge?.copyWith(color: Colors.white),
                      ),
                      Text(
                        'sample',
                        style: Theme.of(
                          context,
                        ).textTheme.titleSmall?.copyWith(color: Colors.white),
                      ),
                      Text(
                        'gfagegagag',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        //* Body
        Skeletonizer.sliver(
          enabled: true,

          child: SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //* About
                  const Text("About"),
                  const SizedBox(height: 12),
                  const Text("Nicknames: "),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},

                      child: Text(
                        "wfw",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
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
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  //? ----- voice actor list
                  SizedBox(
                    height: 160,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 300,
                          child: PersonCardLanguageItem(
                            voiceActorModel: VoiceActorModel(),
                            isSelected: false,
                            onSelect: () {},
                          ),
                        );
                      },
                    ),
                  ),

                  //? voice actor about
                  const SizedBox(height: 4),
                  Card.outlined(
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
                              const Icon(
                                Icons.info_outline,
                                color: primaryGlow,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "About the Voice Actor/Actress",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
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
                                "Birthdate:  ?? #)}",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: white, height: 1.5),
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () {
                                  //GO to person page
                                },
                                child: Text(
                                  "See more",
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                ], //*end
              ),
            ),
          ),
        ),
      ],
    );
  }
}
