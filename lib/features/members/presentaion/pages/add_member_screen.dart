import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/widgets/stateful/default_tab.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';

import 'package:masaj/core/presentation/widgets/stateful/user_profile_image_picker.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/default_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/phone_number_text_field.dart';

class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({super.key});
  static const String routeName = '/add_member';

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  final TextEditingController memberNameController = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();

  final FocusNode memberNameFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();
  final FocusNode phoneNumberFocusNode = FocusNode();
  bool _isMale = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'lbl_add_member'.tr(),
        centerTitle: true,
      ),
      body: CustomAppPage(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23),
          child: Form(
            key: formKey,
            child: Column(children: [
              SizedBox(height: 24.h),
              UserProfileImagePicker(
                onImageSelected: (imagePath) {},
              ),
              SizedBox(height: 24.h),
              DefaultTextFormField(
                currentFocusNode: memberNameFocusNode,
                currentController: memberNameController,
                hint: 'first_name'.tr(),
              ),
              const SizedBox(height: 16),
              PhoneTextFormField(
                currentFocusNode: phoneNumberFocusNode,
                currentController: phoneNumberController,
                hint: 'phone_number'.tr(),
                nextFocusNode: null,
                onInputChanged: (PhoneNumber value) {},
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      setState(() {
                        _isMale = true;
                      });
                    },
                    child: DefaultTab(
                      isSelected: _isMale,
                      title: 'Male'.tr(),
                    ),
                  )),
                  SizedBox(width: 10.w),
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      setState(() {
                        _isMale = false;
                      });
                    },
                    child:
                        DefaultTab(isSelected: !_isMale, title: 'Female'.tr()),
                  )),
                ],
              ),
              SizedBox(height: 32.h),
              DefaultButton(
                onPressed: () {},
                label: 'save'.tr(),
                padding: EdgeInsets.symmetric(horizontal: 150.w),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
