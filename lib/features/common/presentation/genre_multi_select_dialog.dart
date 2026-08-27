import 'package:denuanime/features/common/entities/genre_filter_item_model.dart';
import 'package:flutter/material.dart';

class GenreMultiSelectDialog extends StatefulWidget {
  final List<GenreFilterItemModel> items;
  final String title;

  const GenreMultiSelectDialog({
    super.key,
    required this.items,
    required this.title,
  });

  @override
  State<GenreMultiSelectDialog> createState() => _GenreMultiSelectDialogState();
}

class _GenreMultiSelectDialogState extends State<GenreMultiSelectDialog> {
  List<GenreFilterItemModel> selectedItems = [];
  List<GenreFilterItemModel> filteredItems = [];

  @override
  void initState() {
    super.initState();
    //same list reference
    filteredItems = widget.items;
    //new list with the same object references → shallow copy
    selectedItems = widget.items.where((e) => e.isSelected).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      backgroundColor: theme.colorScheme.secondary,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 650),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Search
              TextField(
                onChanged: (value) {
                  setState(() {
                    if (value.isEmpty) {
                      filteredItems = widget.items;
                    } else {
                      filteredItems = widget.items
                          .where(
                            (e) => (e.name ?? '---').toLowerCase().contains(
                              value.toLowerCase(),
                            ),
                          )
                          .toList();
                    }
                  });
                },
                enableInlinePrediction: false,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: 'Search ${widget.title.toLowerCase()}...',
                  prefixIcon: const Icon(Icons.search),
                  isDense: true,
                  constraints: const BoxConstraints(
                    minHeight: 46,
                    maxHeight: 46,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Selected count
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  '${selectedItems.length} selected',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // Chips
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(filteredItems.length, (index) {
                      return FilterChip(
                        label: Text(filteredItems[index].name ?? '---'),
                        selected: filteredItems[index].isSelected,
                        selectedColor: Theme.of(context).colorScheme.primary,
                        checkmarkColor: Colors.black,
                        labelStyle: TextStyle(
                          color: filteredItems[index].isSelected
                              ? Colors.black
                              : Colors.white,
                        ),
                        onSelected: (_) {
                          setState(() {
                            final item = filteredItems[index];
                            //mutating the shared object
                            item.isSelected = !item.isSelected;

                            //shallow list copy, containing references to the same objects.
                            selectedItems = widget.items
                                .where((e) => e.isSelected)
                                .toList();
                          });
                        },
                        showCheckmark: true,
                      );
                    }),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Apply
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.pop(context, selectedItems);
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Apply'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
