import 'package:denuanime/features/common/presentation/custom_image_network.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchPeopleCardItemsSkeleton extends StatelessWidget {
  const SearchPeopleCardItemsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Card.filled(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //* image
            Skeleton.replace(
              replacement: Bone.square(
                size: 80,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SizedBox(
                width: 90,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(8),
                  child: const CustomImageNetwork('', height: 120),
                ),
              ),
            ),

            const SizedBox(width: 16),
            //*name
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  children: [
                    Icon(Icons.favorite),
                    SizedBox(width: 6),

                    Text("wewrwerwerewrewr"),
                  ],
                ),

                const SizedBox(height: 10),
                Text(
                  '---fwfwfwfwf',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontSize: 18),
                ),
                Text(
                  "---------",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),

            const Spacer(),

            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.keyboard_arrow_right_rounded,
                color: Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
