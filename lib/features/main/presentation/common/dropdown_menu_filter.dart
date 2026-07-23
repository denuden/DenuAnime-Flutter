import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';

class DropdownMenuFilter extends StatelessWidget {
  const DropdownMenuFilter({
    super.key,
    required this.selectedType,
    required this.selectedRating,
    required this.onFilterChanged,
    this.enabled = true,
  });

  final int selectedType;
  final int selectedRating;
  final bool enabled;

  final void Function(int typeIndex, int ratingIndex) onFilterChanged;

  static const List<String> typeLabels = [
    'All',
    'TV',
    'Movie',
    'OVA',
    'Special',
    'ONA',
    'Music',
    'CM',
    'PV',
    'TV Special',
  ];

  static const List<String> typeApiValues = [
    '',
    'tv',
    'movie',
    'ova',
    'special',
    'ona',
    'music',
    'cm',
    'pv',
    'tv_special',
  ];

  static const List<String> ratingLabels = [
    'All',
    'G - All Ages',
    'PG - Children',
    'PG-13 - Teens 13 or older',
    'R - 17+ (violence & profanity)',
    'R+ - Mild Nudity',
    'Rx - Hentai',
  ];

  static const List<String> ratingApiValues = [
    '',
    'g',
    'pg',
    'pg13',
    'r17',
    'r',
    'rx',
  ];

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      style: MenuStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
            side: const BorderSide(color: white, width: 1),
          ),
        ),
      ),
      animated: true,
      builder: (context, controller, child) {
        return FilledButton.icon(
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(primary),
          ),
          onPressed: enabled
              ? () {
                  controller.isOpen ? controller.close() : controller.open();
                }
              : null,
          icon: const Icon(Icons.filter_alt_outlined),
          label: const Text("Filter"),
        );
      },
      menuChildren: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 20,
          height: 360,
          child: Row(
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width / 2) - 11,
                child: _buildColumn(
                  context,
                  title: "Type",
                  labels: typeLabels,
                  selectedIndex: selectedType,
                  onTap: (index) {
                    onFilterChanged(index, selectedRating);
                  },
                ),
              ),

              const VerticalDivider(width: 1, thickness: 0.4),

              SizedBox(
                width: (MediaQuery.of(context).size.width / 2) - 11,
                child: _buildColumn(
                  context,
                  title: "Rating",
                  labels: ratingLabels,
                  selectedIndex: selectedRating,
                  onTap: (index) {
                    onFilterChanged(selectedType, index);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildColumn(
    BuildContext context, {
    required String title,
    required List<String> labels,
    required int selectedIndex,
    required ValueChanged<int> onTap,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),

        const Divider(height: 1, thickness: 0.4),

        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: labels.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => onTap(index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 22,
                        child: selectedIndex == index
                            ? Icon(
                                Icons.check,
                                size: 18,
                                color: Theme.of(context).colorScheme.primary,
                              )
                            : null,
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Text(
                          labels[index],
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
