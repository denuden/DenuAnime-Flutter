import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeSchedulesItemSkeleton extends StatelessWidget {
  const HomeSchedulesItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        children: List.generate(5, (index) {
          return Card.outlined(
            child: Row(
              children: [
                const SizedBox(
                  height: 120,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    child: Bone.square(size: 100),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Unknown Title',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Youtube Trailer"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
