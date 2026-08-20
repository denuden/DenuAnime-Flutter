import 'package:denuanime/features/anime/domain/entities/recent_episodes_model.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:denuanime/utils/app_web_view.dart';
import 'package:denuanime/utils/datetime_formatter.dart';
import 'package:denuanime/utils/format_duration.dart';
import 'package:denuanime/utils/format_shorthand_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class AnimeHorizontalCardItem extends StatelessWidget {
  final RecentEpisodesModel model;
  final void Function() onClickItem;
  const AnimeHorizontalCardItem({
    super.key,
    required this.model,
    required this.onClickItem,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onClickItem,
        child: Row(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 215,
                  width: 140,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    child: Image.network(
                      fit: BoxFit.cover,
                      model.entry?.images?.jpg?.large_image_url ?? '',
                    ),
                  ),
                ),

                Positioned.fill(
                  child: Center(
                    child: Material(
                      color: background,
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: () {
                          final url = model.entry?.trailer?.url;
                          if (url == null || url.isEmpty) {
                            final messenger = ScaffoldMessenger.of(context);
                            messenger.hideCurrentSnackBar();
                            messenger.showSnackBar(
                              SnackBar(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    12,
                                  ),
                                ),
                                backgroundColor: error,
                                content: Text(
                                  'No trailer found',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(color: inversePrimary),
                                ),
                                behavior: SnackBarBehavior.floating,
                                duration: const Duration(seconds: 3),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute<AppWebView>(
                                builder: (_) => AppWebView(
                                  url: model.entry?.trailer?.url ?? '',
                                ),
                              ),
                            );
                          }
                        },
                        borderRadius: BorderRadius.circular(50),
                        child: const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            size: 24,
                            color: primaryDark,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: 5,
                  bottom: 5,
                  child: InkWell(
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadiusGeometry.all(
                          Radius.circular(8),
                        ),
                        color: background,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),

                      child: Text(
                        formatDuration(model.entry?.trailer?.duration ?? '---'),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 4),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.entry?.title_english ?? 'Unknown Title',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: inversePrimary,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    //? ==== meta data
                    const SizedBox(height: 8),
                    FractionallySizedBox(
                      widthFactor: 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.remove_red_eye_outlined,
                                size: 16,
                                color: primaryLight,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                formatShorthandNumber(
                                  model.entry?.trailer?.views ?? 0,
                                ),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.thumb_up_alt_outlined,
                                size: 16,
                                color: primaryLight,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                formatShorthandNumber(
                                  model.entry?.trailer?.likes ?? 0,
                                ),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.comment_outlined,
                                size: 16,
                                color: primaryLight,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                formatShorthandNumber(
                                  model.entry?.trailer?.comment_count ?? 0,
                                ),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    //?==== youtube title
                    const SizedBox(height: 12),
                    Text(
                      model.entry?.trailer?.title ?? 'Unknown youtube title',
                      maxLines: 3,
                    ),
                    const SizedBox(height: 4),

                    //?==== date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.date_range_outlined,
                          size: 16,
                          color: primaryLight,
                        ),
                        const SizedBox(width: 2),
                        Flexible(
                          child: Text(
                            DateTimeFormatter.formatFromIso(
                              model.entry?.trailer?.published_at ?? '',
                              "dd-MM-yy",
                            ),
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    const Divider(height: 1, thickness: 1, color: divider),
                    const SizedBox(height: 6),

                    //? watch buttons
                    Row(
                      children: [
                        TextButton(
                          style: const ButtonStyle(
                            padding: WidgetStatePropertyAll(
                              EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                            ),
                            minimumSize: WidgetStatePropertyAll(Size.zero),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                          ),
                          onPressed: () async {
                            final youtubeId = model.entry?.trailer?.youtube_id;

                            if (youtubeId == null || youtubeId.isEmpty) {
                              final messenger = ScaffoldMessenger.of(context);
                              messenger.hideCurrentSnackBar();
                              messenger.showSnackBar(
                                SnackBar(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      12,
                                    ),
                                  ),
                                  backgroundColor: error,
                                  content: Text(
                                    'No trailer found',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: inversePrimary),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                              return;
                            }
                            final youtubeAppUri = Uri.parse(
                              'youtube://watch?v=$youtubeId',
                            );

                            final youtubeWebUri = Uri.parse(
                              model.entry?.trailer?.url ?? '',
                            );
                            // debugPrint(
                            //   (await canLaunchUrl(youtubeWebUri)).toString(),
                            // );
                            // debugPrint(
                            //   (await canLaunchUrl(youtubeAppUri)).toString(),
                            // );
                            // await launchUrl(
                            //   youtubeWebUri,
                            //   mode: LaunchMode.platformDefault,
                            // );
                            // return;
                            if (await canLaunchUrl(youtubeAppUri)) {
                              await launchUrl(
                                youtubeAppUri,
                                mode: LaunchMode.externalNonBrowserApplication,
                              );
                            } else if (await canLaunchUrl(youtubeWebUri)) {
                              await launchUrl(
                                youtubeWebUri,
                                mode: LaunchMode.platformDefault,
                              );
                            }
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/ic_youtube.svg",
                                height: 16,
                                width: 16,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Watch on YouTube",
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: primary,
                                      letterSpacing: 0.02,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
