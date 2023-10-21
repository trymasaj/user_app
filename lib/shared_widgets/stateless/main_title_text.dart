import '../../res/style/app_colors.dart';
import 'package:flutter/material.dart';

class MainTitleText extends StatelessWidget {
  const MainTitleText(
      {super.key, required String title, double horizontalPadding = 16.0})
      : _title = title,
        _horizontalPadding = horizontalPadding;

  final String _title;
  final double _horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: 8.0, horizontal: _horizontalPadding),
      child: Row(
        children: [
          Text(
            _title,
            style: const TextStyle(
              color: AppColors.PRIMARY_COLOR,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(child: Container(height: 2, color: Colors.black))
        ],
      ),
    );
  }
}
