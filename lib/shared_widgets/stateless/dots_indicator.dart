import 'package:flutter/material.dart';

class DotsIndicator extends StatelessWidget {
  const DotsIndicator({
    Key? key,
    required this.indicatorCount,
    required this.pageNumber,
    this.mainAxisAlignment = MainAxisAlignment.spaceAround,
    this.color = Colors.white,
    this.spaceBetween = 6.0,
    this.isExpanded = false,
  }) : super(key: key);

  final int indicatorCount;
  final int pageNumber;
  final MainAxisAlignment mainAxisAlignment;
  final Color color;
  final double spaceBetween;
  final bool isExpanded;

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
        height: 3.0,
        width: isExpanded ? null : 22.0,
        margin: EdgeInsets.symmetric(horizontal: spaceBetween),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: active ? color : color.withOpacity(0.3),
          borderRadius: BorderRadius.circular(3.0),
        ),
      ),
    );
  }
}
