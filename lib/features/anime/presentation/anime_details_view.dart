import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/features/anime/domain/entities/genre_model.dart';
import 'package:denuanime/features/common/presentation/custom_image_network.dart';
import 'package:denuanime/features/main/presentation/common/genre_item.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';

class AnimeDetailsView extends StatelessWidget {
  final AnimeDetailsModel animeDetails;
  const AnimeDetailsView({super.key, required this.animeDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Anime Details")),
      body: Column(
        children: [
          //*Header
          Stack(
            children: [
              CustomImageNetwork(
                animeDetails.images?.jpg?.largeImageUrl ?? '',
                height: 300,
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton.filledTonal(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      secondary.withValues(alpha: 0.5),
                    ),
                  ),
                  splashColor: white,
                  onPressed: () {
                    //TODO
                  },
                  icon: const Icon(Icons.open_in_full_rounded, color: white),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          //*Title to description
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                animeDetails.title ?? '---',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 4),
              Text(
                animeDetails.titleJapanese ?? 'No japanese title',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                animeDetails.titleEnglish ?? 'No english title',
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              //* Genre
              Wrap(
                spacing: 6,
                children: List.generate(
                  6,
                  (index) => GenreItem(
                    onSelect: (value) {
                      // list[index].isSelected = value;
                    },
                    genre: const GenreModel(name: "Action", isSelected: false),
                    size: GenreItemSize.small,
                    side: BorderSide.none,
                    backgroundColor: primaryDark,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
