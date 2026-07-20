import 'package:denuanime/features/anime/domain/entities/recommendation_model.dart';
import 'package:denuanime/features/anime/presentation/common/anime_vertical_card_item.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';

class RecommendationItem extends StatelessWidget {
  final RecommendationModel recommendationModel;
  const RecommendationItem({super.key, required this.recommendationModel});

  @override
  Widget build(BuildContext context) {
    return recommendationModel.entry?.isNotEmpty == true &&
            recommendationModel.entry?.length == 2
        ? Card.filled(
            color: tertiary,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: AnimeVerticalCardItem(
                          animeDetailsModel: recommendationModel.entry![0],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: AnimeVerticalCardItem(
                          animeDetailsModel: recommendationModel.entry![1],
                        ),
                      ),
                    ],
                  ),

                  const Divider(height: 1, thickness: 0.2),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: BoxBorder.all(width: 0.3, color: white),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.lightbulb_outlined,
                              color: primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Why we recommended this",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              Text(
                                "Credits to: ${recommendationModel.user?.url ?? '---'}",
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: primarySoft,
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "Similar chill vibes. A lot of focus on the food recipe and preparation itself, sometimes even mentioning some dishes' history and stuff. Instead of Shirou, we have a maid doing it all.",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          )
        : const Text('No entry found for recommendation');
  }
}
