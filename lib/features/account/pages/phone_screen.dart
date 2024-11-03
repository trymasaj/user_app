import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/phone_number_text_field.dart';
import 'package:masaj/features/account/bloc/phone_bloc/phone_bloc.dart';
import 'package:masaj/features/account/models/phone_model.dart';
import 'package:masaj/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:masaj/features/auth/presentation/pages/otp_verification_page.dart';

// ignore_for_file: must_be_immutable
class PhoneScreen extends StatefulWidget {
  static const routeName = '/phone';

  PhoneScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<PhoneBloc>(create: (context) => PhoneBloc(PhoneState(phoneModelObj: const PhoneModel())), child: PhoneScreen());
  }

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _phoneNumberController;

  late final FocusNode _phoneFocusNode;

  PhoneNumber? _phoneNumber;
  @override
  void initState() {
    _phoneFocusNode = FocusNode();
    _phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: Form(
                key: _formKey,
                child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.all(23.w),
                    child: Column(children: [
                      BlocBuilder<PhoneBloc, PhoneState>(builder: (context, state) {
                        return PhoneTextFormField(
                          currentController: _phoneNumberController,
                          currentFocusNode: _phoneFocusNode,
                          initialValue: _phoneNumber,
                          onInputChanged: (value) => _phoneNumber = value,
                          nextFocusNode: null,
                        );
                      }),
                      SizedBox(height: 32.h),
                      DefaultButton(
                          label: AppText.lbl_save,
                          isExpanded: true,
                          onPressed: () async {
                            await onTapSave(context);
                          }),
                      SizedBox(height: 5.h)
                    ]))));
      },
      listener: (BuildContext context, AuthState state) {
        if (state.isChangePhone) {
          // showSnackBar(context, message: 'lbl_success);
          NavigatorHelper.of(context).push(MaterialPageRoute(builder: (context) => const OTPVerificationPage()));
        }
        if (state.isAccountError) showSnackBar(context, message: state.errorMessage);
      },
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: AppText.lbl_phone_number,
      centerTitle: true,
    );
  }

  /// Navigates to the verificationCodeForEditPhoneScreen when the action is triggered.
  Future<void> onTapSave(BuildContext context) async {
    if (_phoneNumber == null || !(_formKey.currentState?.validate()??false)) {
      showSnackBar(context, message: AppText.err_msg_please_enter_valid_phone_number);
      return;
    }
      //
      final cubit = context.read<AuthCubit>();
      await cubit.changePhone(
        phone: _phoneNumber?.number,
        countryCode: _phoneNumber?.countryCode,
      );

  }
}
