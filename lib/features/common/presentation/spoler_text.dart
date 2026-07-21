import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';

class SpoilerText extends StatelessWidget {
  final String text;
  final TextOverflow? overflow;
  final TextStyle? style;
  final int? maxlines;

  const SpoilerText({
    super.key,
    required this.text,
    this.style,
    this.overflow,
    this.maxlines,
  });

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];
    // Find every [Spoiler]...[/Spoiler] block.
    // allMatches() returns one Match object per spoiler found.
    final regex = RegExp(r'\[Spoiler\](.*?)\[/Spoiler\]', dotAll: true);

    int last = 0;

    for (final match in regex.allMatches(text)) {
      // Normal text before spoiler
      final before = text.substring(last, match.start).trim();

      if (before.isNotEmpty) {
        widgets.add(Text(before, style: style));

        widgets.add(const SizedBox(height: 12));
      }

      // Spoiler
      // group(1) is the captured text inside
      // [Spoiler]...[/Spoiler]
      widgets.add(_SpoilerBlock(text: match.group(1)!.trim(), style: style));

      widgets.add(const SizedBox(height: 12));

      // Move the cursor after this spoiler so the
      // next iteration starts from here.
      last = match.end;
    }

    // Remaining text
    // Anything after the last spoiler.
    final after = text.substring(last).trim();

    if (after.isNotEmpty) {
      widgets.add(Text(after, style: style));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}

class _SpoilerBlock extends StatefulWidget {
  final String text;
  final TextStyle? style;

  const _SpoilerBlock({required this.text, this.style});

  @override
  State<_SpoilerBlock> createState() => _SpoilerBlockState();
}

class _SpoilerBlockState extends State<_SpoilerBlock> {
  bool revealed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: () {
        setState(() {
          revealed = !revealed;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: revealed ? secondary : textSecondary,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          widget.text,
          style: widget.style?.copyWith(
            color: revealed ? widget.style?.color : Colors.transparent,
          ),
        ),
      ),
    );
  }
}
