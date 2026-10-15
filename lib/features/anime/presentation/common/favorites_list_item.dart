import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/features/anime/presentation/common/anime_favorite_button.dart';
import 'package:denuanime/features/anime/presentation/common/more_options.dart';
import 'package:denuanime/features/common/presentation/custom_image_network.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';

class FavoritesListItem extends StatelessWidget {
  final AnimeDetailsModel animeDetailsModel;
  final void Function(bool) onPressedFavorite;
  const FavoritesListItem({
    super.key,
    required this.animeDetailsModel,
    required this.onPressedFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          //*image
          CustomImageNetwork(
            animeDetailsModel.images?.jpg?.large_image_url ?? '',
            height: 150,
            width: 100,
          ),
          //* info
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${animeDetailsModel.season ?? '---'} ${animeDetailsModel.year}"
                      .toUpperCase(),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: primaryDark,
                    fontSize: 12,
                  ),
                ),
                Text(
                  animeDetailsModel.title ?? 'Unknown Title',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(Icons.star, color: primary, size: 24),
                    const SizedBox(width: 4),
                    Text(
                      "${animeDetailsModel.score ?? 0.0}",
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall?.copyWith(color: primaryDark),
                    ),
                    const SizedBox(width: 16),

                    if (animeDetailsModel.watch_state == "finished")
                      Chip(
                        materialTapTargetSize: MaterialTapTargetSize
                            .shrinkWrap, // drops the 48px tap area
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                        labelPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),

                        color: const WidgetStatePropertyAll(white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(16),
                        ),
                        label: Row(
                          children: [
                            const Icon(
                              Icons.check,
                              color: background,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "Watched",
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: background,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),

                    if (animeDetailsModel.watch_state == "unfinished")
                      Chip(
                        materialTapTargetSize: MaterialTapTargetSize
                            .shrinkWrap, // drops the 48px tap area
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                        labelPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),

                        color: const WidgetStatePropertyAll(Colors.transparent),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(16),
                        ),
                        label: Row(
                          children: [
                            const Icon(Icons.schedule, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              "Up Next",
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),

                Text("Added ${animeDetailsModel.added_at}"),
              ],
            ),
          ),

          //*favorite button
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MoreOptions(malId: animeDetailsModel.mal_id ?? -1),
              FavoriteButton(
                anime: animeDetailsModel,
                onPressed: onPressedFavorite,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
