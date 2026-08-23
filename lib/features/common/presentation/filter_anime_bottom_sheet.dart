import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';

class AnimeFilterBottomSheet extends StatefulWidget {
  const AnimeFilterBottomSheet({super.key});

  @override
  State<AnimeFilterBottomSheet> createState() => _AnimeFilterBottomSheetState();
}

class _AnimeFilterBottomSheetState extends State<AnimeFilterBottomSheet> {
  RangeValues _currentRangeValues = const RangeValues(0, 10);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                          //TODO
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          //TODO
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Icon(Icons.stop), Text("SFW Strict")],
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
                          //TODO
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

          //? title letter
          _ContainerWithHeader(
            context,
            Icons.title_outlined,
            "Search by Title",
            TextField(
              autocorrect: false,
              decoration: InputDecoration(
                fillColor: background,
                hint: const Text("Enter anime title..."),
                suffixIcon: const Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.white38, width: 1),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.white38, width: 1),
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
                  DropdownMenu<String>(
                    width: double.infinity,
                    initialSelection: 'All',
                    inputDecorationTheme: InputDecorationTheme(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.white38,
                          width: 1,
                        ),
                      ),
                    ),
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: 'All', label: 'All'),
                      DropdownMenuEntry(value: 'Airing', label: 'Airing'),
                      DropdownMenuEntry(value: 'Finished', label: 'Finished'),
                    ],
                    onSelected: (value) {
                      print(value);
                    },
                  ),
                ),
              ),
              //? Status
              Expanded(
                child: _ContainerWithHeader(
                  context,
                  Icons.stacked_line_chart,
                  "Status",
                  DropdownMenu<String>(
                    width: double.infinity,
                    initialSelection: 'All',
                    inputDecorationTheme: InputDecorationTheme(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.white38,
                          width: 1,
                        ),
                      ),
                    ),
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: 'All', label: 'All'),
                      DropdownMenuEntry(value: 'Airing', label: 'Airing'),
                      DropdownMenuEntry(value: 'Finished', label: 'Finished'),
                    ],
                    onSelected: (value) {
                      print(value);
                    },
                  ),
                ),
              ),
            ],
          ),

          //? Rating
          _ContainerWithHeader(
            context,
            Icons.star_outline,
            "Rating",
            DropdownMenu<String>(
              width: double.infinity,
              initialSelection: 'All',
              inputDecorationTheme: InputDecorationTheme(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.white38, width: 1),
                ),
              ),
              dropdownMenuEntries: const [
                DropdownMenuEntry(value: 'All', label: 'All'),
                DropdownMenuEntry(value: 'Airing', label: 'Airing'),
                DropdownMenuEntry(value: 'Finished', label: 'Finished'),
              ],
              onSelected: (value) {
                print(value);
              },
            ),
          ),

          //? Score range
          _ContainerWithHeader(
            context,
            Icons.scoreboard,
            "Score Range",
            RangeSlider(
              min: 0,
              max: 10,
              values: _currentRangeValues,
              divisions: 100,
              labels: RangeLabels(
                _currentRangeValues.start.toString(),
                _currentRangeValues.end.toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = RangeValues(
                    double.parse(values.start.toStringAsFixed(1)),
                    double.parse(values.end.toStringAsFixed(1)),
                  );
                });
              },
            ),
          ),

          const SizedBox(height: 20),

          //* ===== buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close, color: primary),
                    label: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
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
    );
  }

  Widget _ContainerWithHeader(
    BuildContext context,
    IconData icon,
    String title,
    Widget content,
  ) {
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
                Icon(icon, color: primaryDark),
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
}
