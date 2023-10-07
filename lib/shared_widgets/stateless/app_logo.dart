import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    Key? key,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    AlignmentGeometry? alignment,
  })  : _width = width,
        _height = height,
        _padding = padding,
        _margin = margin,
        _alignment = alignment,
        super(key: key);

  final double? _width;
  final double? _height;
  final EdgeInsetsGeometry? _padding;
  final EdgeInsetsGeometry? _margin;
  final AlignmentGeometry? _alignment;

  @override
  Widget build(BuildContext context) {
    Widget child = Hero(
      tag: 'APP_LOGO',
      transitionOnUserGestures: true,
      child: Material(
        color: Colors.transparent,
        child: Image.asset(
          'lib/res/assets/app_logo.png',
          height: _height,
          width: _width,
        ),
      ),
    );
    if (_padding != null) child = Padding(padding: _padding!, child: child);
    if (_alignment != null) child = Align(alignment: _alignment!, child: child);
    if (_margin != null) child = Padding(padding: _margin!, child: child);

    return child;
  }
}
