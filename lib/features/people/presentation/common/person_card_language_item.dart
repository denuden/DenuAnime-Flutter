import 'package:denuanime/features/anime/domain/entities/voice_actor_model.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PersonCardLanguageItem extends StatelessWidget {
  final VoiceActorModel voiceActorModel;
  final bool isSelected;
  final void Function() onSelect;
  final void Function(String) onClickWebProfile;
  const PersonCardLanguageItem({
    super.key,
    required this.voiceActorModel,
    required this.isSelected,
    required this.onSelect,
    required this.onClickWebProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onSelect,
          child: Card.filled(
            child: Padding(
              padding: const EdgeInsetsGeometry.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //*Image
                  ClipOval(
                    child: Skeleton.replace(
                      replacement: const Bone.circle(size: 80),
                      child: Image.network(
                        voiceActorModel.person?.images?.jpg?.image_url ?? '',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
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
                            onClickWebProfile(
                              voiceActorModel.person?.url ?? '',
                            );
                          },
                          child: Text(
                            "Web Profile",
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  decoration: TextDecoration.underline,
                                  color: primaryLight,
                                  decorationColor: primaryLight,
                                ),
                          ),
                        ),

                        Text(
                          voiceActorModel.person?.name ?? '---',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),

                        Text(
                          voiceActorModel.language ?? '---',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        Positioned(
          top: 16,
          right: 16,
          child: Icon(isSelected ? Icons.check_circle : Icons.circle_outlined),
        ),
      ],
    );
  }
}
