import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:masaj/core/app_text.dart';
import 'package:masaj/core/data/connection/connection_checker.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';

class EmptyPageMessage extends StatelessWidget {
  ///`heightRatio` from `0.0` to `1.0`
  const EmptyPageMessage({
    super.key,
    String? message,
    String? svgImage = 'no_points',
    double heightRatio = 0.8,
    Color? textColor,
    RefreshCallback? onRefresh,
  })  : assert(message != null || svgImage != null,
            'message or svgImage must be not null'),
        _message = message,
        _svgImage = svgImage,
        _heightRatio = heightRatio,
        _textColor = textColor,
        _onRefresh = onRefresh;

  final String? _message;
  final String? _svgImage;

  bool get _isLink => _svgImage?.contains('http') ?? false;

  final double _heightRatio;
  final Color? _textColor;

  final RefreshCallback? _onRefresh;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final emptyMessageWidget =
        _buildEmptyMessageContent(height, message: _message ?? AppText.empty);

    final normalEmptyMessage = _onRefresh == null
        ? emptyMessageWidget
        : RefreshIndicator(
            color: AppColors.ACCENT_COLOR,
            onRefresh: _onRefresh!,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              physics: const AlwaysScrollableScrollPhysics(),
              child: emptyMessageWidget,
            ),
          );
    return StreamBuilder<ConnectionCheckerResult>(
      stream: ConnectionChecker().connectionStream,
      builder: (context, snapshot) {
        final connectionResult = snapshot.data;
        final hasConnection = connectionResult?.newState ?? true;

        return hasConnection
            ? normalEmptyMessage
            : _buildEmptyMessageContent(
                height,
                message: AppText.connection_error,
                showTryAgainButton: true,
              );
      },
    );
  }

  Widget _buildEmptyMessageContent(
    double height, {
    String? message,
    bool showTryAgainButton = false,
  }) {
    const assetsPath = 'assets/images/';

    Widget child = SubtitleText(
      text: message ?? AppText.empty,
      textAlign: TextAlign.center,
      color: _textColor,
    );

    if (_svgImage != null) {
      child = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _isLink
              ? SvgPicture.network(
                  _svgImage!,
                  height: height * (_heightRatio - .40),
                )
              : SvgPicture.asset(
                  '$assetsPath$_svgImage.svg',
                  height: height * (_heightRatio - .40),
                ),
          child,
          if (showTryAgainButton) _buildTryAgainButton(),
        ],
      );
    } else {
      child = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
          if (showTryAgainButton) _buildTryAgainButton(),
        ],
      );
    }

    return Container(
      alignment: Alignment.center,
      height: height * _heightRatio,
      child: child,
    );
  }

  Widget _buildTryAgainButton() {
    if (_onRefresh == null) return const SizedBox();
    return DefaultButton(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      padding: const EdgeInsets.all(8.0),
      backgroundColor: Colors.transparent,
      borderColor: AppColors.PRIMARY_COLOR,
      label: AppText.lbl_try_again,
      labelStyle: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: AppColors.PRIMARY_COLOR,
      ),
      onPressed: _onRefresh,
    );
  }
}
