import 'package:denuanime/features/anime/domain/entities/recent_episodes_model.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';

class AnimeHorizontalCardItem extends StatelessWidget {
  final RecentEpisodesModel model;

  const AnimeHorizontalCardItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Row(
        children: [
          SizedBox(
            height: 120,
            width: 100,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.network(
                fit: BoxFit.cover,
                model.entry?.images?.jpg?.imageUrl ?? '',
              ),
            ),
          ),

          SizedBox(width: 16),

          Expanded(
            child: Column(
              children: [
                Text(
                  model.entry?.title ?? 'Unknown Title',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                SizedBox(height: 12),

                Row(
                  children:
                      model.episodes
                          ?.map(
                            (episode) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Text(
                                episode.title ?? '',
                                style: TextStyle(color: primary),
                              ),
                            ),
                          )
                          .toList() ??
                      [Text("No recent episodes")],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
