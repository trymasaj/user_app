import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:masaj/core/data/typedefs/type_defs.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';

class DeleteButton extends StatefulWidget {
  const DeleteButton({
    super.key,
    required FutureCallback<bool> onDeleteTap,
  }) : _onDeleteTap = onDeleteTap;

  final FutureCallback<bool> _onDeleteTap;

  @override
  State<DeleteButton> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _isLoading
          ? () {}
          : () {
              final futureOf = widget._onDeleteTap();

              if (futureOf is Future) {
                _startLoading();
                (futureOf as Future).whenComplete(_stopLoading);
              }
            },
      child: Container(
          width: 40.0,
          height: 40.0,
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            boxShadow: AppColors.SHADOW,
            color: AppColors.ACCENT_COLOR,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: SvgPicture.asset(
            'assets/images/trash.svg',
          )),
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
