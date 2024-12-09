import 'package:flutter/material.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.keyboard_backspace_outlined,
            size: 32.0,
          ),
        ),
        onTap: () {
          if (NavigatorHelper.of(context).canPop()) {
            NavigatorHelper.of(context).pop();
          }
        },
      ),
    );
  }
}
