// ignore_for_file: non_constant_identifier_names

import 'package:denuanime/features/anime/data/request/get_recommendations_request.dart';
import 'package:denuanime/features/anime/data/request/search_anime_request.dart';
import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/features/anime/domain/entities/recent_episodes_model.dart';
import 'package:denuanime/features/anime/presentation/anime_details_view.dart';
import 'package:denuanime/features/anime/presentation/common/anime_horizontal_card_item.dart';
import 'package:denuanime/features/anime/presentation/common/anime_carousel_item.dart';
import 'package:denuanime/features/common/presentation/skeleton/home_carousel_items_skeleton.dart';
import 'package:denuanime/features/common/presentation/skeleton/home_genre_items_skeleton.dart';
import 'package:denuanime/features/common/presentation/skeleton/home_people_items_skeleton.dart';
import 'package:denuanime/features/common/presentation/skeleton/home_recommendation_items_skeleton.dart';
import 'package:denuanime/features/common/presentation/skeleton/home_schedules_item_skeleton.dart';
import 'package:denuanime/features/main/presentation/common/drawer_home.dart';
import 'package:denuanime/features/main/presentation/common/dropdown_menu_filter.dart';
import 'package:denuanime/features/main/presentation/common/genre_item.dart';
import 'package:denuanime/features/main/presentation/common/recommendation_item.dart';
import 'package:denuanime/features/people/data/request/search_people_request.dart';
import 'package:denuanime/features/anime/domain/cubits/anime_cubit.dart';
import 'package:denuanime/features/anime/domain/cubits/anime_state.dart';
import 'package:denuanime/features/people/domain/repositories/people_repo.dart';
import 'package:denuanime/features/people/presentation/common/person_avatar_item_.dart';
import 'package:denuanime/features/people/domain/cubits/people_cubit.dart';
import 'package:denuanime/features/people/domain/cubits/people_state.dart';
import 'package:denuanime/features/people/presentation/person_details_view.dart';
import 'package:denuanime/features/people/presentation/search_person_view.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

enum RecentSegmentedButton { recent, ongoing, upcoming }

class _HomeViewState extends State<HomeView> {
  //? =========== variable
  int _selectedMenuIndex = 0;
  int currentCarouselIndex = 0;
  RecentSegmentedButton recentSegmentedButton = .recent;
  bool isFilterEnabled = true;
  int selectedType = 0;
  int selectedRating = 0;
  int selectedStatus = 0;
  int selectedOrder = 0;
  bool selectedSort = false; // false is asc, true is desc

  var filteredGenre = '';
  //? ============ functions

  void _onMenuSelection(int index) {
    setState(() {
      _selectedMenuIndex = index;
    });

    //* close drawer
    Navigator.pop(context);
  }

  void _onNavigateToAnimeDetails(AnimeDetailsModel animeDetails) {
    Navigator.of(context).push(
      MaterialPageRoute<AnimeDetailsView>(
        builder: (context) => AnimeDetailsView(id: animeDetails.mal_id ?? -1),
      ),
    );
  }

  void _onNavigateToPeopleDetails(int id) {
    Navigator.of(context).push(
      MaterialPageRoute<PersonDetailsView>(
        builder: (context) => PersonDetailsView(id: id),
      ),
    );
  }

  void _onNavigateToSearchPerson() {
    Navigator.of(context).push(
      MaterialPageRoute<SearchPersonView>(
        builder: (context) => BlocProvider(
          create: (_) => PeopleCubit(peopleRepo: context.read<PeopleRepo>())
            ..searchPeople(
              const SearchPeopleRequest(order_by: "favorites", sort: "desc"),
            ),
          child: const SearchPersonView(),
        ),
      ),
    );
  }

  String _toggleGenreSelection(int mal_id, bool selected) {
    return context.read<AnimeCubit>().toggleGenre(mal_id, selected);
  }

  void _searchAnime() {
    setState(() {
      currentCarouselIndex = 0;
    });
    final type = DropdownMenuFilter.typeApiValues[selectedType];
    final rating = DropdownMenuFilter.ratingApiValues[selectedRating];
    final status = DropdownMenuFilter.statusApiValues[selectedStatus];
    final order = DropdownMenuFilter.orderApiValues[selectedOrder];

    context.read<AnimeCubit>().searchAnime(
      SearchAnimeRequest(
        type: type.isEmpty ? null : type,
        rating: rating.isEmpty ? null : rating,
        status: status.isEmpty ? null : status,
        genres: filteredGenre,
        order_by: order.isEmpty ? null : order,
        limit: "25",
        sort: selectedSort ? "desc" : "asc",
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //call people list
    context.read<PeopleCubit>().searchPeople(
      const SearchPeopleRequest(
        order_by: "favorites",
        limit: "25",
        sort: "desc",
      ),
    );

    //call genre list
    context.read<AnimeCubit>().getAllGenres();

    // call anime list
    context.read<AnimeCubit>().searchAnime(
      const SearchAnimeRequest(
        type: "tv",
        order_by: "popularity",
        limit: "10",
        sort: "asc",
      ),
    );

    //call recommendataions
    context.read<AnimeCubit>().getAllRecommendations(
      const GetRecommendationsRequest(limit: "2", sfw: "true"),
    );

    //emit loading only
    context.read<AnimeCubit>().setLatestSchedulesToLoading();
    //call episodes schedules
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      context.read<AnimeCubit>().getLatestSchedules();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //* ================= appbar
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
        ],
      ),
      //* =============== drawer
      drawer: HomeDrawer(
        selected: _selectedMenuIndex,
        onSelect: (index) {
          _onMenuSelection(index);
        },
      ),

      //* ============== body
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          //*--------------- Refresher
          CupertinoSliverRefreshControl(
            refreshTriggerPullDistance: 180,

            onRefresh: () async {
              //call people list
              context.read<PeopleCubit>().searchPeople(
                const SearchPeopleRequest(
                  order_by: "favorites",
                  limit: "25",
                  sort: "desc",
                ),
              );

              //call genre list
              context.read<AnimeCubit>().getAllGenres();

              // call anime list
              context.read<AnimeCubit>().searchAnime(
                const SearchAnimeRequest(
                  type: "tv",
                  order_by: "popularity",
                  limit: "10",
                  sort: "asc",
                ),
              );

              //call recommendataions
              context.read<AnimeCubit>().getAllRecommendations(
                const GetRecommendationsRequest(limit: "2", sfw: "true"),
              );

              //emit loading only
              context.read<AnimeCubit>().setLatestSchedulesToLoading();
              //call episodes schedules
              Future.delayed(const Duration(seconds: 3), () {
                if (!context.mounted) return;

                context.read<AnimeCubit>().getLatestSchedules();
              });
            },
          ),
          //*-------------- People List
          SliverToBoxAdapter(child: _TopPeopleSection(context)),
          //* ---------------------- Filter
          SliverToBoxAdapter(child: _FilterSection(context)),

          //* ----------------- Carousel
          SliverToBoxAdapter(child: _CarouselSection(context)),

          //* -------------- Recommendation
          SliverToBoxAdapter(child: _RecommendationSection(context)),

          //* -------------------- Recents
          SliverToBoxAdapter(child: _RecentHeaderSection(context)),
          SliverPadding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 8),
            sliver: BlocBuilder<AnimeCubit, AnimeState>(
              builder: (context, state) {
                if (state.isLatestSchedulesLoading) {
                  return const SliverToBoxAdapter(
                    child: HomeSchedulesItemSkeleton(),
                  );
                }

                if (state.latestSchedulesListError.isNotEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text(state.latestSchedulesListError)),
                  );
                }

                final schedules = state.latestSchedulesList;
                return SliverList.builder(
                  itemCount: schedules.length,
                  itemBuilder: (context, index) {
                    return AnimeHorizontalCardItem(
                      model: RecentEpisodesModel(
                        entry: schedules[index],
                        episodes: [],
                        region_locked: true,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          //*===== END COLUMN
        ],
      ),
    );
  }

  Widget _TopPeopleSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "TOP PEOPLE",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () {
                _onNavigateToSearchPerson();
              },
              label: const Text("View all"),
              icon: const Icon(Icons.keyboard_arrow_right),
              iconAlignment: IconAlignment.end,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                minimumSize: const Size(
                  0,
                  0,
                ), // removes default min constraints
              ),
            ),
          ],
        ),

        BlocBuilder<PeopleCubit, PeopleState>(
          builder: (context, state) {
            //* Bloc builder
            if (state.isPeopleLoading) {
              return const SizedBox(
                height: 120,
                child: HomePeopleItemsSkeleton(isLoading: true),
              );
            }
            if (state.peopleListError.isNotEmpty) {
              SizedBox(
                height: 120,
                width: 400,
                child: Text(state.peopleListError),
              );
            }
            return SizedBox(
              height: 120,
              child: ListView.builder(
                itemCount: state.peopleList.length,
                itemBuilder: (context, index) {
                  final person = state.peopleList[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        _onNavigateToPeopleDetails(person.mal_id ?? -1);
                      },
                      child: PersonItemView(people: person),
                    ),
                  );
                },
                scrollDirection: Axis.horizontal,
              ),
            );
          },
        ),

        const Divider(thickness: 0.2),
      ],
    );
  }

  Widget _FilterSection(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            DropdownMenuFilter(
              enabled: isFilterEnabled,
              selectedType: selectedType,
              selectedRating: selectedRating,
              selectedStatus: selectedStatus,
              selectedOrder: selectedOrder,
              sortSwitch: selectedSort,
              onFilterChanged:
                  (typeIndex, ratingIndex, statusIndex, orderIndex) {
                    setState(() {
                      selectedType = typeIndex;
                      selectedRating = ratingIndex;
                      selectedStatus = statusIndex;
                      selectedOrder = orderIndex;
                      _searchAnime();
                    });
                  },
              onSwitch: (value) {
                setState(() {
                  selectedSort = value;
                  _searchAnime();
                });
              },
            ),
            // Text("Filter", style: TextStyle(color: primaryDark)),
            const SizedBox(width: 8),

            const SizedBox(
              height: 22,
              child: VerticalDivider(
                width: 1,
                thickness: 0.2,
                color: inversePrimary,
              ),
            ),
            const SizedBox(width: 8),

            Expanded(
              child: BlocBuilder<AnimeCubit, AnimeState>(
                builder: (context, state) {
                  if (state.isGenreLoading) {
                    return const HomeGenreItemsSkeleton(isLoading: true);
                  }
                  if (state.genreListError.isNotEmpty) {
                    return Text(state.genreListError);
                  }
                  return SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.genresList.length,
                      itemBuilder: (context, index) {
                        final genre = state.genresList[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GenreItem(
                            size: GenreItemSize.small,
                            selectedBackgroundColor: primary,
                            onSelect: (value) {
                              filteredGenre = _toggleGenreSelection(
                                genre.mal_id!,
                                value,
                              );
                              _searchAnime();
                            },
                            genre: genre,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _CarouselSection(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 500,
          decoration: const BoxDecoration(color: Colors.black),

          child: BlocBuilder<AnimeCubit, AnimeState>(
            builder: (context, state) {
              if (state.isAnimeLoading) {
                return const HomeCarouselItemsSkeleton(isLoading: true);
              }
              if (state.animeListError.isNotEmpty) {
                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: secondary,
                      borderRadius: BorderRadius.circular(16),
                    ),

                    child: const Padding(
                      padding: EdgeInsetsGeometry.all(50),
                      child: Text("No animes found"),
                    ),
                  ),
                );
              }
              return CarouselView.weighted(
                enableSplash: true,
                onTap: (index) =>
                    _onNavigateToAnimeDetails(state.animesList[index]),
                backgroundColor: Colors.red,
                itemSnapping: true,
                flexWeights: [6, 1],
                shape: const RoundedRectangleBorder(),
                scrollDirection: Axis.horizontal,

                onIndexChanged: (index) {
                  setState(() {
                    currentCarouselIndex = index;
                  });
                },
                children: List<Widget>.generate(state.animesList.length, (
                  int index,
                ) {
                  return AnimeCarouselItem(
                    animeDetails: state.animesList[index],
                    shouldShowDetails: index == currentCarouselIndex,
                  );
                }),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _RecommendationSection(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),

        Padding(
          padding: const EdgeInsetsGeometry.symmetric(horizontal: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recommendations",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: white),
                  ),
                  Text(
                    "You might be interested in",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),

              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(0, 36),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                ),
                onPressed: () {},
                child: const Text("Explore"),
              ),
            ],
          ),
        ),

        BlocBuilder<AnimeCubit, AnimeState>(
          builder: (context, state) {
            if (state.isRecommendationLoading) {
              return const HomeRecommendationItemsSkeleton(isLoading: true);
            }

            if (state.recommendationListError.isNotEmpty) {
              return Center(child: Text(state.recommendationListError));
            }

            final recommendations = state.recommendationList;

            return Column(
              children: List.generate(recommendations.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: RecommendationItem(
                    recommendationModel: recommendations[index],
                  ),
                );
              }),
            );
          },
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _RecentHeaderSection(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
          child: SegmentedButton<RecentSegmentedButton>(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color?>((
                states,
              ) {
                if (states.contains(WidgetState.selected)) {
                  return primary;
                }
                return Colors.transparent;
              }),
            ),

            segments: const <ButtonSegment<RecentSegmentedButton>>[
              ButtonSegment<RecentSegmentedButton>(
                value: RecentSegmentedButton.recent,
                label: Text("Recent Episodes"),
              ),
              ButtonSegment<RecentSegmentedButton>(
                value: RecentSegmentedButton.ongoing,
                label: Text("Ongoing Seasons"),
              ),
              ButtonSegment<RecentSegmentedButton>(
                value: RecentSegmentedButton.upcoming,
                label: Text("Upcoming Seasons"),
              ),
            ],
            selected: {recentSegmentedButton},
            onSelectionChanged: (Set<RecentSegmentedButton> newSelection) {
              setState(() {
                recentSegmentedButton = newSelection.first;
              });
            },
          ),
        ),
      ],
    );
  }
}
