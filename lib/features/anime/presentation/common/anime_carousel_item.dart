import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/features/common/presentation/custom_image_network.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';

class AnimeCarouselItem extends StatelessWidget {
  final AnimeDetailsModel animeDetails;
  final bool shouldShowDetails;
  const AnimeCarouselItem({
    super.key,
    required this.animeDetails,
    required this.shouldShowDetails,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Stack(
        children: [
          //* picture
          CustomImageNetwork(
            animeDetails.images?.jpg?.largeImageUrl ?? '',
            height: 500,
          ),

          //* gradient
          Container(
            height: 500,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentGeometry.topCenter,
                end: AlignmentGeometry.bottomCenter,
                colors: [Colors.black12, Colors.black87],
              ),
            ),
          ),

          //*Chips for genre
          if (shouldShowDetails)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Wrap(
                spacing: 4,
                runSpacing: -8,
                children: List.generate(
                  5,
                  (index) => FilterChip(
                    backgroundColor: primarySoft,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(8),
                      side: const BorderSide(color: Colors.transparent),
                    ),
                    padding: EdgeInsets.zero,
                    label: Text(
                      'Adventure',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: secondary,
                        fontSize: 10,
                      ),
                    ),
                    onSelected: (value) {},
                  ),
                ),
              ),
            ),

          //* Details
          if (shouldShowDetails)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    animeDetails.title ?? "---",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    maxLines: 4,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          "${animeDetails.episodes ?? 'Unknown'} eps",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      Flexible(
                        child: Text(
                          animeDetails.status ?? "Unknown",
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      Flexible(
                        child: Text(
                          "${animeDetails.year ?? '0000'}, ${animeDetails.season ?? '---'}",
                          textAlign: TextAlign.end,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          "Score: ${animeDetails.score ?? '---'}",
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "Rank ${animeDetails.rank ?? '---'}",
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          animeDetails.rating ?? 'Unknown Rating',
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
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
