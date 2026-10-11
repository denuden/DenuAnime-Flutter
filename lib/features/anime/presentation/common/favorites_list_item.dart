import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/features/anime/presentation/common/anime_favorite_button.dart';
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
                    const Icon(Icons.star, color: primary),
                    const SizedBox(width: 8),
                    Text(
                      "${animeDetailsModel.score ?? 0.0}",
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall?.copyWith(color: primaryDark),
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
          FavoriteButton(
            anime: animeDetailsModel,
            onPressed: onPressedFavorite,
          ),
        ],
      ),
    );
  }
}
