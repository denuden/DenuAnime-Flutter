import 'dart:async';

import 'package:denuanime/features/common/presentation/skeleton/search_people_card_items_skeleton.dart';
import 'package:denuanime/features/people/data/request/search_people_request.dart';
import 'package:denuanime/features/people/domain/cubits/people_cubit.dart';
import 'package:denuanime/features/people/domain/cubits/people_state.dart';
import 'package:denuanime/features/people/domain/entities/people_model.dart';
import 'package:denuanime/features/people/presentation/common/person_card_search_item.dart';
import 'package:denuanime/features/people/presentation/person_details_view.dart';
import 'package:denuanime/utils/core/async_value.dart';
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
  final List<String> _previousSearches = [];

  //?========= functions
  void _searchPeople(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;

    context.read<PeopleCubit>().searchPeople(
      SearchPeopleRequest(
        q: trimmed,
        order_by: "favorites",
        sort: "desc",
        limit: "50",
      ),
    );

    setState(() {
      _previousSearches.remove(trimmed);
      _previousSearches.insert(0, trimmed);
    });
  }

  void _onSearchChanged() {
    _searchTimer?.cancel();

    if (searchController.text.trim().isEmpty) {
      return;
    }

    _searchTimer = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      _searchPeople(searchController.text);
    });
  }

  void _onNavigateToPeopleDetails(int id) {
    Navigator.of(context).push(PersonDetailsView.route(id));
  }

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    _searchTimer?.cancel();
    searchController.dispose();
    super.dispose();
  }

  //?========= widget
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
                  _searchPeople(searchController.text);
                  searchController.closeView(searchController.text);
                  searchController.clear();
                },
                icon: const Icon(Icons.search),
              ),
            ],
            viewOnSubmitted: (value) {
              _searchPeople(value);
              searchController.closeView(value);
              searchController.clear();
            },
            suggestionsBuilder: (context, controller) {
              return _previousSearches.map((query) {
                return ListTile(
                  leading: const Icon(Icons.history),
                  title: Text(query),
                  onTap: () {
                    _searchPeople(query);
                    searchController.closeView(query);
                    searchController.clear();
                  },
                );
              }).toList();
            },
          ),
        ],
      ),

      body: BlocBuilder<PeopleCubit, PeopleState>(
        buildWhen: (p, c) => p.people != c.people,
        builder: (context, state) {
          return switch (state.people) {
            AsyncIdle() || AsyncLoading() => _buildSkeleton(),
            AsyncFailure(:final message) => Center(child: Text(message)),
            AsyncData(:final value) => _buildResults(value),
          };
        },
      ),
    );
  }

  Widget _buildSkeleton() {
    return Column(
      children: List.generate(5, (index) {
        return const SearchPeopleCardItemsSkeleton();
      }),
    );
  }

  Widget _buildResults(List<PeopleModel> people) {
    if (people.isEmpty) {
      return const Center(child: Text("No person found"));
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: people.length,
      itemBuilder: (context, index) {
        final person = people[index];

        return PersonCardSearchItem(
          peopleModel: person,
          onClick: () {
            _onNavigateToPeopleDetails(person.mal_id ?? -1);
          },
        );
      },
    );
  }
}
