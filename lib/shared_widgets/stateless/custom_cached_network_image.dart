import 'package:cached_network_image/cached_network_image.dart';
import '../../res/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'image_not_exist_place_holder.dart';

enum ImageMode {
  Crop,
  Pad,
  Stretch,
  Carve,
  Max,
  ByWidth,
  ByHeight;

  @override
  String toString() => name;
}

enum ScaleMode {
  Down,
  Both,
  Canvas;

  @override
  String toString() => name;
}

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    super.key,
    required String? imageUrl,
    BoxFit? fit,
    bool useOldImageOnUrlChange = false,
    BorderRadius borderRadius = BorderRadius.zero,
    Widget Function(BuildContext context, String url)? placeholder,
    Widget Function(BuildContext? context, String? url, dynamic error)?
        errorWidgetCallBack,
    Widget? errorWidget,
    double? width,
    double? height,
    num? urlWidth,
    num? urlHeight,
    ImageMode? imageMode = ImageMode.Crop,
    ScaleMode? scaleMode = ScaleMode.Both,
    double? saturation,
  })  : _imageUrl = imageUrl,
        _fit = fit,
        _useOldImageOnUrlChange = useOldImageOnUrlChange,
        _borderRadius = borderRadius,
        _placeholder = placeholder,
        _errorWidgetCallBack = errorWidgetCallBack,
        _errorWidget = errorWidget,
        _width = width,
        _height = height,
        _urlWidth = urlWidth,
        _urlHeight = urlHeight,
        _imageMode = imageMode,
        _scaleMode = scaleMode,
        _saturation = saturation;

  final String? _imageUrl;
  final BoxFit? _fit;
  final bool _useOldImageOnUrlChange;
  final BorderRadius _borderRadius;
  final Widget Function(BuildContext context, String url)? _placeholder;
  final Widget Function(BuildContext? context, String? url, dynamic error)?
      _errorWidgetCallBack;
  final Widget? _errorWidget;
  final double? _width;
  final double? _height;
  final num? _urlWidth;
  final num? _urlHeight;
  final ImageMode? _imageMode;
  final ScaleMode? _scaleMode;
  final double? _saturation;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: _borderRadius,
      child: _imageUrl?.isNotEmpty == true
          ? CachedNetworkImage(
              imageUrl: _createImageUrl(_imageUrl!),
              fadeInDuration: const Duration(milliseconds: 300),
              fit: _fit,
              width: _width,
              height: _height,
              useOldImageOnUrlChange: _useOldImageOnUrlChange,
              placeholder: _placeholder,
              errorWidget: (_errorWidget == null
                      ? null
                      : (_, __, ___) => _errorWidget!) ??
                  _errorWidgetCallBack ??
                  _buildDefaultErrorWidgetClosure(),
            )
          : _errorWidget ??
              ImageNotExistPlaceHolder(width: _width, height: _height),
    );
  }

  Widget Function(BuildContext, String) _buildDefaultPlaceholderClosure() {
    return (_, __) => Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(12.0),
          child: CircularProgressIndicator(
            strokeWidth: 3.0,
            valueColor: AlwaysStoppedAnimation(AppColors.PRIMARY_COLOR),
          ),
        );
  }

  Widget Function(BuildContext, String, dynamic)
      _buildDefaultErrorWidgetClosure() {
    return (_, __, ___) =>
        ImageNotExistPlaceHolder(width: _width, height: _height);
  }

  String _createImageUrl(String imageUrl) {
    final queries = <String>[
      if (_urlWidth != null) 'w=${_urlWidth!.toInt()}',
      if (_urlHeight != null) 'h=${_urlHeight!.toInt()}',
      if (_scaleMode != null) 'scale=$_scaleMode',
      if (_imageMode != null) 'mode=$_imageMode',
      if (_saturation != null) 's.saturation=$_saturation',
    ];
    return queries.isEmpty ? imageUrl : '$imageUrl?${queries.join('&')}';
  }
}

class CustomCachedNetworkImageProvider extends CachedNetworkImageProvider {
  CustomCachedNetworkImageProvider(
    String url, {
    int? urlWidth,
    int? urlHeight,
    ImageMode? imageMode = ImageMode.Crop,
    ScaleMode? scaleMode = ScaleMode.Both,
    double? saturation,
    super.cacheKey,
    super.cacheManager,
    super.errorListener,
    super.headers,
    super.imageRenderMethodForWeb,
    super.maxHeight,
    super.maxWidth,
    super.scale,
  }) : super(_createImageUrl(
          url,
          urlWidth,
          urlHeight,
          imageMode,
          scaleMode,
          saturation,
        ));

  static String _createImageUrl(String imageUrl, int? urlWidth, int? urlHeight,
      ImageMode? imageMode, ScaleMode? scaleMode, double? saturation) {
    final queries = <String>[
      if (urlWidth != null) 'w=$urlWidth',
      if (urlHeight != null) 'h=$urlHeight',
      if (scaleMode != null) 'scale=$scaleMode',
      if (imageMode != null) 'mode=$imageMode',
      if (saturation != null) 's.saturation=$saturation',
    ];
    return queries.isEmpty ? imageUrl : '$imageUrl?${queries.join('&')}';
  }
}
