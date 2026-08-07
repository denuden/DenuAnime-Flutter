import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AnimeVerticalCardItem extends StatelessWidget {
  final AnimeDetailsModel animeDetailsModel;
  final bool isFromRecommendationEndpoint;
  const AnimeVerticalCardItem({
    super.key,
    required this.animeDetailsModel,
    required this.isFromRecommendationEndpoint,
  });

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      color: tertiary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          //*image
          SizedBox(
            height: 160,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(12),
              child: Image.network(
                fit: BoxFit.cover,
                animeDetailsModel.images?.jpg?.image_url ?? '',
              ),
            ),
          ),
          const SizedBox(height: 12),
          //*title
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  animeDetailsModel.title ?? 'Unknown Title',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (isFromRecommendationEndpoint)
                  TextButton(
                    onPressed: () {
                      //TODO
                    },
                    child: const Text("Learn more"),
                  ),

                if (!isFromRecommendationEndpoint)
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_rounded, size: 16),
                      const SizedBox(width: 8),
                      Text('${animeDetailsModel.year ?? '---'}'),
                    ],
                  ),
                if (!isFromRecommendationEndpoint)
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
