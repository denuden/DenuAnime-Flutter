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
                    "assets/icons/ic_camera.svg",
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
                  return ActionChip(
                    onPressed: () {
                      onTap(data.studios![index].url ?? '--');
                    },
                    label: Text(data.studios![index].name ?? "---"),
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
                children: data.producers?.isNotEmpty == true
                    ? List.generate(data.producers?.length ?? 0, (index) {
                        return ActionChip(
                          onPressed: () {
                            onTap(data.producers![index].url ?? '--');
                          },
                          label: Text(data.producers![index].name ?? "---"),
                          color: const WidgetStatePropertyAll(tertiary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8),
                            side: const BorderSide(color: primary, width: 1),
                          ),
                        );
                      })
                    : [const Text("No producers found.")],
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
                children: data.licensors?.isNotEmpty == true
                    ? List.generate(data.licensors?.length ?? 0, (index) {
                        return ActionChip(
                          onPressed: () {
                            onTap(data.licensors![index].url ?? '--');
                          },
                          label: Text(data.licensors![index].name ?? "---"),
                          color: const WidgetStatePropertyAll(tertiary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8),
                            side: const BorderSide(color: primary, width: 1),
                          ),
                        );
                      })
                    : [const Text("No licensors found.")],
              ),
            ],
          ),

          const SizedBox(height: 24),

          //*========= sttreaming
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/ic_live.svg",
                    colorFilter: const ColorFilter.mode(
                      primary,
                      BlendMode.srcIn,
                    ),
                    height: 24,
                    width: 24,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    "STREAMING",
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
                children: data.streaming?.isNotEmpty == true
                    ? List.generate(data.streaming?.length ?? 0, (index) {
                        return ActionChip(
                          onPressed: () {
                            onTap(data.streaming![index].url ?? '--');
                          },
                          label: Text(data.streaming![index].name ?? "---"),
                          color: const WidgetStatePropertyAll(tertiary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8),
                            side: const BorderSide(color: primary, width: 1),
                          ),
                        );
                      })
                    : [const Text("No streaming platform found.")],
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
                children: data.external?.isNotEmpty == true
                    ? List.generate(data.external?.length ?? 0, (index) {
                        return ActionChip(
                          onPressed: () {
                            onTap(data.external![index].url ?? '--');
                          },
                          label: Text(data.external![index].name ?? "---"),
                          color: const WidgetStatePropertyAll(tertiary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8),
                            side: const BorderSide(color: primary, width: 1),
                          ),
                        );
                      })
                    : [const Text("No external found.")],
              ),
            ],
          ),

          const SizedBox(height: 24),
          //* ========= theme songs
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
                    "THEME SONGS",
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: white),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    //* ====== opening themes
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/ic_wave_sound.svg",
                          colorFilter: const ColorFilter.mode(
                            primary,
                            BlendMode.srcIn,
                          ),
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          "OPENING THEMES",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(color: primary),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // *======== list opening
                    Column(
                      children: data.theme?.openings?.isNotEmpty == true
                          ? List.generate(data.theme?.openings?.length ?? 0, (
                              index,
                            ) {
                              final regex = RegExp(
                                r'^(?:(?:\d+):\s*)?"(.+?)"\s*by\s*(.+?)(?:\s*\((eps.*?)\))?$',
                              );

                              final match = regex.firstMatch(
                                data.theme?.openings?[index] ?? '',
                              );

                              if (match != null) {
                                final title = match.group(1)!;
                                final artist = match.group(2)!;
                                final episodes = match.group(3) ?? '';
                                final hasEpisodes = episodes.isNotEmpty;

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: secondary,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentGeometry.topLeft,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: BoxBorder.all(
                                                  color: primary,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  8.0,
                                                ),
                                                child: Text(
                                                  (index + 1).toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                        color: primary,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),

                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  title,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(color: white),
                                                ),
                                                Text(
                                                  artist,
                                                  style: Theme.of(
                                                    context,
                                                  ).textTheme.bodyMedium,
                                                ),
                                              ],
                                            ),
                                          ),

                                          const SizedBox(width: 8),

                                          if (hasEpisodes)
                                            Chip(
                                              labelPadding:
                                                  const EdgeInsets.all(0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadiusGeometry.circular(
                                                      8,
                                                    ),
                                                side: const BorderSide(
                                                  color: primary,
                                                  width: 1,
                                                ),
                                              ),
                                              label: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.calendar_month,
                                                    color: primary,
                                                    size: 16,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    episodes,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall
                                                        ?.copyWith(
                                                          color: primary,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return const SizedBox();
                              }
                            })
                          : [
                              const Center(
                                child: Text("No opening theme songs"),
                              ),
                            ],
                    ), // end opening

                    const SizedBox(height: 24),

                    //* =========== ending themes
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/ic_wave_sound.svg",
                          colorFilter: const ColorFilter.mode(
                            primary,
                            BlendMode.srcIn,
                          ),
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          "ENDING THEMES",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(color: primary),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // *======== list ending
                    Column(
                      children: data.theme?.endings?.isNotEmpty == true
                          ? List.generate(data.theme?.endings?.length ?? 0, (
                              index,
                            ) {
                              final regex = RegExp(
                                r'^(?:(?:\d+):\s*)?"(.+?)"\s*by\s*(.+?)(?:\s*\((eps.*?)\))?$',
                              );

                              final match = regex.firstMatch(
                                data.theme?.endings?[index] ?? '',
                              );

                              if (match != null) {
                                final title = match.group(1)!;
                                final artist = match.group(2)!;
                                final episodes = match.group(3) ?? '';
                                final hasEpisodes = episodes.isNotEmpty;

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: secondary,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentGeometry.topLeft,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: BoxBorder.all(
                                                  color: primary,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  8.0,
                                                ),
                                                child: Text(
                                                  (index + 1).toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                        color: primary,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),

                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  title,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(color: white),
                                                ),
                                                Text(
                                                  artist,
                                                  style: Theme.of(
                                                    context,
                                                  ).textTheme.bodyMedium,
                                                ),
                                              ],
                                            ),
                                          ),

                                          const SizedBox(width: 8),
                                          if (hasEpisodes)
                                            Chip(
                                              labelPadding:
                                                  const EdgeInsets.all(0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadiusGeometry.circular(
                                                      8,
                                                    ),
                                                side: const BorderSide(
                                                  color: primary,
                                                  width: 1,
                                                ),
                                              ),
                                              label: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.calendar_month,
                                                    color: primary,
                                                    size: 16,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    episodes,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall
                                                        ?.copyWith(
                                                          color: primary,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return const SizedBox();
                              }
                            })
                          : [
                              const Center(
                                child: Text("No ending theme songs"),
                              ),
                            ],
                    ), // end ending
                  ],
                ),
              ),
            ],
          ),
        ], //? end
      ),
    );
  }
}
