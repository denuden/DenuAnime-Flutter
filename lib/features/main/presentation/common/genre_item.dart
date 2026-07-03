import 'package:denuanime/features/anime/domain/entities/genre_model.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';

class GenreItem extends StatelessWidget {
  final GenreModel genre;
  final Function(bool) onSelect;
  const GenreItem({super.key, required this.genre, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: genre.isSelected ? background : inversePrimary,
        fontWeight: FontWeight.w400,
      ),
      selectedColor: primary,
      label: Text(genre.name ?? "---"),
      selected: genre.isSelected,
      onSelected: (value) => onSelect(value),
    );
  }
}
