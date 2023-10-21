import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:masaj/shared_widgets/stateless/gradient_text.dart';

class CustomChip<T> extends StatelessWidget {
  final String label;
  final T value;
  final T groupValue;
  final ValueChanged<T> onValueSelected;
  final double? width;
  final double? height;
  final bool? isExpanded;

  const CustomChip({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onValueSelected,
    this.width,
    this.height,
    this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    final child = GestureDetector(
      onTap: () => onValueSelected(value), // Calling the callback with value
      child: Container(
        width: width,
        height: height ?? 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          border: isSelected
              ? _buildGradientBorder()
              : Border.all(
                  color: Colors.transparent,
                ),
          gradient: isSelected
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0, 0.9667],
                  colors: [
                    const Color(0xFFCCA3B7).withOpacity(0.1),
                    const Color(0xFFEDA674).withOpacity(0.1),
                  ],
                )
              : null,
          color: isSelected ? null : const Color(0xFFF6F6F6),
        ),
        child: GestureDetector(
          onTap: () => onValueSelected(value),
          child: GradientText(
            label,
            textAlign: TextAlign.center,
            colors: isSelected
                ? [
                    const Color(0xFFCCA3B7),
                    const Color(0xFFEDA674),
                  ]
                : [
                    const Color(0xFF181B28).withOpacity(0.7),
                    const Color(0xFF181B28).withOpacity(0.7),
                  ],
          ),
        ),
      ),
    );

    if (isExpanded ?? false) {
      return Expanded(child: child);
    }
    return child;
  }

  GradientBoxBorder _buildGradientBorder() {
    return const GradientBoxBorder(
      gradient: LinearGradient(colors: [
        Color(0xFFCCA3B7),
        Color(0xFFEDA674),
      ]),
      width: 1,
    );
  }
}
