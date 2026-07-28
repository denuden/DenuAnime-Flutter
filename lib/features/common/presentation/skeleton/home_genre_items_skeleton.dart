import 'package:denuanime/features/anime/domain/entities/genre_model.dart';
import 'package:denuanime/features/main/presentation/common/genre_item.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeGenreItemsSkeleton extends StatelessWidget {
  final bool isLoading;
  const HomeGenreItemsSkeleton({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GenreItem(
                onSelect: (value) {},
                genre: const GenreModel(name: "Action"),
              ),
            );
          },
        ),
      ),
    );
  }
}
