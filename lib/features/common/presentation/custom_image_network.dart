import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImageNetwork extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double? width;
  final BoxFit? boxFit;

  const CustomImageNetwork(
    this.imageUrl, {
    super.key,
    required this.height,
    this.width,
    this.boxFit,
  });

  @override
  Widget build(BuildContext context) {
    final placeholderColor = Theme.of(context).colorScheme.secondary;

    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: boxFit ?? BoxFit.cover,
        progressIndicatorBuilder: (context, url, progress) => Container(
          color: placeholderColor,
          alignment: Alignment.center,
          child: CircularProgressIndicator(value: progress.progress),
        ),
        errorWidget: (context, url, error) {
          debugPrint('Image failed: $url ($error)');
          return Container(
            color: placeholderColor,
            alignment: Alignment.center,
            child: const Icon(Icons.broken_image),
          );
        },
      ),
    );
  }
}
