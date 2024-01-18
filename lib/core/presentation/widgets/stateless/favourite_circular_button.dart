import 'package:flutter/material.dart';

class FavouriteCircularButton extends StatelessWidget {
  const FavouriteCircularButton({super.key, required this.isFavourite});

  final bool isFavourite;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (Rect bounds) => const RadialGradient(
          center: Alignment.bottomCenter,
          stops: [.5, 1],
          colors: [
            Color(0xffCCA3B7),
            Color(0xffEDA674),
          ],
        ).createShader(bounds),
        child: Icon(
          isFavourite ? Icons.favorite : Icons.favorite_border,
          size: 133,
        ),
      ),
    );
  }
}
