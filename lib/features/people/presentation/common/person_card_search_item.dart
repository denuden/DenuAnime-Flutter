import 'package:denuanime/features/common/presentation/custom_image_network.dart';
import 'package:denuanime/features/people/domain/entities/people_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PersonCardSearchItem extends StatelessWidget {
  final PeopleModel peopleModel;
  final void Function() onClick;
  const PersonCardSearchItem({
    super.key,
    required this.peopleModel,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      child: InkWell(
        onTap: onClick,
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
                  child: CustomImageNetwork(
                    peopleModel.images?.jpg?.image_url ?? '',
                    height: 120,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 16),
            //*name
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.favorite),
                      const SizedBox(width: 6),

                      Text(
                        (NumberFormat.decimalPattern().format(
                          peopleModel.favorites ?? 0,
                        )).toString(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Text(
                    peopleModel.name ?? '---',
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(fontSize: 18),
                  ),
                  Text(
                    "${peopleModel.given_name ?? '---'} ${peopleModel.family_name ?? '---'}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),

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
