import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AnimeVerticalCardItem extends StatelessWidget {
  final AnimeDetailsModel animeDetailsModel;
  const AnimeVerticalCardItem({super.key, required this.animeDetailsModel});

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      color: tertiary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 160,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadiusGeometry.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.network(
                fit: BoxFit.cover,
                animeDetailsModel.images?.jpg?.imageUrl ?? '',
              ),
            ),
          ),
          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16),
            child: Column(
              children: [
                Text(
                  animeDetailsModel.title ?? 'Unknown Title',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(Icons.calendar_today_rounded, size: 16),
                    const SizedBox(width: 8),
                    Text('${animeDetailsModel.year ?? '---'}'),
                  ],
                ),
                Row(
                  children: [
                    RatingBarIndicator(
                      rating: (animeDetailsModel.score ?? 0.0) / 2,
                      itemBuilder: (context, index) =>
                          const Icon(Icons.star, color: Colors.amber),
                      itemCount: 5,
                      itemSize: 16,
                    ),
                    const SizedBox(width: 8),

                    Text('${animeDetailsModel.score ?? '0.0'}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
