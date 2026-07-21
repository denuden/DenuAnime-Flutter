// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:denuanime/features/anime/domain/entities/anime_characters_model.dart';
import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/features/anime/domain/entities/genre_model.dart';
import 'package:denuanime/features/anime/presentation/common/broadcast_section.dart';
import 'package:denuanime/features/anime/presentation/common/scores_section.dart';
import 'package:denuanime/features/anime/presentation/common/sypnosis_section.dart';
import 'package:denuanime/features/common/presentation/custom_image_network.dart';
import 'package:denuanime/features/main/presentation/common/genre_item.dart';
import 'package:denuanime/features/people/presentation/common/person_card_with_character_item.dart';
import 'package:denuanime/json/anime_character.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AnimeDetailsView extends StatelessWidget {
  final AnimeDetailsModel animeDetails;

  final AnimeCharactersModel animeCharactersModel =
      AnimeCharactersModel.fromJson(
        jsonDecode(anime_character_json) as Map<String, dynamic>,
      );
  AnimeDetailsView({super.key, required this.animeDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Anime Details")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //*Header
            Stack(
              children: [
                CustomImageNetwork(
                  animeDetails.images?.jpg?.large_image_url ?? '',
                  height: 300,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton.filledTonal(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        secondary.withValues(alpha: 0.5),
                      ),
                    ),
                    splashColor: white,
                    onPressed: () {
                      //TODO
                    },
                    icon: const Icon(Icons.open_in_full_rounded, color: white),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            //*Title to description
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  animeDetails.title ?? '---',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  animeDetails.title_japanese ?? 'No japanese title',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  animeDetails.title_english ?? 'No english title',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                //* Genre
                Wrap(
                  spacing: 6,
                  children: List.generate(
                    6,
                    (index) => GenreItem(
                      onSelect: (value) {
                        // list[index].isSelected = value;
                      },
                      genre: const GenreModel(
                        name: "Action",
                        is_selected: false,
                      ),
                      size: GenreItemSize.small,
                      side: BorderSide.none,
                      backgroundColor: primaryDark,
                    ),
                  ),
                ),

                //* Description
                SypnosisSection(
                  synopsis: animeDetails.synopsis ?? 'Nondescript',
                ),

                //* other info
                _OtherInfo(context, animeDetails),
              ],
            ),

            //* anime characters
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  "Characters",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: white),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    //TODO
                  },
                  child: const Text("See all"),
                ),
              ],
            ),

            PersonCardWithCharacterItem(
              animeCharactersModel: animeCharactersModel,
            ),
            PersonCardWithCharacterItem(
              animeCharactersModel: animeCharactersModel,
            ),
            PersonCardWithCharacterItem(
              animeCharactersModel: animeCharactersModel,
            ),

            const SizedBox(height: 32),
          ], //*end
        ),
      ),
    );
  }

  //?================== other info
  Widget _OtherInfo(BuildContext context, AnimeDetailsModel animeDetails) {
    return Column(
      children: [
        //? dates
        SizedBox(
          width: double.infinity,
          child: Card.filled(
            color: tertiary,

            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //* season and status
                  Text(
                    "${animeDetails.season?.toUpperCase() ?? '---'} ${animeDetails.year.toString().toUpperCase()} \u2022 ${animeDetails.status?.toUpperCase() ?? 'No Updates'}",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.4,
                      color: primaryLight,
                    ),
                  ),
                  const SizedBox(height: 4),
                  //* airing date
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.calendar_month_outlined),
                      const SizedBox(width: 8),
                      Text(
                        animeDetails.aired?.string ?? 'Not aired',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: white),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  //* scores and rankings
                  ScoresSection(animeDetails: animeDetails),

                  //* stars
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RatingBarIndicator(
                        rating: animeDetails.score ?? 0.0,
                        itemBuilder: (context, index) =>
                            const Icon(Icons.star, color: Colors.amber),
                        itemCount: 10,
                        itemSize: 28,
                      ),
                      const SizedBox(width: 4),
                      Text("(${animeDetails.score ?? 0.0})"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        //* broadcast
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: BroadcastSection(animeDetails: animeDetails),
        ),
      ],
    );
  }

  //?=========== broadcast info
}
