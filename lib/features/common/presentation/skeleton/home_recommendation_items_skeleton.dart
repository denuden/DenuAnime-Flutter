import 'package:denuanime/features/anime/domain/entities/recommendation_model.dart';
import 'package:denuanime/features/common/entities/user_model.dart';
import 'package:denuanime/features/main/presentation/common/recommendation_item.dart';
import 'package:denuanime/json/anime_details.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeRecommendationItemsSkeleton extends StatelessWidget {
  final bool isLoading;
  const HomeRecommendationItemsSkeleton({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: RecommendationItem(
        recommendationModel: RecommendationModel(
          mal_id: "0",
          entry: [animeDetailsSample, animeDetailsSample],
          content:
              "Similar chill vibes. A lot of focus on the food recipe and preparation itself, sometimes even mentioning some dishes' history and stuff. Instead of Shirou, we have a maid doing it all.",
          date: "",
          user: const UserModel(
            url: "https://myanimelist.net/profile/Zm00sp",
            username: "Zm00sp",
          ),
        ),
      ),
    );
  }
}
