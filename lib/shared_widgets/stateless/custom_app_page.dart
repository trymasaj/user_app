import 'package:flutter_svg/svg.dart';
import 'custom_cached_network_image.dart';

import '../../res/style/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppPage extends StatelessWidget {
  ///If `backgroundPath` empty then the default option is `lib/res/assets/background.png`
  const CustomAppPage({
    Key? key,
    bool withBackground = false,
    Widget? child,
    bool clearSnackBarOnLaunch = false,
    bool safeTop = false,
    bool safeBottom = true,
    bool safeLeft = false,
    bool safeRight = false,
    List<Widget>? stackChildren,
    String? backgroundPath,
    BoxFit? backgroundFit,
    AlignmentGeometry? backgroundAlignment,
    Color? backgroundColor,
    double? height,
    double? width,
  })  : _withBackground = withBackground,
        _child = child,
        _clearSnackBarOnLaunch = clearSnackBarOnLaunch,
        _safeTop = safeTop,
        _safeBottom = safeBottom,
        _safeLeft = safeLeft,
        _safeRight = safeRight,
        _stackChildren = stackChildren,
        _backgroundPath = backgroundPath,
        _backgroundFit = backgroundFit,
        _backgroundAlignment = backgroundAlignment,
        _backgroundColor = backgroundColor,
        _height = height,
        _width = width,
        super(key: key);
  final bool _withBackground;
  final Widget? _child;
  final bool _clearSnackBarOnLaunch;
  final bool _safeTop;
  final bool _safeBottom;
  final bool _safeLeft;
  final bool _safeRight;
  final List<Widget>? _stackChildren;
  final String? _backgroundPath;
  final BoxFit? _backgroundFit;
  final AlignmentGeometry? _backgroundAlignment;
  final Color? _backgroundColor;
  final double? _height;
  final double? _width;

  bool get _backgroundIsNetworkImage =>
      _backgroundPath?.startsWith('http') == true;

  @override
  Widget build(BuildContext context) {
    if (_clearSnackBarOnLaunch) _clearAnySnackBarFromPreviousPage(context);

    return DecoratedBox(
      decoration: BoxDecoration(color: _backgroundColor ?? Colors.white),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (_withBackground)
            _backgroundIsNetworkImage
                ? CustomCachedNetworkImage(
                    imageUrl: _backgroundPath!,
                    fit: _backgroundFit ?? BoxFit.cover,
                    height: _height,
                    width: _width,
                  )
                : SvgPicture.asset(
                    _backgroundPath?.isNotEmpty == true
                        ? _backgroundPath!
                        : 'lib/res/assets/background.svg',
                    fit: _backgroundFit ?? BoxFit.cover,
                    alignment: _backgroundAlignment ?? Alignment.center,
                  ),
          if (_child != null)
            SafeArea(
              top: _safeTop,
              left: _safeLeft,
              right: _safeRight,
              bottom: _safeBottom,
              child: _child!,
            ),
          ...?_stackChildren,
        ],
      ),
    );
  }

  void _clearAnySnackBarFromPreviousPage(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
  }
}
