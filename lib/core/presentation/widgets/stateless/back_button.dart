import 'package:flutter/material.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    this.color = Colors.white,
    this.onPress,
    this.label,
  });

  final Color color;
  final VoidCallback? onPress;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Navigator.of(context).canPop()
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(children: [
              InkWell(
                onTap: onPress ?? NavigatorHelper.of(context).pop,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: 28.0,
                    color: color,
                  ),
                ),
              ),
              if (label != null)
                Expanded(
                  child: Text(
                    label!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 18.0),
                    textAlign: TextAlign.center,
                  ),
                )
            ]),
          )
        : const SizedBox();
  }
}
