import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
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
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();
    return AppBar(
      backgroundColor: Colors.white,
      title: CustomText(
        text: title,
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      leadingWidth: 75,
      titleSpacing: 0,
      leading: canPop ? _buildBackButton(context) : null,
      // the following line is to center the title when there is no back button
      centerTitle: centerTitle ?? !canPop,
      actions: actions,
      elevation: elevation ?? 1,
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return InkWell(
      onTap: NavigatorHelper.of(context).pop,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Transform.flip(
          flipX: Directionality.of(context) == TextDirection.rtl,
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
