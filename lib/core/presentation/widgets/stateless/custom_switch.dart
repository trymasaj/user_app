import 'package:flutter/cupertino.dart';
import 'package:masaj/core/presentation/theme/theme_helper.dart';

class CustomSwitch extends StatelessWidget {
  CustomSwitch({
    super.key,
    this.onChange,
    this.alignment,
    this.value,
    this.width,
    this.height,
    this.margin,
  });

  final Alignment? alignment;

  bool? value;

  final Function(bool)? onChange;

  final double? width;

  final double? height;

  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        margin: margin,
        child: alignment != null
            ? Align(
                alignment: alignment ?? Alignment.center,
                child: switchWidget,
              )
            : switchWidget);
  }

  Widget get switchWidget => CupertinoSwitch(
        value: value ?? false,
        trackColor: appTheme.gray40001.withOpacity(0.46),
        activeColor: appTheme.deepOrangeA100.withOpacity(0.46),
        onChanged: onChange
        
      );
}
