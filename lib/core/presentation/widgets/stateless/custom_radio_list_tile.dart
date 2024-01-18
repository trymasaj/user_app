import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';

class CustomRadioListTile<T> extends StatelessWidget {
  final Widget label;
  final T value;
  final T groupValue;
  final ValueChanged<T> onValueSelected;

  const CustomRadioListTile({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onValueSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return InkWell(
      onTap: () => onValueSelected(value), // Calling the callback with value
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
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
        child: ListTile(
          title: label,
          trailing: _buildTrailingIndicator(isSelected: isSelected),
        ),
      ),
    );
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

  Widget _buildTrailingIndicator({required bool isSelected}) {
    return Container(
      height: 16.0,
      width: 16.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: isSelected ? AppColors.GRADIENT_COLOR : null,
        color: isSelected ? null : Colors.grey,
        shape: BoxShape.circle,
      ),
      child: Container(
        height: isSelected ? 5 : 14,
        width: isSelected ? 5 : 14,
        decoration: const BoxDecoration(
          color: Color(0xFFF6F6F6),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
