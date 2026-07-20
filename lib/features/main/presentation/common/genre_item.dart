import 'package:denuanime/features/anime/domain/entities/genre_model.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';

class GenreItem extends StatelessWidget {
  const GenreItem({
    super.key,
    required this.genre,
    required this.onSelect,
    this.size = GenreItemSize.normal,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.textColor,
    this.selectedTextColor,
    this.shape,
    this.side,
  });

  final GenreModel genre;
  final ValueChanged<bool> onSelect;

  final GenreItemSize size;

  final Color? backgroundColor;
  final Color? selectedBackgroundColor;
  final Color? textColor;
  final Color? selectedTextColor;

  final OutlinedBorder? shape;
  final BorderSide? side;
  @override
  Widget build(BuildContext context) {
    final bool isSmall = size == GenreItemSize.small;

    return ChoiceChip(
      side: side ?? BorderSide(color: Theme.of(context).colorScheme.outline),
      shape:
          shape ??
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),

      padding: isSmall
          ? const EdgeInsets.symmetric(horizontal: 4, vertical: 2)
          : const EdgeInsets.symmetric(horizontal: 8, vertical: 4),

      backgroundColor:
          backgroundColor ?? Theme.of(context).colorScheme.secondary,

      selectedColor:
          selectedBackgroundColor ?? Theme.of(context).colorScheme.primary,

      labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
        fontSize: isSmall ? 10 : 12,
        fontWeight: FontWeight.w500,
        color: genre.is_selected
            ? (selectedTextColor ?? background)
            : (textColor ?? inversePrimary),
      ),

      label: Text(genre.name ?? "---"),
      selected: genre.is_selected,
      onSelected: onSelect,
    );
  }
}

enum GenreItemSize { normal, small }
