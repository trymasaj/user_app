import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../res/style/app_colors.dart';

class HtmlContentWidget extends StatelessWidget {
  const HtmlContentWidget({
    Key? key,
    required String text,
    int? maxLines,
    double fontSize = 14.0,
    Color color = AppColors.GREY_DARK_COLOR,
    EdgeInsets? margin,
    Display? display = Display.inline,
  })  : _text = text,
        _maxLines = maxLines,
        _fontSize = fontSize,
        _color = color,
        _margin = margin,
        _display = display,
        super(key: key);

  final String _text;
  final int? _maxLines;
  final double _fontSize;
  final Color _color;
  final EdgeInsets? _margin;
  final Display? _display;

  @override
  Widget build(BuildContext context) {
    Widget child = Html(
      data: _text,
      style: {
        "body": Style(
          color: _color,
          fontSize: FontSize(_fontSize),
          maxLines: _maxLines,
          padding: EdgeInsets.zero,
          margin: Margins.zero,
          // display: Display.inline,
        ),
        "p": Style(
          padding: EdgeInsets.zero,
          margin: Margins.zero,
          display: _display,
        ),
      },
    );

    if (_margin != null) child = Padding(padding: _margin!, child: child);

    return child;
  }
}
