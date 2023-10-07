import 'package:flutter/material.dart';

import '../../core/utils/type_defs.dart';
import '../../res/style/app_colors.dart';

class ShareButton extends StatefulWidget {
  const ShareButton({
    Key? key,
    required FutureCallback<void> onShareTap,
  })  : _onShareTap = onShareTap,
        super(key: key);

  final FutureCallback<void> _onShareTap;

  @override
  State<ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          alignment: AlignmentDirectional.center,
          width: 40.0,
          height: 40.0,
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            boxShadow: AppColors.SHADOW,
            color: AppColors.PRIMARY_COLOR,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          child: const Icon(Icons.share)),
      onTap: _isLoading
          ? () {}
          : () {
              final futureOf = widget._onShareTap();

              if (futureOf is Future) {
                _startLoading();
                (futureOf as Future).whenComplete(_stopLoading);
              }
            },
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
