import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../res/style/app_colors.dart';
import '../stateful/default_button.dart';
import '../stateless/title_text.dart';

class RootDialog extends StatelessWidget {
  const RootDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTopDialogSection(),
            _buildBottomDialogSection(),
          ]),
    );
  }

  Widget _buildTopDialogSection() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.PRIMARY_COLOR,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      child: const Padding(
        padding: EdgeInsets.all(24.0),
        child: TitleText(
          text: 'root_detected',
          textAlign: TextAlign.center,
          maxLines: 4,
          margin: EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _buildBottomDialogSection() {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: DefaultButton(
          label: 'close'.tr(),
          isExpanded: true,
          onPressed: () {
            exit(0);
          },
        ),
      ),
    );
  }
}
