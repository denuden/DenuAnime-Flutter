import 'package:denuanime/features/people/domain/entities/voices_model.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';

class PersonCharacterItem extends StatelessWidget {
  final VoicesModel voicesModel;
  const PersonCharacterItem({super.key, required this.voicesModel});

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.network(
                height: 80,
                width: 80,
                voicesModel.character?.images?.jpg?.image_url ?? '',
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    voicesModel.character?.name ?? '---',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: inversePrimary),
                  ),
                  const SizedBox(height: 4),
                  Text(voicesModel.anime?.title ?? '---'),
                ],
              ),
            ),

            const SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: Align(
                alignment: AlignmentGeometry.centerEnd,
                child: Text(
                  voicesModel.role ?? 'No role',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: inversePrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
