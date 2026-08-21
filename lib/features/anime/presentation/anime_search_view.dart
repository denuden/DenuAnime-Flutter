import 'dart:async';

import 'package:denuanime/features/anime/data/request/search_anime_request.dart';
import 'package:denuanime/features/anime/domain/cubits/anime_cubit.dart';
import 'package:denuanime/features/anime/domain/cubits/anime_state.dart';
import 'package:denuanime/features/anime/presentation/anime_details_view.dart';
import 'package:denuanime/features/common/presentation/custom_image_network.dart';
import 'package:denuanime/features/common/presentation/skeleton/serach_anime_item_skeleton.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimeSearchView extends StatefulWidget {
  const AnimeSearchView({super.key});

  @override
  State<AnimeSearchView> createState() => _AnimeSearchViewState();
}

class _AnimeSearchViewState extends State<AnimeSearchView> {
  late TextEditingController _searchController;

  Timer? _searchTimer;

  //?========= functions
  void searchAnime(String query) {
    context.read<AnimeCubit>().searchAnime(
      SearchAnimeRequest(
        q: query.trim(),
        order_by: "score",
        limit: "50",
        sort: "desc",
      ),
    );
  }

  //? ===== listners
  void _onSearchChanged() {
    _searchTimer?.cancel();

    if (_searchController.text.trim().isEmpty) {
      return;
    }

    _searchTimer = Timer(const Duration(seconds: 2), () {
      final trimmedQuery = _searchController.text.trim();
      //call initial search
      context.read<AnimeCubit>().searchAnime(
        SearchAnimeRequest(q: trimmedQuery, limit: "50"),
      );
    });
  }

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
    _searchController = TextEditingController();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quick Search")),
      body: Column(
        children: [
          //*===== search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              onSubmitted: (value) {
                _searchTimer?.cancel();
                _searchTimer = null;

                searchAnime(value);
              },

              enableInlinePrediction: false,
              autocorrect: false,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 4),
                hint: const Text("Search anime titles"),
                prefixIcon: const Icon(Icons.search),

                filled: true,
                fillColor: Theme.of(context).colorScheme.secondary,

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(color: Colors.white38, width: 2),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(color: primary, width: 2),
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              controller: _searchController,
            ),
          ),
          BlocBuilder<AnimeCubit, AnimeState>(
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    mainAxisExtent: 350,
                    crossAxisSpacing: 4,
                  ),
                  itemCount: anime.length,
                  itemBuilder: (context, index) {
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
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleSmall,
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(color: inversePrimary),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "${data.season?.toUpperCase() ?? '--'}, ${data.year ?? '--'}",

                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
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
        ],
      ),
    );
  }
}
