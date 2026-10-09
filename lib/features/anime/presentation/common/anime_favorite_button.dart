import 'package:denuanime/features/anime/domain/cubits/favorite_cubit.dart';
import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:denuanime/utils/core/async_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteButton extends StatelessWidget {
  final AnimeDetailsModel anime;
  final void Function(bool) onPressed;

  const FavoriteButton({
    super.key,
    required this.anime,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isFav = context.select(
      (FavoriteCubit c) => c.state.ids.contains(anime.mal_id),
    );
    final isSaving = context.select(
      (FavoriteCubit c) => c.state.addFavorite is AsyncLoading,
    );

    return IconButton.filledTonal(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          secondary.withValues(alpha: 0.5),
        ),
      ),
      splashColor: white,
      onPressed: () {
        if (!isSaving) {
          onPressed(isFav);
        }
      },
      icon: isSaving
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: white),
            )
          : Icon(
              isFav ? Icons.favorite : Icons.favorite_border_outlined,
              color: isFav ? Colors.red : white,
            ),
    );
  }
}
