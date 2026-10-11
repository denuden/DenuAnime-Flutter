import 'package:denuanime/features/anime/data/request/favorite_anime_request.dart';
import 'package:denuanime/features/anime/data/request/search_anime_request.dart';
import 'package:denuanime/features/anime/domain/cubits/anime_cubit.dart';
import 'package:denuanime/features/anime/domain/cubits/anime_state.dart';
import 'package:denuanime/features/anime/domain/cubits/favorite_cubit.dart';
import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/features/anime/presentation/anime_details_view.dart';
import 'package:denuanime/features/anime/presentation/common/anime_grid_item.dart';
import 'package:denuanime/features/common/presentation/filter_anime_bottom_sheet.dart';
import 'package:denuanime/features/common/presentation/skeleton/serach_anime_item_skeleton.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:denuanime/utils/core/async_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimeExploreView extends StatefulWidget {
  const AnimeExploreView({super.key});

  @override
  State<AnimeExploreView> createState() => _AnimeExploreViewState();
}

class _AnimeExploreViewState extends State<AnimeExploreView> {
  //* ======== variables
  SearchAnimeRequest? _requestHolder = const SearchAnimeRequest();
  final ScrollController _scrollController = ScrollController();

  //* ======= functions
  void _onNavigateToAnimeDetails(int id) {
    Navigator.of(context).push(AnimeDetailsView.route(id));
  }

  //? ============= function
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
  void initState() {
    super.initState();
    context.read<AnimeCubit>().searchAnime(_requestHolder!);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 400) {
      context.read<AnimeCubit>().loadMoreAnime();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore"),
        actions: [
          IconButton(
            style: const ButtonStyle(
              shape: WidgetStatePropertyAll(CircleBorder()),
            ),
            padding: const EdgeInsets.all(16),
            onPressed: () async {
              final SearchAnimeRequest? request =
                  await showModalBottomSheet<SearchAnimeRequest?>(
                    context: context,
                    isScrollControlled: true,
                    showDragHandle: true,
                    backgroundColor: secondary,
                    builder: (context) {
                      return AnimeFilterBottomSheet(request: _requestHolder!);
                    },
                  );
              if (request != null) {
                _requestHolder = request;

                if (context.mounted) {
                  context.read<AnimeCubit>().searchAnime(_requestHolder!);
                }
              }
            },
            icon: const Icon(Icons.filter_alt),
          ),
        ],
      ),

      body: BlocBuilder<AnimeCubit, AnimeState>(
        buildWhen: (p, c) => p.animes != c.animes,
        builder: (context, state) {
          return switch (state.animes) {
            AsyncIdle() || AsyncLoading() => Expanded(
              child: GridView.count(
                mainAxisExtent: 350,
                mainAxisSpacing: 8,
                crossAxisCount: 2,
                children: List.generate(
                  8,
                  (index) => const SerachAnimeItemSkeleton(),
                ),
              ),
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
              child: Container(
                decoration: BoxDecoration(
                  color: secondary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(50),
                  child: Text("No animes found"),
                ),
              ),
            ),

            //? data list
            AsyncData(:final value) => Expanded(
              child: GridView.builder(
                controller: _scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  mainAxisExtent: 350,
                  crossAxisSpacing: 4,
                ),
                itemCount:
                    value.length +
                    (state.isLoadingMore
                        ? 2
                        : 0), //to show the circular progress indicator
                itemBuilder: (context, index) {
                  if (index >= value.length) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final data = value[index];
                  return AnimeGridItem(
                    data: data,
                    onNavigateToAnimeDetails: _onNavigateToAnimeDetails,
                    onAddtoFavorites: (isFav) {
                      onAddToFavorites(data, isFav);
                    },
                  );
                },
              ),
            ),
          };
        },
      ),
    );
  }
}
