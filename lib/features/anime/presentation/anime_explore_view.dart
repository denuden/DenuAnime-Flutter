import 'package:denuanime/features/anime/data/request/search_anime_request.dart';
import 'package:denuanime/features/anime/domain/cubits/anime_cubit.dart';
import 'package:denuanime/features/anime/domain/cubits/anime_state.dart';
import 'package:denuanime/features/anime/presentation/anime_details_view.dart';
import 'package:denuanime/features/common/presentation/custom_image_network.dart';
import 'package:denuanime/features/common/presentation/filter_anime_bottom_sheet.dart';
import 'package:denuanime/features/common/presentation/skeleton/serach_anime_item_skeleton.dart';
import 'package:denuanime/theme/dark_mode.dart';
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
    Navigator.of(context).push(
      MaterialPageRoute<AnimeDetailsView>(
        builder: (context) => AnimeDetailsView(id: id),
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
        builder: (context, state) {
          if (state.isAnimeLoading) {
            return Expanded(
              child: GridView.count(
                mainAxisExtent: 350,
                mainAxisSpacing: 8,
                crossAxisCount: 2,
                children: List.generate(
                  8,
                  (index) => const SerachAnimeItemSkeleton(),
                ),
              ),
            );
          }

          if (state.animeListError.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 42.0),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: tertiary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsGeometry.all(60),
                    child: Text(state.animeListError),
                  ),
                ),
              ),
            );
          }

          final anime = state.animesList;
          return Expanded(
            child: GridView.builder(
              controller: _scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                mainAxisExtent: 350,
                crossAxisSpacing: 4,
              ),
              itemCount:
                  anime.length +
                  (state.isLoadingMore
                      ? 2
                      : 0), //to show the circular progress indicator
              itemBuilder: (context, index) {
                if (index >= anime.length) {
                  return const Center(child: CircularProgressIndicator());
                }

                final data = anime[index];
                return Card.filled(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(20),
                  ),
                  child: InkWell(
                    onTap: () {
                      _onNavigateToAnimeDetails(data.mal_id ?? -1);
                    },
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        //* === imgae
                        ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(8),
                          child: CustomImageNetwork(
                            data.images?.jpg?.large_image_url ?? '',
                            height: 350,
                          ),
                        ),

                        //* ==== gradient black
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black87],
                              stops: [0.4, 1],
                            ),
                          ),
                        ),

                        //* ======= Anime titles
                        Positioned(
                          left: 8,
                          right: 8,
                          bottom: 12,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.title_english ?? 'No english title',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: primaryGlow,
                                    size: 16,
                                  ),
                                  Text(
                                    data.score.toString(),
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(color: inversePrimary),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "${data.season?.toUpperCase() ?? '--'}, ${data.year ?? '--'}",

                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
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
              },
            ),
          );
        },
      ),
    );
  }
}
