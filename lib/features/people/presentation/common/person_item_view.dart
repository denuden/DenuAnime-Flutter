import 'package:denuanime/features/people/domain/entities/people_model.dart';
import 'package:denuanime/utils/datetime_formatter.dart';
import 'package:flutter/material.dart';

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
            height: 70,
            width: 70,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          people.name ?? "---",
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        Text(
          DateTimeFormatter.formatFromIso(
            people.birthday ?? "---",
            "MMM dd, yyyy",
          ),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
