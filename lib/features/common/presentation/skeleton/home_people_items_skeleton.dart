import 'package:denuanime/features/people/domain/entities/people_model.dart';
import 'package:denuanime/features/people/presentation/common/person_avatar_item_.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePeopleItemsSkeleton extends StatelessWidget {
  final bool isLoading;
  const HomePeopleItemsSkeleton({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {},
              child: const PersonItemView(
                people: PeopleModel(
                  name: "Shinomiya, Kaguya",
                  favorites: 405231,
                ),
              ),
            ),
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
