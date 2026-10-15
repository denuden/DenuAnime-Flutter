import 'package:denuanime/features/anime/data/request/toggle_watch_state_request.dart';
import 'package:denuanime/features/anime/domain/cubits/favorite_cubit.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum Options { finished, unfinished, none }

class MoreOptions extends StatefulWidget {
  final int malId;
  const MoreOptions({super.key, required this.malId});

  @override
  State<MoreOptions> createState() => _MoreOptionsState();
}

class _MoreOptionsState extends State<MoreOptions> {
  Options? selectedItem;

  //? ============= functions
  void _toggleWatchState(Options? state) {
    context.read<FavoriteCubit>().toggleWatchState(
      ToggleWatchStateRequest(
        mal_id: widget.malId,
        watch_state: state == Options.none ? null : state?.name,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Options>(
      color: secondary,

      icon: const Icon(Icons.more_vert),
      onSelected: (Options item) {
        setState(() {
          selectedItem = item;
          _toggleWatchState(selectedItem);
        });
      },
      itemBuilder: (context) {
        return <PopupMenuEntry<Options>>[
          const PopupMenuItem<Options>(
            value: Options.finished,
            child: Text('Mark as done'),
          ),
          const PopupMenuItem<Options>(
            value: Options.unfinished,
            child: Text('Move to Up Next'),
          ),
          const PopupMenuItem<Options>(
            value: Options.none,
            child: Text('Unmark'),
          ),
        ];
      },
    );
  }
}
