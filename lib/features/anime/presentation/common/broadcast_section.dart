import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';

class BroadcastSection extends StatelessWidget {
  final AnimeDetailsModel animeDetails;
  const BroadcastSection({super.key, required this.animeDetails});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        IntrinsicHeight(
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
                        const SizedBox(height: 6),

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
              const SizedBox(width: 6),
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
              const SizedBox(width: 6),

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
        ),

        //*SOURCE
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: secondary,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "SOURCE",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: primaryLight,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${animeDetails.type ?? '---'}/${animeDetails.source ?? '---'}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        animeDetails.rating ?? '---',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),

                  //*rating
                  const Spacer(),
                  _buildRating(context),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRating(BuildContext context) {
    switch (animeDetails.rating) {
      case "G - All Ages":
        return _RatingLogo(context, "G", "All Ages");

      case "PG - Children":
        return _RatingLogo(context, "PG", "Children");

      case "PG-13 - Teens 13 or older":
        return _RatingLogo(context, "PG-13", "13+");

      case "R - 17+ (violence & profanity)":
        return _RatingLogo(context, "R", "17+");

      case "R+ - Mild Nudity":
        return _RatingLogo(context, "R+", "17+");

      case "Rx - Hentai":
        return _RatingLogo(context, "Rx", "18+");

      default:
        return const Text("Unknown");
    }
  }

  Widget _RatingLogo(BuildContext context, String first, String second) {
    return Container(
      decoration: const BoxDecoration(color: tertiary),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              first,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              second,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
