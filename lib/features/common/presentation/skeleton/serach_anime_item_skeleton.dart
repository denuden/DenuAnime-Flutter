import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SerachAnimeItemSkeleton extends StatelessWidget {
  const SerachAnimeItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Card.filled(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20),
        ),
        child: Column(
          children: [
            //* === imgae
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(8),
              child: Bone.square(
                size: 280,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 16),
            //* ======= Anime titles
            Positioned(
              left: 8,
              right: 8,
              bottom: 12,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'No english title',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: primaryGlow, size: 16),
                      Text(
                        "----",
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: inversePrimary),
                      ),
                      const Spacer(),
                      Text(
                        "${'-=-'}, ${'--='}",

                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          letterSpacing: 0.1,
                          color: inversePrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
