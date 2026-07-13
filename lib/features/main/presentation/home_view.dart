// ignore_for_file: non_constant_identifier_names

import 'package:denuanime/features/anime/domain/entities/aired_model.dart';
import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/features/anime/domain/entities/broadcast_model.dart';
import 'package:denuanime/features/anime/domain/entities/episode_model.dart';
import 'package:denuanime/features/anime/domain/entities/external_model.dart';
import 'package:denuanime/features/anime/domain/entities/genre_model.dart';
import 'package:denuanime/features/anime/domain/entities/licensor_model.dart';
import 'package:denuanime/features/anime/domain/entities/producer_model.dart';
import 'package:denuanime/features/anime/domain/entities/recent_episodes_model.dart';
import 'package:denuanime/features/anime/domain/entities/recommendation_model.dart';
import 'package:denuanime/features/anime/domain/entities/relation_model.dart';
import 'package:denuanime/features/anime/domain/entities/streaming_model.dart';
import 'package:denuanime/features/anime/domain/entities/studio_model.dart';
import 'package:denuanime/features/anime/domain/entities/theme_song_model.dart';
import 'package:denuanime/features/anime/domain/entities/title_model.dart';
import 'package:denuanime/features/anime/domain/entities/trailer_model.dart';
import 'package:denuanime/features/anime/presentation/common/anime_horizontal_card_item.dart';
import 'package:denuanime/features/common/entities/base_image_model.dart';
import 'package:denuanime/features/common/entities/image_type_model.dart';
import 'package:denuanime/features/anime/presentation/common/anime_carousel_item.dart';
import 'package:denuanime/features/common/entities/user_model.dart';
import 'package:denuanime/features/main/presentation/common/drawer_home.dart';
import 'package:denuanime/features/main/presentation/common/dropdown_menu_filter.dart';
import 'package:denuanime/features/main/presentation/common/genre_item.dart';
import 'package:denuanime/features/main/presentation/common/recommendation_item.dart';
import 'package:denuanime/features/people/presentation/common/person_item_view.dart';
import 'package:denuanime/features/people/domain/entities/people_model.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

enum RecentSegmentedButton { recent, ongoing, upcoming }

class _HomeViewState extends State<HomeView> {
  final animeDetails = AnimeDetailsModel(
    malId: 37999,
    url:
        "https://myanimelist.net/anime/37999/Kaguya-sama_wa_Kokurasetai__Tensai-tachi_no_Renai_Zunousen",
    images: ImageTypeModel.fromJson({
      "jpg": {
        "image_url": "https://cdn.myanimelist.net/images/anime/1295/106551.jpg",
        "small_image_url":
            "https://cdn.myanimelist.net/images/anime/1295/106551t.jpg",
        "large_image_url":
            "https://cdn.myanimelist.net/images/anime/1295/106551l.jpg",
      },
      "webp": {
        "image_url":
            "https://cdn.myanimelist.net/images/anime/1295/106551.webp",
        "small_image_url":
            "https://cdn.myanimelist.net/images/anime/1295/106551t.webp",
        "large_image_url":
            "https://cdn.myanimelist.net/images/anime/1295/106551l.webp",
      },
    }),
    trailer: TrailerModel.fromJson({
      "youtube_id": null,
      "url": null,
      "embed_url":
          "https://www.youtube-nocookie.com/embed/Ti2kJ-GYO68?enablejsapi=1&wmode=opaque&autoplay=1",
      "images": {
        "image_url": null,
        "small_image_url": null,
        "medium_image_url": null,
        "large_image_url": null,
        "maximum_image_url": null,
      },
    }),
    approved: true,
    titles: [
      TitleModel(
        type: "Default",
        title: "Kaguya-sama wa Kokurasetai: Tensai-tachi no Renai Zunousen",
      ),
      TitleModel(type: "English", title: "Kaguya-sama: Love is War"),
      TitleModel(type: "Japanese", title: "かぐや様は告らせたい～天才たちの恋愛頭脳戦～"),
    ],
    title: "Kaguya-sama wa Kokurasetai: Tensai-tachi no Renai Zunousen",
    titleEnglish: "Kaguya-sama: Love is War",
    titleJapanese: "かぐや様は告らせたい～天才たちの恋愛頭脳戦～",
    titleSynonyms: [
      "Kaguya Wants to be Confessed To: The Geniuses' War of Love and Brains",
    ],
    type: "TV",
    source: "Manga",
    episodes: 12,
    status: "Finished Airing",
    airing: false,
    aired: AiredModel.fromJson({
      "from": "2019-01-12T00:00:00+00:00",
      "to": "2019-03-30T00:00:00+00:00",
      "string": "Jan 12, 2019 to Mar 30, 2019",
      "prop": {
        "from": {"day": 12, "month": 1, "year": 2019},
        "to": {"day": 30, "month": 3, "year": 2019},
      },
    }),
    duration: "25 min per ep",
    rating: "PG-13 - Teens 13 or older",
    score: 8.4,
    scoredBy: 1221648,
    rank: 229,
    popularity: 51,
    members: 1954770,
    favorites: 42701,
    synopsis:
        "At the renowned Shuchiin Academy, Miyuki Shirogane and Kaguya Shinomiya are the student body's top representatives...",
    background: "",
    season: "winter",
    year: 2019,
    broadcast: BroadcastModel.fromJson({
      "day": "Saturdays",
      "time": "23:30",
      "timezone": "Asia/Tokyo",
      "string": "Saturdays at 23:30 (JST)",
    }),
    producers: [
      ProducerModel(malId: 17, type: "anime", name: "Aniplex"),
      ProducerModel(
        malId: 143,
        type: "anime",
        name: "Mainichi Broadcasting System",
      ),
      ProducerModel(malId: 306, type: "anime", name: "Magic Capsule"),
      ProducerModel(malId: 1365, type: "anime", name: "Shueisha"),
      ProducerModel(
        malId: 1501,
        type: "anime",
        name: "JR East Marketing & Communications",
      ),
    ],
    licensors: [
      LicensorModel(malId: 493, type: "anime", name: "Aniplex of America"),
    ],
    studios: [StudioModel(malId: 56, type: "anime", name: "A-1 Pictures")],
    genres: [
      GenreModel(malId: 4, type: "anime", name: "Comedy"),
      GenreModel(malId: 22, type: "anime", name: "Romance"),
    ],
    explicitGenres: [],
    themes: [GenreModel(malId: 23, type: "anime", name: "School")],
    demographics: [GenreModel(malId: 42, type: "anime", name: "Seinen")],
    relations: [
      RelationModel.fromJson({
        "relation": "Sequel",
        "entry": [
          {
            "mal_id": 40591,
            "type": "anime",
            "name":
                "Kaguya-sama wa Kokurasetai? Tensai-tachi no Renai Zunousen",
            "url":
                "https://myanimelist.net/anime/40591/Kaguya-sama_wa_Kokurasetai_Tensai-tachi_no_Renai_Zunousen",
          },
        ],
      }),
      RelationModel.fromJson({
        "relation": "Adaptation",
        "entry": [
          {
            "mal_id": 90125,
            "type": "manga",
            "name":
                "Kaguya-sama wa Kokurasetai: Tensai-tachi no Renai Zunousen",
            "url":
                "https://myanimelist.net/manga/90125/Kaguya-sama_wa_Kokurasetai__Tensai-tachi_no_Renai_Zunousen",
          },
        ],
      }),
    ],
    theme: ThemeSongModel.fromJson({
      "openings": ["\"Love Dramatic feat. Rikka Ihara\" by Masayuki Suzuki"],
      "endings": [
        "\"Sentimental Crisis\" by halca",
        "\"Chikatto Chika Chika♡\" by Chika Fujiwara",
      ],
    }),
    external: [
      ExternalModel(name: "Official Site", url: "https://kaguya.love/1st/"),
      ExternalModel(
        name: "@anime_kaguya",
        url: "https://twitter.com/anime_kaguya",
      ),
    ],
    streaming: [
      StreamingModel(
        name: "Crunchyroll",
        url: "http://www.crunchyroll.com/series-277391",
      ),
      StreamingModel(name: "Netflix", url: "https://www.netflix.com/"),
    ],
  );
  //? =========== variable
  int _selectedMenuIndex = 0;
  int currentCarouselIndex = 0;
  RecentSegmentedButton recentSegmentedButton = .recent;
  bool isFilterEnabled = true;
  int selectedType = 0;
  int selectedRating = 0;
  //? ============ functions
  void _onMenuSelection(int index) {
    setState(() {
      _selectedMenuIndex = index;
    });

    //* close drawer
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //* ================= appbar
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
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
        slivers: [
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
            padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
            sliver: SliverList.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return AnimeHorizontalCardItem(
                  model: RecentEpisodesModel(
                    entry: animeDetails,
                    episodes: [
                      EpisodeModel(
                        malId: 1,
                        url: "url",
                        title: "Episode 1",
                        premium: true,
                      ),
                      EpisodeModel(
                        malId: 1,
                        url: "url",
                        title: "Episode 2",
                        premium: true,
                      ),
                    ],
                    regionLocked: true,
                  ),
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
            Spacer(),
            TextButton.icon(
              onPressed: () {},
              label: Text("View all"),
              icon: Icon(Icons.keyboard_arrow_right),
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

        SizedBox(
          height: 110,
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: PersonItemView(
                  people: PeopleModel(
                    name: "Tomokazu Seki",
                    birthday: "1972-09-08T00:00:00+00:00",
                    images: ImageTypeModel(
                      jpg: BaseImagesModel(
                        imageUrl:
                            "https://cdn.myanimelist.net/r/84x124/images/characters/7/618735.jpg?s=9902344694bb6579f0f271c3b9729ed0",
                      ),
                    ),
                  ),
                ),
              );
            },
            scrollDirection: Axis.horizontal,
          ),
        ),

        SizedBox(height: 8),
        Divider(thickness: 0.2),
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
              onFilterChanged: (typeIndex, ratingIndex) {
                setState(() {
                  selectedType = typeIndex;
                  selectedRating = ratingIndex;
                });
              },
            ),
            // Text("Filter", style: TextStyle(color: primaryDark)),
            SizedBox(width: 8),

            SizedBox(
              height: 22,
              child: VerticalDivider(
                width: 1,
                thickness: 0.2,
                color: inversePrimary,
              ),
            ),
            SizedBox(width: 8),

            Expanded(
              child: SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GenreItem(
                        onSelect: (value) {
                          // list[index].isSelected = value
                        },
                        genre: GenreModel(
                          name: "Action",
                          isSelected: index == 1 ? true : false,
                        ),
                      ),
                    );
                  },
                ),
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
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 500,
          decoration: BoxDecoration(color: Colors.black),

          child: CarouselView.weighted(
            enableSplash: true,
            backgroundColor: Colors.red,
            itemSnapping: true,
            flexWeights: [6, 1],
            shape: RoundedRectangleBorder(),
            scrollDirection: Axis.horizontal,

            onIndexChanged: (index) {
              setState(() {
                currentCarouselIndex = index;
              });
            },
            children: List<Widget>.generate(10, (int index) {
              return AnimeCarouselItem(
                animeDetails: animeDetails,
                shouldShowDetails: index == currentCarouselIndex,
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _RecommendationSection(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),

        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
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

              Spacer(),
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

        RecommendationItem(
          recommendationModel: RecommendationModel(
            malId: 0,
            entry: [animeDetails, animeDetails],
            content:
                "Similar chill vibes. A lot of focus on the food recipe and preparation itself, sometimes even mentioning some dishes' history and stuff. Instead of Shirou, we have a maid doing it all.",
            date: "",
            user: UserModel(
              url: "https://myanimelist.net/profile/Zm00sp",
              username: "Zm00sp",
            ),
          ),
        ),
        SizedBox(height: 8),

        RecommendationItem(
          recommendationModel: RecommendationModel(
            malId: 0,
            entry: [animeDetails, animeDetails],
            content:
                "Similar chill vibes. A lot of focus on the food recipe and preparation itself, sometimes even mentioning some dishes' history and stuff. Instead of Shirou, we have a maid doing it all.",
            date: "",
            user: UserModel(
              url: "https://myanimelist.net/profile/Zm00sp",
              username: "Zm00sp",
            ),
          ),
        ),
      ],
    );
  }

  Widget _RecentHeaderSection(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12),
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
