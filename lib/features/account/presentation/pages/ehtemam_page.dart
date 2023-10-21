import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/service/launcher_service.dart';
import '../../../../core/utils/navigator_helper.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/stateful/default_button.dart';
import '../../../../shared_widgets/stateless/subtitle_text.dart';
import '../../../../shared_widgets/stateless/title_text.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';
import 'package:flutter/material.dart';

const ehtemamUrl = "https://ehtemam.sa/ar";
const ehtemamPhone = "+9668002444010";

class EhtemamPage extends StatelessWidget {
  static const routeName = '/EhtemamPage';
  const EhtemamPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppPage(
      safeTop: true,
      safeBottom: false,
      backgroundColor: Colors.white,
      child: Scaffold(
        body: Column(
          children: [
            _buildTopSection(context),
            Expanded(child: _buildContent(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        _buildImage(),
        const SizedBox(height: 24.0),
        _buildTitle(),
        const SizedBox(height: 16.0),
        _buildSubTitle(),
        const SizedBox(height: 36.0),
        _buildEhtemamConcernsButton(context),
        _buildCallPhoneButton(context),
      ],
    );
  }

  Widget _buildTopSection(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 48.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/res/assets/app_logo.png',
                height: 80.0,
              ),
            ],
          ),
        ),
        PositionedDirectional(
          start: 16.0,
          top: 32.0,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 32.0,
            ),
            color: Colors.white,
            onPressed: NavigatorHelper.of(context).pop,
          ),
        )
      ],
    );
  }

  Widget _buildEhtemamConcernsButton(BuildContext context) {
    LauncherService launcher = LauncherServiceImpl();
    return DefaultButton(
        isExpanded: true,
        margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        backgroundColor: AppColors.ACCENT_COLOR,
        label: 'concerns'.tr(),
        onPressed: () {
          launcher.openWebsite(ehtemamUrl);
        });
  }

  Widget _buildCallPhoneButton(BuildContext context) {
    LauncherService launcher = LauncherServiceImpl();
    return DefaultButton(
        isExpanded: true,
        margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        backgroundColor: AppColors.ACCENT_COLOR,
        label: ehtemamPhone,
        onPressed: () {
          launcher.callPhone(ehtemamPhone);
        });
  }

  Widget _buildTitle() {
    return const TitleText.extraLarge(
      text: 'ehtemam',
      color: Colors.black,
    );
  }

  Widget _buildSubTitle() {
    return const SubtitleText(
      text: 'ehtemam_subtitle',
      color: AppColors.GREY_NORMAL_COLOR,
    );
  }

  Widget _buildImage() {
    return SvgPicture.asset(
      'lib/res/assets/help.svg',
      height: 160.0,
    );
  }
}
