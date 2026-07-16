import 'package:flutter/material.dart';

class CustomImageNetwork extends StatelessWidget {
  final String imageUrl;
  final double height;
  const CustomImageNetwork(this.imageUrl, {super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Image.network(
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded || frame != null) {
            return child;
          }

          return Container(
            color: Theme.of(context).colorScheme.secondary,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }

          return Container(
            color: Theme.of(context).colorScheme.secondary,
            alignment: Alignment.center,
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Theme.of(context).colorScheme.secondary,
            alignment: Alignment.center,
            child: const Icon(Icons.broken_image),
          );
        },
        fit: BoxFit.cover,
        imageUrl,
      ),
    );
  }
}
