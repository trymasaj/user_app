import 'package:flutter/material.dart';

import 'package:masaj/core/data/typedefs/type_defs.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';

class ShareButton extends StatefulWidget {
  const ShareButton({
    super.key,
    required FutureCallback<void> onShareTap,
  }) : _onShareTap = onShareTap;

  final FutureCallback<void> _onShareTap;

  @override
  State<ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _isLoading
          ? () {}
          : () {
              final futureOf = widget._onShareTap();

              if (futureOf is Future) {
                _startLoading();
                (futureOf).whenComplete(_stopLoading);
              }
            },
      child: Container(
          alignment: AlignmentDirectional.center,
          width: 40.0,
          height: 40.0,
          margin: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            boxShadow: AppColors.SHADOW,
            color: AppColors.PRIMARY_COLOR,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: const Icon(Icons.share)),
    );
  }

  void _startLoading() {
    _isLoading = true;
    if (mounted) setState(() {});
  }

  void _stopLoading() {
    _isLoading = false;
    if (mounted) setState(() {});
  }
}
