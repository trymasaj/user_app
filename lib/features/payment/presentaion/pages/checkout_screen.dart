import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_cached_network_image.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/title_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/warning_container.dart';
import 'package:size_helper/size_helper.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});
  static const String routeName = '/checkoutScreen';

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  static const double _kDividerThickness = 6;
  static const double _KSubVerticalSpace = 12;
  static const double _KSectionPadding = 24;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: CustomAppBar(
          title: 'checkout_title'.tr(),
        ),
        body: _buildBody(),
      );
    });
  }

  CustomAppPage _buildBody() {
    return CustomAppPage(
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              _buildServiceSection(),
              const Divider(
                thickness: _kDividerThickness,
                color: AppColors.ExtraLight,
              ),
              _buildDetailsSection(),
              const Divider(
                thickness: _kDividerThickness,
                color: AppColors.ExtraLight,
              ),
              _buildTherapistSection(),
              const Divider(
                thickness: _kDividerThickness,
                color: AppColors.ExtraLight,
              ),
              _buildLocationSection(),
              const Divider(
                thickness: _kDividerThickness,
                color: AppColors.ExtraLight,
              ),
              const TitleText(text: 'payment_method'),
              Row(
                children: [
                  const SubtitleText(text: 'use_wallet ${200} dummy'),
                  const Spacer(),
                  CustomSwitch(onChange: (value) {}),
                ],
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.PRIMARY_COLOR.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.PRIMARY_COLOR,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(children: [
                          const SubtitleText(text: 'payment'),
                          const Spacer(),
                          Radio.adaptive(
                              value: (value) {},
                              groupValue: false,
                              onChanged: (value) {})
                        ]),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceSection() {
    return Padding(
      padding: const EdgeInsets.all(_KSectionPadding),
      child: Column(
        children: [
          _buildServiceTitle(),
          const SizedBox(height: _KSubVerticalSpace),
          const WarningContainer(title: 'checkout_warning'),
        ],
      ),
    );
  }

  Row _buildServiceTitle() {
    return Row(
      children: [
        CustomCachedNetworkImage(
          imageUrl: '',
          height: 70.0,
          width: 70.0,
          fit: BoxFit.cover,
          borderRadius: BorderRadius.circular(12.0),
        ),
        const SizedBox(width: _KSubVerticalSpace),
        const Column(
          children: [
            SubtitleText(text: ''),
            SizedBox(height: 20.0),
            SubtitleText(text: ''),
          ],
        )
      ],
    );
  }

  Widget _buildDetailsSection() {
    return Padding(
      padding: const EdgeInsets.all(_KSectionPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleText(text: 'details'),
          const SizedBox(height: _KSubVerticalSpace),
          _buildDetailsRow(title: 'date', content: 'date_dummy'),
          _buildDetailsRow(title: 'date', content: 'date_dummy'),
          _buildDetailsRow(title: 'date', content: 'date_dummy'),
          _buildDetailsRow(title: 'date', content: 'date_dummy'),
        ],
      ),
    );
  }

  Widget _buildDetailsRow({required String title, required String content}) {
    return Row(
      children: [
        SubtitleText(text: title),
        const SizedBox(width: 24.0),
        SubtitleText(text: content)
      ],
    );
  }

  Widget _buildTherapistSection() {
    return Padding(
      padding: const EdgeInsets.all(_KSectionPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleText(
            text: 'therapist',
            color: AppColors.ACCENT_COLOR,
          ),
          const SizedBox(height: _KSubVerticalSpace),
          Row(
            children: [
              CustomCachedNetworkImage(
                imageUrl: '',
                height: 50.0,
                width: 50.0,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(8.0),
              ),
              const SizedBox(width: 12.0),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubtitleText(text: 'test dummy'),
                  SizedBox(height: 20.0),
                  SubtitleText(text: 'dummy test dummy'),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection() {
    return const Padding(
      padding: EdgeInsets.all(_KSectionPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText(text: 'location'),
          SizedBox(height: _KSubVerticalSpace),
          TitleText(
            text: 'home_dummy',
            subtractedSize: 2,
          ),
          SizedBox(height: 4),
          SubtitleText(text: 'title'),
        ],
      ),
    );
  }
}
