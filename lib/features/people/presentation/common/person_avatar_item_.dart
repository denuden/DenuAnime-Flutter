import 'package:denuanime/features/people/domain/entities/people_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PersonItemView extends StatelessWidget {
  final PeopleModel people;

  const PersonItemView({super.key, required this.people});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipOval(
          child: Image.network(
            people.images?.jpg?.image_url ?? "",
            height: 80,
            width: 80,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 2),
        SizedBox(
          width: 100,
          child: Text(
            maxLines: 1,
            people.name ?? "---",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),

        Row(
          children: [
            const Icon(Icons.favorite_outline, size: 16),
            const SizedBox(width: 4),
            Text(
              NumberFormat.decimalPattern().format(people.favorites),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}
