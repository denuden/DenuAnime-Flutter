import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
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
      height: 400,
      child: Stack(
        children: [
          //* picture
          SizedBox(
            height: 400,
            width: double.infinity,
            child: Image.network(
              fit: BoxFit.cover,
              animeDetails.images?.jpg?.largeImageUrl ?? '',
            ),
          ),

          //* gradient
          Container(
            height: 400,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentGeometry.topCenter,
                end: AlignmentGeometry.bottomCenter,
                colors: [Colors.black12, Colors.black87],
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
                  SizedBox(height: 16),
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
                  SizedBox(height: 4),
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
