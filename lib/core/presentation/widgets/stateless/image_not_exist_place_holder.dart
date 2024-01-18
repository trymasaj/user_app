import 'package:flutter/widgets.dart';

class ImageNotExistPlaceHolder extends StatelessWidget {
  const ImageNotExistPlaceHolder({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Image.asset(
        'assets/images/saudi_place_holder.png',
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}
