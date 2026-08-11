import 'dart:async';

import 'package:denuanime/features/common/presentation/skeleton/search_people_card_items_skeleton.dart';
import 'package:denuanime/features/people/data/request/search_people_request.dart';
import 'package:denuanime/features/people/domain/cubits/people_cubit.dart';
import 'package:denuanime/features/people/domain/cubits/people_state.dart';
import 'package:denuanime/features/people/presentation/common/person_card_search_item.dart';
import 'package:denuanime/features/people/presentation/person_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPersonView extends StatefulWidget {
  const SearchPersonView({super.key});

  @override
  State<SearchPersonView> createState() => _SearchPersonViewState();
}

class _SearchPersonViewState extends State<SearchPersonView> {
  final SearchController searchController = SearchController();

  Timer? _searchTimer;
  List<String> _previousSearches = [];

  //?========= functions
  void searchPeople(String query) {
    context.read<PeopleCubit>().searchPeople(
      SearchPeopleRequest(
        q: query.trim(),
        order_by: "favorites",
        sort: "desc",
        limit: "50",
      ),
    );

    setState(() {
      _previousSearches.remove(query.trim());
      _previousSearches.insert(0, query.trim());
    });
  }

  void _onSearchChanged() {
    _searchTimer?.cancel();

    if (searchController.text.trim().isEmpty) {
      return;
    }

    _searchTimer = Timer(const Duration(seconds: 2), () {
      final trimmedQuery = searchController.text.trim();
      //call initial search
      context.read<PeopleCubit>().searchPeople(
        SearchPeopleRequest(
          q: trimmedQuery,
          order_by: "favorites",
          sort: "desc",
          limit: "50",
        ),
      );

      setState(() {
        _previousSearches.remove(trimmedQuery);
        _previousSearches.insert(0, trimmedQuery);
      });
    });
  }

  void _onNavigateToPeopleDetails(int id) {
    Navigator.of(context).push(
      MaterialPageRoute<PersonDetailsView>(
        builder: (context) => PersonDetailsView(id: id),
      ),
    );
  }

  @override
  void initState() {
    searchController.addListener(_onSearchChanged);
    super.initState();
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    _searchTimer?.cancel();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search People"),
        actions: [
          SearchAnchor(
            viewHintText: "Search people...",
            searchController: searchController,
            isFullScreen: false,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,

            builder: (context, controller) {
              return IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  controller.openView();
                },
              );
            },
            viewLeading: IconButton(
              onPressed: () {
                searchController.clear();

                searchController.closeView(searchController.text);
              },
              icon: const Icon(Icons.close),
            ),
            viewTrailing: [
              IconButton(
                onPressed: () {
                  searchPeople(searchController.text);
                  searchController.closeView(searchController.text);
                  searchController.clear();
                },
                icon: const Icon(Icons.search),
              ),
            ],
            viewOnSubmitted: (value) {
              searchPeople(value);

              searchController.closeView(value);
              searchController.clear();
            },
            suggestionsBuilder: (context, controller) {
              return _previousSearches.map((query) {
                return ListTile(
                  leading: const Icon(Icons.history),
                  title: Text(query),
                  onTap: () {
                    searchController.text = query;
                    searchController.closeView(query);
                  },
                );
              }).toList();
            },
          ),
        ],
      ),

      body: BlocBuilder<PeopleCubit, PeopleState>(
        builder: (context, state) {
          if (state.isPeopleLoading) {
            return Column(
              children: List.generate(5, (index) {
                return const SearchPeopleCardItemsSkeleton();
              }),
            );
          }

          if (state.peopleListError.isNotEmpty) {
            return Center(child: Text(state.peopleListError));
          }

          final peopleList = state.peopleList;
          return peopleList.isEmpty
              ? const Center(child: Text("No person found"))
              : SizedBox(
                  width: double.infinity,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: peopleList.length,
                    itemBuilder: (context, index) {
                      return PersonCardSearchItem(
                        peopleModel: peopleList[index],
                        onClick: () {
                          _onNavigateToPeopleDetails(
                            peopleList[index].mal_id ?? -1,
                          );
                        },
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
