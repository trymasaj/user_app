import 'package:flutter/material.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';

class WarningContainer extends StatelessWidget {
  const WarningContainer({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.PRIMARY_DARK_COLOR.withOpacity(0.08)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Icon(Icons.info_outline_rounded,
            size: 25, color: AppColors.PRIMARY_DARK_COLOR),
        const SizedBox(width: 6),
        Expanded(
            child: SubtitleText(
          text: title,
          subtractedSize: 2.5,
        ))
      ]),
    );
  }
}
