import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/features/anime/presentation/common/anime_favorite_button.dart';
import 'package:denuanime/features/common/presentation/custom_image_network.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';

class AnimeGridItem extends StatelessWidget {
  final AnimeDetailsModel data;
  final void Function(int) onNavigateToAnimeDetails;
  final void Function(bool) onAddtoFavorites;

  const AnimeGridItem({
    super.key,
    required this.data,
    required this.onNavigateToAnimeDetails,
    required this.onAddtoFavorites,
  });

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(20),
      ),
      child: InkWell(
        onTap: () {
          onNavigateToAnimeDetails(data.mal_id ?? -1);
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            //* === imgae
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(8),
              child: CustomImageNetwork(
                data.images?.jpg?.large_image_url ?? '',
                height: 350,
              ),
            ),

            //* ==== gradient black
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black87],
                  stops: [0.4, 1],
                ),
              ),
            ),

            //* ======= favorites button
            Positioned(
              right: 8,
              top: 8,
              child: FavoriteButton(
                anime: data,
                onPressed: (isFav) {
                  onAddtoFavorites(isFav);
                },
              ),
            ),

            //* ======= Anime titles
            Positioned(
              left: 8,
              right: 8,
              bottom: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (data.title_english ?? data.title) ?? 'No english title',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: primaryGlow, size: 16),
                      Text(
                        data.score.toString(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: primarySoft,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "${data.season?.toUpperCase() ?? '--'}, ${data.year ?? '--'}",

                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          letterSpacing: 0.1,
                          color: primarySoft,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
