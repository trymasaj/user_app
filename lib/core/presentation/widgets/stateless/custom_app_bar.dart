import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.centerTitle,
    this.actions,
    this.elevation,
  });

  final bool? centerTitle;
  final List<Widget>? actions;

  final String title;
  final double? elevation;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class _CustomAppBarState extends State<CustomAppBar> {
  late final bool canPop;
  @override
  void initState() {
    canPop = Navigator.of(context).canPop();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: CustomText(
        text: widget.title,
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      leadingWidth: 75,
      titleSpacing: 20,

      leading: canPop ? _buildBackButton(context) : null,
      // the following line is to center the title when there is no back button
      centerTitle: widget.centerTitle ?? !canPop,
      actions: widget.actions,
      elevation: widget.elevation ?? 1,
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return RotatedBox(
      quarterTurns: context.locale.languageCode == 'ar' ? 2 : 0,
      child: InkWell(
        onTap: NavigatorHelper.of(context).pop,
        child: Padding(
          padding: const EdgeInsets.only(right: 32),
          child: SvgPicture.asset(
            'assets/images/back_icon.svg',
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
