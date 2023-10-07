import 'package:flutter/material.dart';

class DotsIndicator extends StatelessWidget {
  const DotsIndicator({
    Key? key,
    required this.indicatorCount,
    required this.pageNumber,
    this.mainAxisAlignment = MainAxisAlignment.spaceAround,
    this.color = Colors.white,
    this.spaceBetween = 6.0,
  }) : super(key: key);

  final int indicatorCount;
  final int pageNumber;
  final MainAxisAlignment mainAxisAlignment;
  final Color color;
  final double spaceBetween;

  @override
  Widget build(BuildContext context) {
    final indicatorsList = List.generate(
        indicatorCount, (index) => _buildDot(index == pageNumber));
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: mainAxisAlignment,
      children: indicatorsList,
    );
  }

  Widget _buildDot(bool active) {
    return Flexible(
      child: Container(
        height: 12.0,
        width: 12.0,
        margin: EdgeInsets.symmetric(horizontal: spaceBetween),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: active ? color : color.withOpacity(0.3),
        ),
      ),
    );
  }
}
