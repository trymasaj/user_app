import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masaj/features/account/presentation/blocs/coupon_details_cubit/coupon_details_cubit.dart';
import 'package:masaj/shared_widgets/stateful/default_button.dart';
import 'package:masaj/shared_widgets/stateless/custom_cached_network_image.dart';
import 'package:masaj/shared_widgets/stateless/custom_loading.dart';
import 'package:masaj/shared_widgets/stateless/subtitle_text.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';

import '../../../../core/utils/navigator_helper.dart';
import '../../../../di/injector.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';
import 'package:flutter/material.dart';

import '../../../../shared_widgets/stateless/title_text.dart';

class CouponDetailsPage extends StatefulWidget {
  static const routeName = '/CouponDetailsPage';
  const CouponDetailsPage({
    required this.id,
    required this.label,
    Key? key,
  }) : super(key: key);

  final int id;
  final String label;

  @override
  State<CouponDetailsPage> createState() => _CouponDetailsPageState();
}

class _CouponDetailsPageState extends State<CouponDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          Injector().couponDetailsCubit..loadCouponDetails(widget.id),
      child: BlocListener<CouponDetailsCubit, CouponDetailsState>(
        listener: (context, state) async {
          if (state.isError)
            showSnackBar(context, message: state.errorMessage.toString());
        },
        child: CustomAppPage(
          safeTop: true,
          safeBottom: false,
          child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildAppBar(context),
                Expanded(child: _buildBody(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: TitleText(text: widget.label),
      leading: IconButton(
        icon: const Icon(
          Icons.chevron_left,
          size: 40.0,
        ),
        onPressed: NavigatorHelper.of(context).pop,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<CouponDetailsCubit, CouponDetailsState>(
      builder: (context, state) {
        if (state.isInitial || state.isLoading) return const CustomLoading();
        var couponDetails = state.couponDetails;
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            const SizedBox(height: 32.0),
            _buildImage(couponDetails?.picture),
            const SizedBox(height: 16.0),
            ..._buildDetails(couponDetails?.description ?? ''),
            const SizedBox(height: 16.0),
            _buildScratchWidget(context)
          ],
        );
      },
    );
  }

  List<Widget> _buildDetails(String details) {
    return [
      const TitleText(text: 'coupon_details'),
      const SizedBox(height: 16.0),
      SubtitleText(text: details),
    ];
  }

  Widget _buildImage(String? picture) {
    return CustomCachedNetworkImage(
      imageUrl: picture,
      borderRadius: const BorderRadius.all(Radius.circular(20.0)),
    );
  }

  Widget _buildScratchWidget(BuildContext context) {
    final couponDetailsCubit = context.read<CouponDetailsCubit>();
    return _ScratchWidget(
      onShowCode: () async {
        await couponDetailsCubit.showCouponCode(widget.id);
        return couponDetailsCubit.state.couponCode;
      },
    );
  }
}

class _ScratchWidget extends StatefulWidget {
  const _ScratchWidget({required this.onShowCode, super.key});

  final Function onShowCode;

  @override
  State<_ScratchWidget> createState() => __ScratchWidgetState();
}

class __ScratchWidgetState extends State<_ScratchWidget> {
  late TextEditingController codeController;

  @override
  void initState() {
    codeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const TitleText(
          text: 'copy_coupon_code',
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 16.0),
        Row(
          children: [const SizedBox(width: 24.0), _buildCopyButton()],
        )
      ],
    );
  }

  DefaultButton _buildCopyButton() {
    return DefaultButton(
        label: 'copy'.tr(),
        icon: const Icon(Icons.copy),
        backgroundColor: Colors.transparent,
        onPressed: () =>
            Clipboard.setData(ClipboardData(text: codeController.text)));
  }
}
