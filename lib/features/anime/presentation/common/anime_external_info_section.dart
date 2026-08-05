import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AnimeExternalInfoSection extends StatelessWidget {
  final AnimeDetailsModel data;
  final void Function(String) onTap;

  const AnimeExternalInfoSection({
    super.key,
    required this.data,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //*======= STUDIOS
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/ic_music.svg",
                    colorFilter: const ColorFilter.mode(
                      primary,
                      BlendMode.srcIn,
                    ),
                    height: 24,
                    width: 24,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    "STUDIOS",
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: white),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                direction: Axis.horizontal,
                children: List.generate(data.studios?.length ?? 0, (index) {
                  return InkWell(
                    onTap: () {
                      onTap(data.studios![index].url ?? '--');
                    },
                    child: Chip(
                      label: Text(data.studios![index].name ?? "---"),
                      color: const WidgetStatePropertyAll(tertiary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(8),
                        side: const BorderSide(color: primary, width: 1),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),

          const SizedBox(height: 24),
          //*======== Peoducers
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/ic_cinema.svg",
                    colorFilter: const ColorFilter.mode(
                      primary,
                      BlendMode.srcIn,
                    ),
                    height: 24,
                    width: 24,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    "PRODUCERS",
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: white),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                direction: Axis.horizontal,
                children: List.generate(data.producers?.length ?? 0, (index) {
                  return Chip(
                    label: Text(data.producers![index].name ?? "---"),
                    color: const WidgetStatePropertyAll(tertiary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(8),
                      side: const BorderSide(color: primary, width: 1),
                    ),
                  );
                }),
              ),
            ],
          ),

          const SizedBox(height: 24),
          //*======= licensors
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/ic_certificate.svg",
                    colorFilter: const ColorFilter.mode(
                      primary,
                      BlendMode.srcIn,
                    ),
                    height: 24,
                    width: 24,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    "LICENSORS",
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: white),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,

                direction: Axis.horizontal,
                children: List.generate(data.licensors?.length ?? 0, (index) {
                  return Chip(
                    label: Text(data.licensors![index].name ?? "---"),
                    color: const WidgetStatePropertyAll(tertiary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(8),
                      side: const BorderSide(color: primary, width: 1),
                    ),
                  );
                }),
              ),
            ],
          ),

          const SizedBox(height: 24),

          //*========= external
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/ic_external_link.svg",
                    colorFilter: const ColorFilter.mode(
                      primary,
                      BlendMode.srcIn,
                    ),
                    height: 24,
                    width: 24,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    "EXTERNAL",
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: white),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                direction: Axis.horizontal,
                children: List.generate(data.external?.length ?? 0, (index) {
                  return Chip(
                    label: Text(data.external![index].name ?? "---"),
                    color: const WidgetStatePropertyAll(tertiary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(8),
                      side: const BorderSide(color: primary, width: 1),
                    ),
                  );
                }),
              ),
            ],
          ),
        ], //? end
      ),
    );
  }
}
