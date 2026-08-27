// import 'dart:async';

// import 'package:denuanime/features/anime/domain/cubits/anime_cubit.dart';
// import 'package:denuanime/features/anime/domain/entities/producer_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ProducerMultiSelectDialog extends StatefulWidget {
//   final List<ProducerModel> items;
//   final String title;

//   const ProducerMultiSelectDialog({
//     super.key,
//     required this.items,
//     required this.title,
//   });

//   @override
//   State<ProducerMultiSelectDialog> createState() =>
//       _ProducerMultiSelectDialogState();
// }

// class _ProducerMultiSelectDialogState
//     extends State<ProducerMultiSelectDialog> {
//   // Keyed by mal_id instead of object identity. Search results come back as
//   // brand new ProducerModel instances from the API, so we can't rely on
//   // "same object reference" like the genre dialog does — we cross-reference
//   // by id instead.
//   late Map<int, ProducerModel> selectedMap;

//   Timer? _debounce;
//   String _query = '';

//   @override
//   void initState() {
//     super.initState();
//     selectedMap = {
//       for (final e in widget.items.where((e) => e.isSelected))
//         if (e.mal_id != null) e.mal_id!: e,
//     };
//   }

//   @override
//   void dispose() {
//     _debounce?.cancel();
//     super.dispose();
//   }

//   void _onSearchChanged(String value) {
//     _debounce?.cancel();
//     _debounce = Timer(const Duration(milliseconds: 400), () {
//       setState(() => _query = value);
//       if (value.trim().isNotEmpty) {
//         // TODO: confirm this matches your AnimeCubit's method signature
//         context.read<AnimeCubit>().searchProducer(value.trim());
//       }
//     });
//   }

//   void _toggleSelected(ProducerModel item) {
//     final id = item.mal_id;
//     if (id == null) return;
//     setState(() {
//       if (selectedMap.containsKey(id)) {
//         item.isSelected = false;
//         selectedMap.remove(id);
//       } else {
//         item.isSelected = true;
//         selectedMap[id] = item;
//       }
//     });
//   }

//   /// Selected items missing from the currently displayed list — e.g. picked
//   /// while searching, then the search was cleared or the dialog reopened —
//   /// get pinned to the front so the user always sees what they've chosen.
//   List<ProducerModel> _pinnedSelected(List<ProducerModel> displayed) {
//     final displayedIds = displayed.map((e) => e.mal_id).toSet();
//     return selectedMap.values
//         .where((e) => !displayedIds.contains(e.mal_id))
//         .toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Dialog(
//       backgroundColor: theme.colorScheme.secondary,
//       insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
//       child: ConstrainedBox(
//         constraints: const BoxConstraints(maxHeight: 650),
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header
//               Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       widget.title,
//                       style: theme.textTheme.titleMedium,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () => Navigator.pop(context),
//                     icon: const Icon(Icons.close),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),

//               // Search
//               TextField(
//                 onChanged: _onSearchChanged,
//                 enableInlinePrediction: false,
//                 autocorrect: false,
//                 decoration: InputDecoration(
//                   hintText: 'Search ${widget.title.toLowerCase()}...',
//                   prefixIcon: const Icon(Icons.search),
//                   isDense: true,
//                   constraints: const BoxConstraints(
//                     minHeight: 46,
//                     maxHeight: 46,
//                   ),
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 16),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // Selected count
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 12),
//                 child: Text(
//                   '${selectedMap.length} selected',
//                   style: theme.textTheme.bodyMedium?.copyWith(
//                     color: theme.colorScheme.primary,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),

//               // Chips
//               Expanded(
//                 child: _query.trim().isEmpty
//                     ? _buildChipList(widget.items)
//                     : BlocBuilder<AnimeCubit, AnimeState>(
//                         // TODO: rename these fields to whatever your
//                         // AnimeState actually calls the producer search
//                         // results list and its loading flag.
//                         buildWhen: (prev, curr) =>
//                             prev.producerSearchResults !=
//                                 curr.producerSearchResults ||
//                             prev.isSearchingProducer !=
//                                 curr.isSearchingProducer,
//                         builder: (context, state) {
//                           if (state.isSearchingProducer) {
//                             return const Center(
//                               child: Padding(
//                                 padding: EdgeInsets.only(top: 40),
//                                 child: CircularProgressIndicator(),
//                               ),
//                             );
//                           }
//                           return _buildChipList(state.producerSearchResults);
//                         },
//                       ),
//               ),
//               const SizedBox(height: 16),

//               // Apply
//               SizedBox(
//                 width: double.infinity,
//                 height: 48,
//                 child: FilledButton.icon(
//                   onPressed: () {
//                     Navigator.pop(context, selectedMap.values.toList());
//                   },
//                   icon: const Icon(Icons.check),
//                   label: const Text('Apply'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildChipList(List<ProducerModel> items) {
//     final pinned = _pinnedSelected(items);
//     final combined = [...pinned, ...items];

//     return SingleChildScrollView(
//       child: Wrap(
//         spacing: 8,
//         runSpacing: 8,
//         children: combined.map((item) {
//           final isSelected =
//               item.mal_id != null && selectedMap.containsKey(item.mal_id);
//           return FilterChip(
//             label: Text(item.name ?? '---'),
//             selected: isSelected,
//             selectedColor: Theme.of(context).colorScheme.primary,
//             checkmarkColor: Colors.black,
//             labelStyle: TextStyle(
//               color: isSelected ? Colors.black : Colors.white,
//             ),
//             onSelected: (_) => _toggleSelected(item),
//             showCheckmark: true,
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
