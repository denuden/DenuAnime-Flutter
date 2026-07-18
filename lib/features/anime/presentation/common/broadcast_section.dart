import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';

class BroadcastSection extends StatelessWidget {
  final AnimeDetailsModel animeDetails;
  const BroadcastSection({super.key, required this.animeDetails});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      //* ==== broadcast cards
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 4,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.calendar_today_rounded),
                    const SizedBox(height: 8),
                    Text(
                      "BROADCAST",
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),

                    Text(
                      animeDetails.broadcast?.string ?? '-----',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 4,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.video_collection_rounded),
                    const SizedBox(height: 8),
                    Text(
                      "EPISODES",
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),

                    Text(
                      "${animeDetails.episodes ?? 0}",
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),

          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 4,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.access_time_filled_rounded),
                    const SizedBox(height: 8),
                    Text(
                      "DURATION",
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),

                    Text(
                      "${animeDetails.duration ?? 0}",
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
