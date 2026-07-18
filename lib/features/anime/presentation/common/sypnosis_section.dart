import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';

class SypnosisSection extends StatefulWidget {
  final String synopsis;

  const SypnosisSection({super.key, required this.synopsis});

  @override
  State<SypnosisSection> createState() => _SypnosisSectionState();
}

class _SypnosisSectionState extends State<SypnosisSection> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Text(
            widget.synopsis.isEmpty ? "Nondescript" : widget.synopsis,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: white),
            maxLines: _expanded ? null : 5,
            overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
          ),
        ),

        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
            child: Text(
              _expanded ? "Hide" : "See more",
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
