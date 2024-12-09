import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/data/typedefs/type_defs.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';

class DefaultButton extends StatefulWidget {
  const DefaultButton(
      {super.key,
      this.label,
      required this.onPressed,
      this.padding = const EdgeInsets.all(16.0),
      this.margin = const EdgeInsets.only(),
      this.labelStyle = const TextStyle(
        fontSize: 16.0,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      this.alignment = Alignment.center,
      this.borderRadius = const BorderRadius.all(Radius.circular(50.0)),
      this.borderColor,
      this.shadow,
      this.isExpanded = false,
      this.keepButtonSizeOnLoading = false,
      this.icon,
      this.iconLocation = DefaultButtonIconLocation.Start,
      this.borderWidth = 1.0,
      this.enabled = true,
      this.contentAlignment = MainAxisAlignment.center,
      this.backgroundColor = Colors.transparent,
      this.backgroundLoadingColor,
      this.initLoadingState = false,
      this.color,
      this.loadingSize,
      this.height,
      this.width,
      this.textColor});

  final FutureCallback? onPressed;
  final String? label;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final TextStyle labelStyle;
  final Color? borderColor;
  final AlignmentGeometry alignment;
  final BorderRadius borderRadius;
  final bool isExpanded;
  final double? height;
  final double? width;
  final bool keepButtonSizeOnLoading;
  final Widget? icon;
  final DefaultButtonIconLocation iconLocation;
  final double borderWidth;
  final bool enabled;
  final Color? backgroundColor;
  final Color? backgroundLoadingColor;
  final List<BoxShadow>? shadow;
  final MainAxisAlignment contentAlignment;
  final bool initLoadingState;
  final double? loadingSize;
  final Color? color;
  final Color? textColor;

  @override
  _DefaultButtonState createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton>
    with TickerProviderStateMixin {
  bool _isBusy = false;

  @override
  void initState() {
    _isBusy = widget.initLoadingState;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final iconOnStart = widget.iconLocation == DefaultButtonIconLocation.Start;
    final buttonContents = <Widget>[
      ...widget.icon != null
          ? [widget.icon!, if (widget.label != null) const SizedBox(width: 8.0)]
          : [],
      if (widget.label != null)
        Padding(
          padding: widget.icon != null
              ? const EdgeInsets.only(top: 3.0)
              : EdgeInsets.zero,
          child: Text(
            widget.label ?? '',
            style: widget.labelStyle.copyWith(
              color: widget.textColor,
            ),
          ),
        ),
    ];
    return Container(
      height: 56,
      margin: widget.margin,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.bounceInOut,
        alignment: widget.alignment,
        child: _isBusy
            ? _buildLoading(widget.keepButtonSizeOnLoading)
            : Material(
                color: widget.backgroundColor,
                child: Ink(
                  decoration: BoxDecoration(
                    gradient:
                        widget.color == null ? AppColors.GRADIENT_COLOR : null,
                    color: widget.color,
                    boxShadow: widget.shadow,
                    borderRadius: widget.borderRadius,
                    border: widget.borderColor != null
                        ? Border.all(
                            color: widget.borderColor!,
                            width: widget.borderWidth,
                          )
                        : null,
                  ),
                  child: InkWell(
                    onTap: widget.enabled && widget.onPressed != null
                        ? () {
                            FocusScope.of(context).unfocus();
                            final futureOr = widget.onPressed!();
                            if (futureOr is Future) {
                              _setButtonToBusy();
                              futureOr.whenComplete(_setButtonToReady);
                            }
                          }
                        : null,
                    highlightColor: AppColors.PRIMARY_COLOR,
                    borderRadius: widget.borderRadius,
                    child: Container(
                      padding: widget.padding,
                      alignment: widget.isExpanded ? Alignment.center : null,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: widget.contentAlignment,
                        children: iconOnStart
                            ? buttonContents
                            : buttonContents.reversed.toList(),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildLoading(bool keepButtonSizeOnLoading) {
    final loadingSizeFromTextSize = (widget.labelStyle.fontSize ?? 16.0) * 1.4;
    final loadingSize = widget.loadingSize ?? loadingSizeFromTextSize;
    final padding = widget.padding.vertical / 2;
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.all(padding),
        width: keepButtonSizeOnLoading ? null : (loadingSize + padding * 2),
        height: (loadingSize + padding * 2),
        alignment: keepButtonSizeOnLoading ? Alignment.center : null,
        decoration: BoxDecoration(
          shape: keepButtonSizeOnLoading ? BoxShape.rectangle : BoxShape.circle,
          borderRadius: keepButtonSizeOnLoading ? widget.borderRadius : null,
          color: widget.backgroundLoadingColor ?? AppColors.PRIMARY_COLOR,
          border: widget.borderColor != null
              ? Border.all(
                  color: widget.borderColor!, width: widget.borderWidth)
              : null,
        ),
        child: FittedBox(
          fit: BoxFit.contain,
          child: CircularProgressIndicator(
            color: widget.labelStyle.color,
          ),
        ),
      ),
    );
  }

  void _setButtonToReady() {
    _isBusy = false;
    if (mounted) setState(() {});
  }

  void _setButtonToBusy() {
    _isBusy = true;
    if (mounted) setState(() {});
  }
}

enum DefaultButtonIconLocation {
  Start,
  End,
}
