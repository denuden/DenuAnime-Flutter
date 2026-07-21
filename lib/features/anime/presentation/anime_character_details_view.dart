import 'dart:convert';

import 'package:denuanime/features/anime/domain/entities/anime_characters_model.dart';
import 'package:denuanime/features/character/domain/entities/character_full_model.dart';
import 'package:denuanime/features/common/presentation/custom_image_network.dart';
import 'package:denuanime/features/common/presentation/spoler_text.dart';
import 'package:denuanime/features/people/presentation/common/person_card_language_item.dart';
import 'package:denuanime/json/character_full.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:denuanime/utils/truncate_text.dart';
import 'package:flutter/material.dart';

class AnimeCharacterDetailsView extends StatefulWidget {
  final AnimeCharactersModel animeCharactersModel;
  const AnimeCharacterDetailsView({
    super.key,
    required this.animeCharactersModel,
  });

  @override
  State<AnimeCharacterDetailsView> createState() =>
      _AnimeCharacterDetailsViewState();
}

class _AnimeCharacterDetailsViewState extends State<AnimeCharacterDetailsView> {
  late CharacterFullModel character;
  bool _expanded = false;

  //for detecting spoiler tag
  final regex = RegExp(r'\[Spoiler\](.*?)\[/Spoiler\]', dotAll: true);

  @override
  void initState() {
    super.initState();

    final json = jsonDecode(character_full_json);
    character = CharacterFullModel.fromJson(json as Map<String, dynamic>);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 350,
            pinned: true,
            backgroundColor: Colors.black,

            leading: const BackButton(),

            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {},
              ),
              IconButton(icon: const Icon(Icons.share), onPressed: () {}),
            ],

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
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge?.copyWith(color: Colors.white),
                      ),
                      Text(
                        character.name_kanji ?? '',
                        style: Theme.of(
                          context,
                        ).textTheme.titleSmall?.copyWith(color: Colors.white),
                      ),
                      Text(
                        widget.animeCharactersModel.role ?? '',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          //* Body
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
                      itemCount: character.voices?.length ?? 0,
                      itemBuilder: (context, index) {
                        if (character.voices?.isEmpty == true) {
                          return const Text("No voice actor/actress found.");
                        }
                        return SizedBox(
                          width: 300,
                          child: PersonCardLanguageItem(
                            voiceActorModel: character.voices![index],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
