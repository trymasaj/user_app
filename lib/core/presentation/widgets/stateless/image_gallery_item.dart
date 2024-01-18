import 'package:flutter/material.dart';
import 'package:masaj/core/presentation/dialogs/image_interactive_dialog.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_cached_network_image.dart';

class ImageGalleryItem extends StatelessWidget {
  const ImageGalleryItem({
    super.key,
    required this.images,
    required this.index,
    this.width = 150.0,
    this.height = 150.0,
  });

  final List<String> images;
  final int index;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => openFullImage(
        context: context,
        images: images,
        index: index,
      ),
      child: Container(
        margin: const EdgeInsets.all(8.0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: CustomCachedNetworkImage(
          imageUrl: images[index],
          fit: BoxFit.cover,
          urlHeight: height,
          urlWidth: width,
        ),
      ),
    );
  }
}
