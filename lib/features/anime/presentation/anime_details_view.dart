// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:math';

import 'package:denuanime/features/anime/data/request/get_anime_details_full_request.dart';
import 'package:denuanime/features/anime/domain/cubits/anime_cubit.dart';
import 'package:denuanime/features/anime/domain/cubits/anime_state.dart';
import 'package:denuanime/features/anime/domain/entities/anime_characters_model.dart';
import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/features/anime/presentation/common/anime_external_info_section.dart';
import 'package:denuanime/features/anime/presentation/common/broadcast_section.dart';
import 'package:denuanime/features/anime/presentation/common/scores_section.dart';
import 'package:denuanime/features/anime/presentation/common/sypnosis_section.dart';
import 'package:denuanime/features/common/presentation/custom_image_network.dart';
import 'package:denuanime/features/common/presentation/skeleton/anime_details_characters_items_skeleton.dart';
import 'package:denuanime/features/common/presentation/skeleton/anime_details_view_skeleton.dart';
import 'package:denuanime/features/main/presentation/common/genre_item.dart';
import 'package:denuanime/features/people/presentation/common/person_card_with_character_item.dart';
import 'package:denuanime/json/anime_character.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:denuanime/utils/app_web_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:photo_opener/photo_opener.dart';

class AnimeDetailsView extends StatefulWidget {
  final int id;
  const AnimeDetailsView({super.key, required this.id});

  @override
  State<AnimeDetailsView> createState() => _AnimeDetailsViewState();
}

class _AnimeDetailsViewState extends State<AnimeDetailsView> {
  final AnimeCharactersModel animeCharactersModel =
      AnimeCharactersModel.fromJson(
        jsonDecode(anime_character_json) as Map<String, dynamic>,
      );

  final ScrollController _controller = ScrollController();
  bool _showFab = false;

  //? ============= function
  @override
  void initState() {
    context.read<AnimeCubit>().getAnimeDetailsFull(
      GetAnimeDetailsFullRequest(id: widget.id),
    );
    context.read<AnimeCubit>().getAnimeCharacters(
      GetAnimeDetailsFullRequest(id: widget.id),
    );

    //* jump back to top
    _controller.addListener(() {
      final show = _controller.offset > 2000; // adjust threshold

      if (show != _showFab) {
        setState(() {
          _showFab = show;
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //*? ============ widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Anime Details")),
      floatingActionButton: _showFab
          ? FloatingActionButton(
              onPressed: () {
                _controller.animateTo(
                  0,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOut,
                );
              },
              child: const Icon(Icons.arrow_upward),
            )
          : null,
      body: BlocBuilder<AnimeCubit, AnimeState>(
        builder: (context, state) {
          if (state.isAnimeDetailsLoading) {
            return AnimeDetailsViewSkeleton(isLoading: true);
          }

          if (state.animeDetailsError.isNotEmpty) {
            return const Center(child: Text("Anime not found."));
          }

          final animeDetails = state.animeDetails;
          return Stack(
            children: [
              //* ======== body
              CustomScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                controller: _controller,
                slivers: [
                  //* --  refresher
                  CupertinoSliverRefreshControl(
                    refreshTriggerPullDistance: 180,
                    onRefresh: () async {
                      context.read<AnimeCubit>().getAnimeDetailsFull(
                        GetAnimeDetailsFullRequest(id: widget.id),
                      );
                      context.read<AnimeCubit>().getAnimeCharacters(
                        GetAnimeDetailsFullRequest(id: widget.id),
                      );
                    },
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //*Header
                        Stack(
                          children: [
                            CustomImageNetwork(
                              animeDetails.images?.jpg?.large_image_url ?? '',
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
                                  //? open photo
                                  onOpenPhoto(
                                    context: context,
                                    images: [
                                      animeDetails
                                              .images
                                              ?.jpg
                                              ?.large_image_url ??
                                          '',
                                    ],
                                    type: PhotoType.network,
                                  );
                                },
                                icon: const Icon(
                                  Icons.open_in_full_rounded,
                                  color: white,
                                ),
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
                              animeDetails.title_english ?? 'No english title',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              animeDetails.title_japanese ??
                                  'No japanese title',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              animeDetails.title ?? '---',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),

                            //* Genre
                            Wrap(
                              spacing: 6,
                              children: List.generate(
                                animeDetails.genres?.length ?? 0,
                                (index) => GenreItem(
                                  onSelect: (value) {
                                    //Not needed
                                  },
                                  genre: animeDetails.genres![index],
                                  size: GenreItemSize.small,
                                  side: BorderSide.none,
                                  backgroundColor: primaryDark,
                                ),
                              ),
                            ),

                            //* Description
                            SypnosisSection(
                              synopsis: animeDetails.synopsis ?? 'Nondescript',
                            ),

                            //* other info
                            _OtherInfo(context, animeDetails),

                            //* External info
                            const SizedBox(height: 24),
                            AnimeExternalInfoSection(
                              data: animeDetails,
                              onTap: (url) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<AppWebView>(
                                    builder: (_) => AppWebView(url: url),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),

                        //* anime characters
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Text(
                              "Characters",
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.copyWith(color: white),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                //TODO
                              },
                              child: const Text("See all"),
                            ),
                          ],
                        ),
                      ], //*end
                    ),
                  ),

                  BlocBuilder<AnimeCubit, AnimeState>(
                    builder: (context, state) {
                      if (state.isCharactersListLoading) {
                        return SliverToBoxAdapter(
                          child: AnimeDetailsCharactersItemsSkeleton(
                            isLoading: true,
                          ),
                        );
                      }

                      if (state.charactersListError.isNotEmpty) {
                        return SliverToBoxAdapter(
                          child: Center(child: Text(state.charactersListError)),
                        );
                      }

                      final characters = state.charactersList;
                      return SliverList.builder(
                        itemCount: min(characters.length, 10),
                        itemBuilder: (context, index) {
                          return PersonCardWithCharacterItem(
                            animeCharactersModel: characters[index],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  //?================== other info
  Widget _OtherInfo(BuildContext context, AnimeDetailsModel animeDetails) {
    return Column(
      children: [
        //? dates
        SizedBox(
          width: double.infinity,
          child: Card.filled(
            color: tertiary,

            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //* season and status
                  Text(
                    "${animeDetails.season?.toUpperCase() ?? '---'} ${animeDetails.year.toString().toUpperCase()} \u2022 ${animeDetails.status?.toUpperCase() ?? 'No Updates'}",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.4,
                      color: primaryLight,
                    ),
                  ),
                  const SizedBox(height: 4),
                  //* airing date
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.calendar_month_outlined, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        animeDetails.aired?.string ?? 'Not aired',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: white),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  //* scores and rankings
                  ScoresSection(animeDetails: animeDetails),

                  //* stars
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RatingBarIndicator(
                        rating: animeDetails.score ?? 0.0,
                        itemBuilder: (context, index) =>
                            const Icon(Icons.star, color: Colors.amber),
                        itemCount: 10,
                        itemSize: 28,
                      ),
                      const SizedBox(width: 4),
                      Text("(${animeDetails.score ?? 0.0})"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        //* broadcast
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: BroadcastSection(animeDetails: animeDetails),
        ),
      ],
    );
  }
}
