import 'dart:ui';

import 'package:denuanime/features/anime/presentation/anime_character_details_view.dart';
import 'package:denuanime/features/common/presentation/custom_image_network.dart';
import 'package:denuanime/features/common/presentation/skeleton/person_details_view_skeleton.dart';
import 'package:denuanime/features/people/domain/cubits/people_cubit.dart';
import 'package:denuanime/features/people/domain/cubits/people_state.dart';
import 'package:denuanime/features/people/presentation/common/person_character_item.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:denuanime/utils/datetime_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PersonDetailsView extends StatefulWidget {
  final int id;
  const PersonDetailsView({super.key, required this.id});

  @override
  State<PersonDetailsView> createState() => _PersonDetailsViewState();
}

class _PersonDetailsViewState extends State<PersonDetailsView> {
  final PageController _pageController = PageController();
  final ScrollController _controller = ScrollController();

  int _currentPage = 0;
  bool _expanded = false;

  bool _showFab = false;

  //?========= functions
  @override
  void initState() {
    //call full details people
    context.read<PeopleCubit>().getFullPeopleDetails(widget.id);

    //* jump back to top
    _controller.addListener(() {
      final show = _controller.offset > 1000; // adjust threshold

      if (show != _showFab) {
        setState(() {
          _showFab = show;
        });
      }
    });

    super.initState();
  }

  void _navigateToCharacterDetails(int id, String role) {
    Navigator.of(context).push(
      MaterialPageRoute<AnimeCharacterDetailsView>(
        builder: (context) => AnimeCharacterDetailsView(id: id, role: role),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("VA Details")),
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
      body: BlocBuilder<PeopleCubit, PeopleState>(
        builder: (context, state) {
          if (state.isPeopleLoading) {
            return const PersonDetailsViewSkeleton();
          }

          if (state.peopleError.isNotEmpty) {
            return Center(child: Text(state.peopleError));
          }

          final personImages = state.pictures;
          final peopleModel = state.peopleDetails;

          return CustomScrollView(
            controller: _controller,
            //* body
            slivers: [
              //* Header
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 200,
                  child: Stack(
                    children: [
                      if (personImages.isNotEmpty == true)
                        SizedBox(
                          height: 200,
                          child: PageView.builder(
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() {
                                _currentPage = index;
                              });
                            },
                            itemCount: personImages.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  ImageFiltered(
                                    imageFilter: ImageFilter.blur(
                                      sigmaX: 20,
                                      sigmaY: 20,
                                    ),
                                    child: CustomImageNetwork(
                                      personImages[index].jpg?.image_url ?? '',
                                      height: 200,
                                      boxFit: BoxFit.cover,
                                    ),
                                  ),

                                  Container(
                                    color: Colors.black.withValues(alpha: 0.25),
                                  ),
                                  CustomImageNetwork(
                                    personImages[index].jpg?.image_url ?? '',
                                    height: 200,
                                    boxFit: BoxFit.fitHeight,
                                  ),
                                ], //*end image stack
                              );
                            },
                          ),
                        ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              secondary.withValues(alpha: 0.4),
                            ),
                          ),
                          onPressed: () {
                            if (_currentPage > 0) {
                              _pageController.animateToPage(
                                _currentPage - 1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            }
                          },
                          icon: const Icon(Icons.keyboard_arrow_left),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              secondary.withValues(alpha: 0.4),
                            ),
                          ),
                          onPressed: () {
                            if (_currentPage < personImages.length - 1) {
                              _pageController.animateToPage(
                                _currentPage + 1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            }
                          },
                          icon: const Icon(Icons.keyboard_arrow_right),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            personImages.length,
                            (index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 2,
                              ),
                              child: Icon(
                                Icons.circle,
                                size: 10,
                                color: index == _currentPage
                                    ? primary
                                    : textSecondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ], //*end stack
                  ),
                ),
              ),

              //*Body
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),

                      Row(
                        children: [
                          Text(
                            peopleModel.name ?? ' Unknown Name',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            "(${peopleModel.given_name ?? '--'} ${peopleModel.family_name ?? '--'})",
                          ),
                        ],
                      ),
                      Text(
                        "Alternate name: ${(peopleModel.alternate_names?.isNotEmpty ?? false) ? peopleModel.alternate_names!.join(", ") : "N/A"}",
                      ),

                      const SizedBox(height: 16),
                      //*birthday
                      Row(
                        children: [
                          const Icon(Icons.calendar_month, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            DateTimeFormatter.formatFromIso(
                              peopleModel.birthday ?? '',
                              "MMMM dd, yyyy",
                            ),
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: inversePrimary),
                          ),
                        ],
                      ),
                      //*favorites
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.favorite, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            NumberFormat.decimalPattern().format(
                              peopleModel.favorites ?? 0,
                            ),
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: inversePrimary),
                          ),
                        ],
                      ),
                      //*Link
                      Row(
                        children: [
                          const Icon(Icons.link, size: 20, color: Colors.blue),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              peopleModel.url ?? '---',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.blue,
                                  ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: Text(
                          peopleModel.about ?? 'Nondescript',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: white, height: 1.5),
                          maxLines: _expanded ? null : 10,
                          overflow: _expanded
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                        ),
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _expanded = !_expanded;
                            });
                          },
                          child: Text(
                            _expanded ? "Hide" : "See more",
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ], // * end column
                  ),
                ),
              ),

              //* ====== VOICES
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      "Voices",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),

              if (peopleModel.voices?.isEmpty == true ||
                  peopleModel.voices == null)
                const SliverToBoxAdapter(
                  child: Center(
                    child: Text("This person didn't voice any anime"),
                  ),
                )
              else
                SliverList.builder(
                  itemCount: peopleModel.voices?.length,
                  itemBuilder: (context, index) {
                    return PersonCharacterItem(
                      voicesModel: peopleModel.voices![index],
                      onClick: () {
                        _navigateToCharacterDetails(
                          peopleModel.voices![index].character?.mal_id ?? -1,
                          peopleModel.voices![index].role ?? '---',
                        );
                      },
                    );
                  },
                ),
            ], //* end
          );
        },
      ),
    );
  }
}
