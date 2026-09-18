import 'package:denuanime/features/anime/domain/entities/recommendation_model.dart';
import 'package:denuanime/features/anime/presentation/common/anime_vertical_card_item.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:denuanime/utils/app_web_view.dart';
import 'package:flutter/material.dart';

class RecommendationItem extends StatefulWidget {
  final RecommendationModel recommendationModel;
  final void Function(int) onLearnMore;
  const RecommendationItem({
    super.key,
    required this.recommendationModel,
    required this.onLearnMore,
  });

  @override
  State<RecommendationItem> createState() => _RecommendationItemState();
}

class _RecommendationItemState extends State<RecommendationItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return widget.recommendationModel.entry?.isNotEmpty == true &&
            widget.recommendationModel.entry?.length == 2
        ? Card.filled(
            color: secondary,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                children: [
                  //* === items with images and title
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: AnimeVerticalCardItem(
                            animeDetailsModel:
                                widget.recommendationModel.entry![0],
                            isFromRecommendationEndpoint: true,
                            onLearnMore: widget.onLearnMore,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: AnimeVerticalCardItem(
                            animeDetailsModel:
                                widget.recommendationModel.entry![1],
                            isFromRecommendationEndpoint: true,
                            onLearnMore: widget.onLearnMore,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  const Divider(height: 1, thickness: 0.2),
                  const SizedBox(height: 16),
                  //* recommendation info
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: BoxBorder.all(width: 0.3, color: white),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.lightbulb_outlined,
                              color: primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Why we recommended this",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(8),

                                onTap: () {
                                  final url =
                                      widget.recommendationModel.user?.url;
                                  if (url != null || url?.isNotEmpty == true) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute<AppWebView>(
                                        builder: (_) => AppWebView(url: url!),
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  "Credits to: ${widget.recommendationModel.user?.url ?? '---'}",
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: primarySoft,
                                        fontWeight: FontWeight.w300,
                                      ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              //? === long text
                              AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                child: Text(
                                  widget.recommendationModel.content ??
                                      'Nothing to compare.',

                                  maxLines: _expanded ? null : 5,
                                  overflow: _expanded
                                      ? TextOverflow.visible
                                      : TextOverflow.ellipsis,
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
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          )
        : const Text('No entry found for recommendation');
  }
}
