import 'package:denuanime/features/anime/presentation/common/anime_carousel_item.dart';
import 'package:denuanime/json/anime_details.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeCarouselItemsSkeleton extends StatelessWidget {
  final bool isLoading;
  const HomeCarouselItemsSkeleton({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: CarouselView.weighted(
        enableSplash: true,
        itemSnapping: true,
        flexWeights: [6, 1],
        shape: const RoundedRectangleBorder(),
        scrollDirection: Axis.horizontal,
        children: List<Widget>.generate(4, (int index) {
          return AnimeCarouselItem(
            animeDetails: animeDetailsSample,
            shouldShowDetails: true,
          );
        }),
      ),
    );
  }
}
