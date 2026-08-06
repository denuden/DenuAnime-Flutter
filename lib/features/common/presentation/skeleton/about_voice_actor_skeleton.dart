import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AboutVoiceActorSkeleton extends StatelessWidget {
  const AboutVoiceActorSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Card.outlined(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: textHint),
          borderRadius: BorderRadiusGeometry.circular(20),
        ),
        color: secondary,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.info_outline, color: primaryGlow),
                  const SizedBox(width: 8),
                  Text(
                    "About the Voice Actor/Actress",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: inversePrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    "Birthda",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: white, height: 1.5),
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      //GO to person page
                    },
                    child: Text(
                      "See more",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
