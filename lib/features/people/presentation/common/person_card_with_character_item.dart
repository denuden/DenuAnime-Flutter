import 'package:denuanime/features/anime/domain/entities/anime_characters_model.dart';
import 'package:denuanime/features/anime/presentation/anime_character_details_view.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';

class PersonCardWithCharacterItem extends StatelessWidget {
  final AnimeCharactersModel animeCharactersModel;
  const PersonCardWithCharacterItem({
    super.key,
    required this.animeCharactersModel,
  });

  @override
  Widget build(BuildContext context) {
    final jpVA = animeCharactersModel.voice_actors?.firstWhere(
      (va) => va.language == "Japanese",
    );

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<AnimeCharacterDetailsView>(
            builder: (context) {
              return AnimeCharacterDetailsView(
                animeCharactersModel: animeCharactersModel,
              );
            },
          ),
        );
      },
      child: Card.filled(
        elevation: 16,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: white.withValues(alpha: 0.2)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsetsGeometry.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //? ===== Anime character
              Expanded(
                flex: 5,
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.network(
                        animeCharactersModel
                                .character
                                ?.images
                                ?.jpg
                                ?.image_url ??
                            '',
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            animeCharactersModel.character?.name ?? 'Unknown',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: white,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            animeCharactersModel.role ?? '---',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              //? ===== VA
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    //* ==========card
                    Container(
                      decoration: BoxDecoration(
                        border: BoxBorder.all(color: tertiary),
                        color: glass,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsGeometry.symmetric(
                          vertical: 4,
                          horizontal: 4,
                        ),
                        //*=== details
                        child: Row(
                          children: [
                            ClipOval(
                              child: Image.network(
                                jpVA?.person?.images?.jpg?.image_url ?? '',
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),

                            const SizedBox(width: 8),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    jpVA?.language ?? '---',
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: primaryLight,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  Text(
                                    jpVA?.person?.name ?? '---',
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //*======= other actors
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${animeCharactersModel.voice_actors?.length} voice actors",
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.keyboard_arrow_right, size: 14),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
