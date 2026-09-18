import 'package:denuanime/features/anime/data/request/search_anime_request.dart';
import 'package:denuanime/features/anime/domain/cubits/anime_cubit.dart';
import 'package:denuanime/features/anime/domain/entities/genre_model.dart';
import 'package:denuanime/features/common/entities/genre_filter_item_model.dart';
import 'package:denuanime/features/common/presentation/genre_multi_select_dialog.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:denuanime/utils/core/async_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AnimeFilterBottomSheet extends StatefulWidget {
  final SearchAnimeRequest request;
  const AnimeFilterBottomSheet({super.key, required this.request});

  @override
  State<AnimeFilterBottomSheet> createState() => _AnimeFilterBottomSheetState();
}

class _AnimeFilterBottomSheetState extends State<AnimeFilterBottomSheet> {
  bool _sfw = false;
  bool _sfwStrict = false;
  bool _excludeUnapproved = false;

  late TextEditingController _searchController;

  String _type = '';
  String _status = '';
  String _rating = '';

  RangeValues _scoreRangeValues = const RangeValues(0, 9.9);

  String _orderBy = '';
  String _sort = '';

  String _genres = '';
  String _genresName = '';

  String _excludeGenres = '';
  String _excludeGenresName = '';

  String _producers = '';

  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  static const List<DropdownMenuEntry<String>> typeEntries = [
    DropdownMenuEntry(value: '', label: 'All'),
    DropdownMenuEntry(value: 'tv', label: 'TV'),
    DropdownMenuEntry(value: 'movie', label: 'Movie'),
    DropdownMenuEntry(value: 'ova', label: 'OVA'),
    DropdownMenuEntry(value: 'special', label: 'Special'),
    DropdownMenuEntry(value: 'ona', label: 'ONA'),
    DropdownMenuEntry(value: 'music', label: 'Music'),
    DropdownMenuEntry(value: 'cm', label: 'CM'),
    DropdownMenuEntry(value: 'pv', label: 'PV'),
    DropdownMenuEntry(value: 'tv_special', label: 'TV Special'),
  ];

  static const List<DropdownMenuEntry<String>> statusEntries = [
    DropdownMenuEntry(value: '', label: 'All'),
    DropdownMenuEntry(value: 'airing', label: 'Airing'),
    DropdownMenuEntry(value: 'complete', label: 'Completed'),
    DropdownMenuEntry(value: 'upcoming', label: 'Upcoming'),
  ];

  static const List<DropdownMenuEntry<String>> ratingEntries = [
    DropdownMenuEntry(value: '', label: 'All'),
    DropdownMenuEntry(value: 'g', label: 'G - All Ages'),
    DropdownMenuEntry(value: 'pg', label: 'PG - Children'),
    DropdownMenuEntry(value: 'pg13', label: 'PG-13 - Teens 13 or older'),
    DropdownMenuEntry(value: 'r', label: 'R - 17+ (violence & profanity)'),
    DropdownMenuEntry(value: 'rx17', label: 'R+ - Mild Nudity'),
    DropdownMenuEntry(value: 'rx', label: 'Rx - Hentai'),
  ];

  static const List<DropdownMenuEntry<String>> orderByEntries = [
    DropdownMenuEntry(value: '', label: 'Default'),
    DropdownMenuEntry(value: 'title', label: 'Title'),
    DropdownMenuEntry(value: 'start_date', label: 'Start Date'),
    DropdownMenuEntry(value: 'end_date', label: 'End Date'),
    DropdownMenuEntry(value: 'episodes', label: 'Episodes'),
    DropdownMenuEntry(value: 'rank', label: 'Rank'),
    DropdownMenuEntry(value: 'popularity', label: 'Popularity'),
    DropdownMenuEntry(value: 'members', label: 'Members'),
    DropdownMenuEntry(value: 'favorites', label: 'Favorites'),
    DropdownMenuEntry(value: 'score', label: 'Score'),
  ];

  static const List<DropdownMenuEntry<String>> sortEntries = [
    DropdownMenuEntry(value: '', label: 'Default'),
    DropdownMenuEntry(value: 'asc', label: 'Ascending'),
    DropdownMenuEntry(value: 'desc', label: 'Descending'),
  ];

  //* =============== functions
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    //put previous values of filter
    _searchController.text = widget.request.q ?? '';

    _type = widget.request.type ?? '';
    _status = widget.request.status ?? '';
    _rating = widget.request.rating ?? '';

    _sfw = widget.request.sfw == "true" ? true : false;
    _sfwStrict = widget.request.sfw_strict == "true" ? true : false;
    _excludeUnapproved = widget.request.unapproved == "true" ? true : false;

    _scoreRangeValues = RangeValues(
      double.tryParse(widget.request.min_score ?? '0') ?? 0,
      double.tryParse(widget.request.max_score ?? '9.9') ?? 9.9,
    );

    _genres = widget.request.genres ?? '';
    _genresName = widget.request.genresName ?? '';
    _excludeGenres = widget.request.genres_exclude ?? '';
    _excludeGenresName = widget.request.genres_exclude_name ?? '';

    _orderBy = widget.request.order_by ?? '';
    _sort = widget.request.sort ?? '';

    _producers = widget.request.producers ?? '';

    _selectedStartDate = _parseDate(widget.request.start_date);
    _selectedEndDate = _parseDate(widget.request.end_date);
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  //* ============= build request
  SearchAnimeRequest buildSearchRequest() {
    final bool scoreChanged =
        _scoreRangeValues.start > 0 || _scoreRangeValues.end < 10;

    return SearchAnimeRequest(
      q: _searchController.text.trim().isEmpty
          ? null
          : _searchController.text.trim(),

      type: _type.isEmpty ? null : _type,

      status: _status.isEmpty ? null : _status,

      rating: _rating.isEmpty ? null : _rating,

      sfw: _sfw ? 'true' : null,
      sfw_strict: _sfwStrict ? 'true' : null,
      unapproved: _excludeUnapproved ? 'false' : null,

      min_score: scoreChanged
          ? _scoreRangeValues.start.toStringAsFixed(1)
          : null,

      max_score: scoreChanged ? _scoreRangeValues.end.toStringAsFixed(1) : null,

      genres: _genres.isEmpty ? null : _genres,
      genresName: _genresName.isEmpty ? null : _genresName,
      genres_exclude: _excludeGenres.isEmpty ? null : _excludeGenres,
      genres_exclude_name: _excludeGenresName.isEmpty
          ? null
          : _excludeGenresName,

      order_by: _orderBy.isEmpty ? null : _orderBy,

      sort: _sort.isEmpty ? null : _sort,

      producers: _producers.isEmpty ? null : _producers,

      start_date: _formatDate(_selectedStartDate),

      end_date: _formatDate(_selectedEndDate),
    );
  }

  //* ============= formatters
  String? _formatDate(DateTime? date) {
    if (date == null) return null;

    return DateFormat('yyyy-MM-dd').format(date);
  }

  DateTime? _parseDate(String? date) {
    if (date == null || date.isEmpty) return null;

    return DateFormat('yyyy-MM-dd').parse(date);
  }

  String _formatSelectedItems(List<GenreFilterItemModel> items) {
    if (items.isEmpty) {
      return 'Select genres';
    }

    if (items.length <= 3) {
      return items.map((item) => item.name).join(', ');
    }

    final visible = items.take(3).map((item) => item.name).join(', ');

    final remaining = items.length - 3;

    return '$visible, +$remaining';
  }

  //* ========== WIDGET
  Future<List<GenreFilterItemModel>?> _showGenreDialog({
    required String title,
    required String selectedIds,
  }) async {
    final cubit = context.read<AnimeCubit>();

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text('Loading genres...'),
            ],
          ),
        );
      },
    );

    try {
      await cubit.getAllGenres();

      if (!mounted) return null;

      Navigator.of(context).pop();

      final genres = cubit.state.genres;

      if (genres is! AsyncData<List<GenreModel>>) {
        return null; // or <GenreFilterItemModel>[], depending on your return type
      }
      final items = genres.value
          .map(
            (e) => GenreFilterItemModel(
              isSelected: selectedIds
                  .split(',')
                  .contains((e.mal_id ?? 0).toString()),
              malId: e.mal_id,
              name: e.name,
              url: e.url,
              count: e.count,
            ),
          )
          .toList();

      return await showDialog<List<GenreFilterItemModel>>(
        context: context,
        builder: (_) => GenreMultiSelectDialog(items: items, title: title),
      );
    } catch (e) {
      if (!mounted) return null;

      Navigator.of(context).pop();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to load genres: $e')));

      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.90,
      minChildSize: 0.5,
      expand: false,
      snap: true,
      snapSizes: const [0.5, 0.90],
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: secondary,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              controller: scrollController,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //* ==== Header
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Filters',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 4),

                            const Text('Refine your anime search'),
                          ],
                        ),
                        const Spacer(),

                        TextButton.icon(
                          onPressed: () {},
                          label: const Text("Reset"),

                          icon: const Icon(Icons.restart_alt, size: 30),
                          iconAlignment: IconAlignment.start,
                        ),
                      ],
                    ),
                  ),

                  //*  ======== filters
                  //? quick filters
                  _ContainerWithHeader(
                    context,
                    Icons.safety_check,
                    "Quick Filters",
                    SizedBox(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            // Safe for work
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: BoxBorder.all(
                                  color: Colors.white38,
                                  width: 1.5,
                                ),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () {
                                  setState(() {
                                    _sfw = !_sfw;
                                  });
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 12,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.check),
                                      Text("Safe for Work"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // sfw strict
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: BoxBorder.all(
                                  color: Colors.white38,
                                  width: 1.5,
                                ),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () {
                                  setState(() {
                                    _sfwStrict = !_sfwStrict;
                                  });
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 12,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.stop),
                                      Text("SFW Strict"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),

                            // unapproved
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: BoxBorder.all(
                                  color: Colors.white38,
                                  width: 1.5,
                                ),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () {
                                  setState(() {
                                    _excludeUnapproved = !_excludeUnapproved;
                                  });
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 12,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.not_interested_rounded),
                                      Text("Exclude Unapproved"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //? title search
                  _ContainerWithHeader(
                    context,
                    Icons.title_outlined,
                    "Search by Title",
                    TextField(
                      controller: _searchController,
                      autocorrect: false,
                      decoration: InputDecoration(
                        constraints: const BoxConstraints(
                          minHeight: 46,
                          maxHeight: 46,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        fillColor: background,
                        hint: const Text("Enter anime title..."),
                        suffixIcon: const Icon(Icons.search),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Colors.white38,
                            width: 1,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Colors.white38,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),

                  //? ==== type and status
                  Row(
                    children: [
                      //? Type
                      Expanded(
                        child: _ContainerWithHeader(
                          context,
                          Icons.tv,
                          "Type",
                          _DropdownFilter(context, _type, typeEntries, (value) {
                            setState(() {
                              _type = value;
                            });
                          }),
                        ),
                      ),

                      //? Status
                      Expanded(
                        child: _ContainerWithHeader(
                          context,
                          Icons.stacked_line_chart,
                          "Status",
                          _DropdownFilter(context, _status, statusEntries, (
                            value,
                          ) {
                            setState(() {
                              _status = value;
                            });
                          }),
                        ),
                      ),
                    ],
                  ),

                  //? Rating
                  _ContainerWithHeader(
                    context,
                    Icons.star_outline,
                    "Rating",
                    _DropdownFilter(context, _rating, ratingEntries, (value) {
                      setState(() {
                        _rating = value;
                      });
                    }),
                  ),

                  //? Score range
                  _ContainerWithHeader(
                    context,
                    Icons.scoreboard,
                    "Score Range",
                    RangeSlider(
                      min: 0,
                      max: 9.9,
                      values: _scoreRangeValues,
                      divisions: 99,
                      labels: RangeLabels(
                        _scoreRangeValues.start.toStringAsFixed(1),
                        _scoreRangeValues.end.toStringAsFixed(1),
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _scoreRangeValues = RangeValues(
                            double.parse(values.start.toStringAsFixed(1)),
                            double.parse(values.end.toStringAsFixed(1)),
                          );
                        });
                      },
                    ),
                  ),

                  //? order by and sort
                  _ContainerWithHeader(
                    context,
                    Icons.info,
                    "Sorting",
                    message:
                        "Choose what to sort by and the order to sort it in.",
                    Row(
                      children: [
                        Expanded(
                          child: _ContainerWithHeader(
                            context,
                            Icons.swap_vert_rounded,
                            "Order By",
                            _DropdownFilter(context, _orderBy, orderByEntries, (
                              value,
                            ) {
                              setState(() {
                                _orderBy = value;
                              });
                            }),
                          ),
                        ),

                        Expanded(
                          child: _ContainerWithHeader(
                            context,
                            Icons.swap_vert_rounded,
                            "Sort",
                            _DropdownFilter(context, _sort, sortEntries, (
                              value,
                            ) {
                              setState(() {
                                _sort = value;
                              });
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //? genre
                  _ContainerWithHeader(
                    context,
                    Icons.movie_filter,
                    "Genres",
                    Column(
                      children: [
                        //* ========= Generes
                        InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () async {
                            final result = await _showGenreDialog(
                              title: 'Genres',
                              selectedIds: _genres,
                            );

                            if (result != null && mounted) {
                              setState(() {
                                _genresName = _formatSelectedItems(result);
                                _genres = result
                                    .map((e) => (e.malId ?? 0).toString())
                                    .join(',');
                              });
                            }
                          },
                          child: Container(
                            height: 46,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.white38),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _genresName.isEmpty
                                        ? 'Select genres'
                                        : _genresName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: inversePrimary),
                                  ),
                                ),
                                const Icon(Icons.keyboard_arrow_down_rounded),
                              ],
                            ),
                          ),
                        ),

                        //*================ excluded genres
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(
                              Icons.not_interested,
                              color: primaryDark,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Exclude Genres",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () async {
                            final result = await _showGenreDialog(
                              title: 'Exclude Genres',
                              selectedIds: _excludeGenres,
                            );

                            if (result != null && mounted) {
                              setState(() {
                                _excludeGenresName = _formatSelectedItems(
                                  result,
                                );
                                _excludeGenres = result
                                    .map((e) => (e.malId ?? 0).toString())
                                    .join(',');
                              });
                            }
                          },
                          child: Container(
                            height: 46,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.white38),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _excludeGenresName.isEmpty
                                        ? 'Select genres to exclude'
                                        : _excludeGenresName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: inversePrimary),
                                  ),
                                ),
                                const Icon(Icons.keyboard_arrow_down_rounded),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //? Producers
                  _ContainerWithHeader(
                    context,
                    Icons.apartment,
                    "Producers",
                    _DropdownFilter(
                      context,
                      "",
                      const [
                        DropdownMenuEntry(value: '', label: 'Select producers'),
                        DropdownMenuEntry(value: 'Airing', label: 'Airing'),
                        DropdownMenuEntry(value: 'Finished', label: 'Finished'),
                      ],
                      (p0) {
                        print(p0);
                      },
                    ),
                  ),

                  //? Date
                  Row(
                    children: [
                      Expanded(
                        child: _ContainerWithHeader(
                          context,
                          Icons.date_range_outlined,
                          "Start Date",
                          InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate:
                                    _selectedStartDate ?? DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );

                              if (pickedDate != null) {
                                setState(() {
                                  _selectedStartDate = pickedDate;
                                });
                              }
                            },
                            child: Container(
                              height: 46,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white38),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _formatDate(_selectedStartDate) ?? '---',
                                    ),
                                  ),
                                  const Icon(Icons.calendar_month_outlined),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: _ContainerWithHeader(
                          context,
                          Icons.date_range_outlined,
                          "End Date",
                          InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: _selectedEndDate ?? DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );

                              if (pickedDate != null) {
                                setState(() {
                                  _selectedEndDate = pickedDate;
                                });
                              }
                            },
                            child: Container(
                              height: 46,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white38),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _formatDate(_selectedEndDate) ?? '---',
                                    ),
                                  ),
                                  const Icon(Icons.calendar_month_outlined),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  //* ===== buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Navigator.pop(context, null);
                            },
                            icon: const Icon(Icons.close, color: primary),
                            label: const Text('Cancel'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              final request = buildSearchRequest();

                              Navigator.pop(context, request);
                            },
                            icon: const Icon(Icons.filter_alt),
                            label: const Text('Apply Filters'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //* ========== container
  Widget _ContainerWithHeader(
    BuildContext context,
    IconData icon,
    String title,
    Widget content, {
    String message = "",
  }) {
    return Card.outlined(
      margin: const EdgeInsets.all(2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: tertiary, width: 1.5),
      ),
      color: background,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Tooltip(
                  message: message,
                  enableFeedback: true,
                  triggerMode: TooltipTriggerMode.tap,
                  child: Icon(icon, color: primaryDark),
                ),
                const SizedBox(width: 8),
                Text(title, style: Theme.of(context).textTheme.titleSmall),
              ],
            ),

            const SizedBox(height: 8),
            content,
          ],
        ),
      ),
    );
  }

  //* Dropdown menu
  Widget _DropdownFilter(
    BuildContext context,
    String initialSelection,
    List<DropdownMenuEntry<String>> entries,
    void Function(String) onSelected,
  ) {
    return DropdownMenu<String>(
      width: double.infinity,
      initialSelection: initialSelection,
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.white38, width: 1),
        ),
        constraints: const BoxConstraints(minHeight: 46, maxHeight: 46),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      ),
      textStyle: Theme.of(
        context,
      ).textTheme.bodyMedium?.copyWith(color: inversePrimary),
      dropdownMenuEntries: entries,
      onSelected: (value) {
        onSelected(value ?? '');
      },
    );
  }
}
