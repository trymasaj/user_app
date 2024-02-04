import 'package:flutter/material.dart';

class GradientRectSliderTrackShape extends SliderTrackShape
    with BaseSliderTrackShape {
  /// Creates a slider track that draws 2 rectangles.
  const GradientRectSliderTrackShape(
      {this.gradient =
          const LinearGradient(colors: [Colors.lightBlue, Colors.blue])});

  final LinearGradient gradient;

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
  }) {
    assert(sliderTheme.disabledActiveTrackColor != null);
    assert(sliderTheme.disabledInactiveTrackColor != null);
    assert(sliderTheme.activeTrackColor != null);
    assert(sliderTheme.inactiveTrackColor != null);
    assert(sliderTheme.thumbShape != null);

    // If the slider [SliderThemeData.trackHeight] is less than or equal to 0,
    // then it makes no difference whether the track is painted or not,
    // therefore the painting can be a no-op.
    if (sliderTheme.trackHeight! <= 0) {
      return;
    }

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    // Assign the track segment paints, which are left: active, right: inactive,
    // but reversed for right to left text.
    final ColorTween activeTrackColorTween = ColorTween(
        begin: sliderTheme.disabledActiveTrackColor,
        end: sliderTheme.activeTrackColor);

    final ColorTween inactiveTrackColorTween = ColorTween(
        begin: sliderTheme.disabledInactiveTrackColor,
        end: sliderTheme.inactiveTrackColor);

    final Paint activePaint = Paint()
      ..shader = gradient.createShader(trackRect)
      ..color = activeTrackColorTween.evaluate(enableAnimation)!;

    final Paint inactivePaint = Paint()
      ..color = inactiveTrackColorTween.evaluate(enableAnimation)!;

    final Paint leftTrackPaint;
    final Paint rightTrackPaint;

    switch (textDirection) {
      case TextDirection.ltr:
        leftTrackPaint = activePaint;
        rightTrackPaint = inactivePaint;
        break;
      case TextDirection.rtl:
        leftTrackPaint = inactivePaint;
        rightTrackPaint = activePaint;
        break;
    }

    final Rect leftTrackSegment = Rect.fromLTRB(
        trackRect.left, trackRect.top, thumbCenter.dx, trackRect.bottom);
    if (!leftTrackSegment.isEmpty) {
      context.canvas.drawRect(leftTrackSegment, leftTrackPaint);
    }
    final Rect rightTrackSegment = Rect.fromLTRB(
        thumbCenter.dx, trackRect.top, trackRect.right, trackRect.bottom);
    if (!rightTrackSegment.isEmpty) {
      context.canvas.drawRect(rightTrackSegment, rightTrackPaint);
    }
  }
}

class GradientRoundSliderThumbShape extends SliderComponentShape {
  final LinearGradient gradient;
  final double enabledThumbRadius;

  GradientRoundSliderThumbShape({
    required this.gradient,
    required this.enabledThumbRadius,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(enabledThumbRadius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final Paint paint = Paint()
      ..shader = gradient.createShader(
          Rect.fromCircle(center: center, radius: enabledThumbRadius));

    context.canvas.drawCircle(center, enabledThumbRadius, paint);
  }

  // @override
  // void paint(
  //   PaintingContext context,
  //   Offset center, {
  //   //     context,
  //   // _startThumbCenter,
  //   // activationAnimation: _overlayAnimation,
  //   // enableAnimation: _enableAnimation,
  //   // isDiscrete: isDiscrete,
  //   // labelPainter: _startLabelPainter,
  //   // parentBox: this,
  //   // sliderTheme: _sliderTheme,
  //   // textDirection: _textDirection,
  //   // value: startValue,
  //   // textScaleFactor: _textScaleFactor,
  //   // sizeWithOverflow: resolvedscreenSize,
  //   required Animation<double> activationAnimation,
  //   required Animation<double> enableAnimation,
  //   required bool isDiscrete,
  //   required TextPainter labelPainter,
  //   required RenderBox parentBox,
  //   required SliderThemeData sliderTheme,
  //   required TextDirection textDirection,
  //   required double value,
  //   required double textScaleFactor,
  //   required Size sizeWithOverflow,
  // }) {
  //   final Paint paint = Paint()
  //     ..shader = gradient.createShader(
  //         Rect.fromCircle(center: center, radius: enabledThumbRadius));

  //   context.canvas.drawCircle(center, enabledThumbRadius, paint);
  // }
}
