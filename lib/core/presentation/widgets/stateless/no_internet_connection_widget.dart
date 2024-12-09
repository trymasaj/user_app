import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:masaj/core/app_text.dart';
import 'package:masaj/core/data/typedefs/type_defs.dart';
import 'package:masaj/core/presentation/widgets/stateless/back_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';

class NoInternetConnectionWidget extends StatelessWidget {
  const NoInternetConnectionWidget({
    super.key,
    double? height,
    EdgeInsets padding = EdgeInsets.zero,
    bool withBackButton = false,
    FutureCallback? onRefreshPage,
  })  : _height = height,
        _padding = padding,
        _withBackButton = withBackButton,
        _onRefreshPage = onRefreshPage;

  final double? _height;
  final EdgeInsets _padding;
  final bool _withBackButton;
  final FutureCallback? _onRefreshPage;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: _height ?? screenHeight * 0.7,
      padding: _padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_withBackButton) const CustomBackButton(),
          const Spacer(),
          SvgPicture.asset('assets/images/no_internet_connection_icon.svg'),
          const SizedBox(height: 16.0),
          Text(
            AppText.sorry_no_result_found,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const Spacer(),
          _buildRefreshButton(context),
        ],
      ),
    );
  }

  Widget _buildRefreshButton(BuildContext context) {
    return DefaultButton(
      label: AppText.refresh_page,
      isExpanded: true,
      padding: const EdgeInsets.all(12.0),
      onPressed: _onRefreshPage,
    );
  }
}
