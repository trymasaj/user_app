import 'package:flutter/material.dart';
import 'package:masaj/core/data/device/system_service.dart';
import 'package:masaj/core/data/di/di_wrapper.dart';
import 'package:pay/pay.dart';

class ApplePayCustomButton extends StatelessWidget {
  const ApplePayCustomButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return DI.find<SystemService>().currentOS == OS.iOS
        ? SizedBox(
            height: 60.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: RawApplePayButton(
                cornerRadius: 10,
                onPressed: onPressed,
                style: ApplePayButtonStyle.black,
              ),
            ),
          )
        : Container();
  }
}
