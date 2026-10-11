import 'package:denuanime/features/anime/data/request/favorite_anime_request.dart';
import 'package:denuanime/features/anime/domain/cubits/favorite_cubit.dart';
import 'package:denuanime/features/anime/domain/cubits/favorite_state.dart';
import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/features/anime/presentation/anime_details_view.dart';
import 'package:denuanime/features/anime/presentation/common/anime_grid_item.dart';
import 'package:denuanime/features/anime/presentation/common/favorites_list_item.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:denuanime/utils/core/async_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimeFavoritesView extends StatefulWidget {
  final Widget drawer;

  const AnimeFavoritesView({super.key, required this.drawer});

  @override
  State<AnimeFavoritesView> createState() => _AnimeFavoritesViewState();
}

enum ScreenView { list, grid }

class _AnimeFavoritesViewState extends State<AnimeFavoritesView> {
  //? =========== Variables
  ScreenView screenView = .grid;
  int _selectedIndex = 0;

  //? ============= function
  void _onNavigateToAnimeDetails(int id) {
    Navigator.of(context).push(AnimeDetailsView.route(id));
  }

  void onAddToFavorites(AnimeDetailsModel data, bool isFav) {
    context.read<FavoriteCubit>().toggleFavorites(
      FavoriteAnimeRequest(
        mal_id: data.mal_id ?? -1,
        title: (data.title_english ?? data.title) ?? "No Title",
        image_url: data.images?.jpg?.large_image_url ?? '',
        score: data.score ?? 0.0,
        season: data.season ?? '---',
        year: data.year ?? 00,
        isFav: isFav,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final numberOfSaved = context.select((FavoriteCubit c) {
      return c.state.ids.length;
    });

    return Scaffold(
      drawer: widget.drawer,

      appBar: AppBar(
        centerTitle: false,
        title: const Text("Favorites"),
        //* =============== drawer
        actions: [
          SegmentedButton<ScreenView>(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color?>((
                states,
              ) {
                if (states.contains(WidgetState.selected)) return primary;
                return Colors.transparent;
              }),
              foregroundColor: WidgetStateProperty.resolveWith<Color?>((
                states,
              ) {
                if (states.contains(WidgetState.selected)) return Colors.black;
                return white;
              }),
            ),
            segments: const <ButtonSegment<ScreenView>>[
              ButtonSegment<ScreenView>(
                value: ScreenView.grid,
                icon: Icon(Icons.grid_view),
              ),
              ButtonSegment<ScreenView>(
                value: ScreenView.list,
                icon: Icon(Icons.list),
              ),
            ],
            selected: <ScreenView>{screenView},
            onSelectionChanged: (Set<ScreenView> newSelection) {
              setState(() {
                screenView = newSelection.first;
              });
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //*Header
            Row(
              children: [
                Text(
                  "$numberOfSaved saved",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: inversePrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                const Text("Synced across devices"),
              ],
            ),
            const SizedBox(height: 12),
            //*Chips
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 8,
              children: [
                Chip(
                  label: Text(
                    "Recently Added",
                    style: TextStyle(
                      color: _selectedIndex == 0 ? Colors.black : Colors.white,
                    ),
                  ),
                  backgroundColor: _selectedIndex == 0
                      ? primary
                      : Colors.transparent,
                ),
                Chip(
                  label: Text(
                    "Top score",
                    style: TextStyle(
                      color: _selectedIndex == 1 ? Colors.black : Colors.white,
                    ),
                  ),
                  backgroundColor: _selectedIndex == 1
                      ? primary
                      : Colors.transparent,
                ),
                Chip(
                  label: Text(
                    "A-Z",
                    style: TextStyle(
                      color: _selectedIndex == 2 ? Colors.black : Colors.white,
                    ),
                  ),
                  backgroundColor: _selectedIndex == 2
                      ? primary
                      : Colors.transparent,
                ),
                Chip(
                  label: Text(
                    "Finished",
                    style: TextStyle(
                      color: _selectedIndex == 3 ? Colors.black : Colors.white,
                    ),
                  ),
                  backgroundColor: _selectedIndex == 3
                      ? primary
                      : Colors.transparent,
                ),
                Chip(
                  label: Text(
                    "Up Next",
                    style: TextStyle(
                      color: _selectedIndex == 4 ? Colors.black : Colors.white,
                    ),
                  ),
                  backgroundColor: _selectedIndex == 4
                      ? primary
                      : Colors.transparent,
                ),
              ],
            ),

            //* list
            const SizedBox(height: 16),
            BlocBuilder<FavoriteCubit, FavoriteState>(
              builder: (context, state) {
                return switch (state.favorites) {
                  AsyncIdle() || AsyncLoading() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  AsyncFailure(:final message) => Padding(
                    padding: const EdgeInsets.only(top: 42.0),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: tertiary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsGeometry.all(60),
                          child: Text(message),
                        ),
                      ),
                    ),
                  ),

                  AsyncData(:final value) when value.isEmpty => Center(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: BoxBorder.all(color: primary, width: 1),
                          ),
                          child: const Padding(
                            padding: EdgeInsetsGeometry.all(24),
                            child: Icon(Icons.favorite_outline, color: primary),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "No favorites yet",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),

                        Text(
                          "Tap the heart on any anime to keep it here. Your list syncs to your account.",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 24),
                        FilledButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              const Icon(Icons.explore, color: background),
                              Text(
                                "Explore Anime",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: background,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  AsyncData(:final value) => Expanded(
                    child: switch (screenView) {
                      ScreenView.list => ListView.builder(
                        itemCount: value.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final data = value[index];
                          return FavoritesListItem(
                            animeDetailsModel: data,
                            onPressedFavorite: (isFav) =>
                                onAddToFavorites(data, isFav),
                          );
                        },
                      ),
                      ScreenView.grid => GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              mainAxisExtent: 350,
                              crossAxisSpacing: 4,
                            ),
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          final data = value[index];
                          return AnimeGridItem(
                            data: data,
                            onNavigateToAnimeDetails: _onNavigateToAnimeDetails,
                            onAddtoFavorites: (isFav) =>
                                onAddToFavorites(data, isFav),
                          );
                        },
                      ),
                    },
                  ),
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}
