import 'package:flutter/material.dart';

class CustomImageWidget extends StatelessWidget {
  const CustomImageWidget({
    super.key,
    this.imageUrl,
    this.assetPath,
    this.width,
    this.height,
    this.fit,
    this.semanticLabel,
  });

  final String? imageUrl;
  final String? assetPath;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    if (assetPath != null) {
      return Image.asset(
        assetPath!,
        width: width,
        height: height,
        fit: fit,
        semanticLabel: semanticLabel,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            color: Colors.grey[200],
            child: const Icon(Icons.broken_image),
          );
        },
      );
    } else if (imageUrl != null) {
      return Image.network(
        imageUrl!,
        width: width,
        height: height,
        fit: fit,
        semanticLabel: semanticLabel,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            color: Colors.grey[200],
            child: const Icon(Icons.broken_image),
          );
        },
      );
    }
    return SizedBox(width: width, height: height);
  }
}
