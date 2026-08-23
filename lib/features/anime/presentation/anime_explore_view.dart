import 'package:denuanime/features/common/presentation/filter_anime_bottom_sheet.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';

class AnimeExploreView extends StatefulWidget {
  const AnimeExploreView({super.key});

  @override
  State<AnimeExploreView> createState() => _AnimeExploreViewState();
}

class _AnimeExploreViewState extends State<AnimeExploreView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Explore")),
      floatingActionButton: IconButton(
        onPressed: () {
          showModalBottomSheet<AnimeFilterBottomSheet>(
            context: context,
            isScrollControlled: true,
            showDragHandle: true,
            backgroundColor: secondary,
            builder: (context) {
              return const AnimeFilterBottomSheet();
            },
          );
        },
        icon: const Icon(Icons.filter_alt),
      ),
    );
  }
}
