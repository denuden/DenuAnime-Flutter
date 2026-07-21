import 'package:denuanime/features/anime/domain/entities/voice_actor_model.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';

class PersonCardLanguageItem extends StatelessWidget {
  final VoiceActorModel voiceActorModel;
  const PersonCardLanguageItem({super.key, required this.voiceActorModel});

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      child: Padding(
        padding: const EdgeInsetsGeometry.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //*Image
            ClipOval(
              child: Image.network(
                voiceActorModel.person?.images?.jpg?.image_url ?? '',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 16),
            //*Details
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      //TODO
                      // voiceActorModel.person?.url ?? '---',
                    },
                    child: Text(
                      "Web Profile",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        decoration: TextDecoration.underline,
                        color: primaryLight,
                        decorationColor: primaryLight,
                      ),
                    ),
                  ),

                  Text(
                    voiceActorModel.person?.name ?? '---',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  Text(
                    voiceActorModel.language ?? '---',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
