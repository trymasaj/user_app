import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/device/system_service.dart';
import 'package:masaj/core/data/di/di_wrapper.dart';
import 'package:masaj/core/data/extensions/extensions.dart';
import 'package:masaj/core/domain/enums/gender.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateful/default_tab.dart';
import 'package:masaj/core/presentation/widgets/stateful/user_profile_image_picker.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/default_text_form_field.dart';
import 'package:masaj/features/auth/application/auth_cubit/auth_cubit.dart';

import '../../../core/presentation/navigation/navigator_helper.dart';

class MyProfileScreen extends StatefulWidget {
  static const routeName = '/my_profile';

  MyProfileScreen({super.key});

  static Widget builder(BuildContext context) {
    return MyProfileScreen();
  }

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _nameController;
  late final TextEditingController _birthDateController;

  late final FocusNode _emailNode;
  late final FocusNode _nameNode;
  late final FocusNode _birthDateNode;
  Gender? _selectedGender;
  bool showGenderError = false;
  String? _image;

  SystemService system = DI.find();

  @override
  void initState() {
    super.initState();
    final authCubit = context.read<AuthCubit>();
    final user = authCubit.state.user;
    _selectedGender = user?.gender;
    _image = user?.profileImage;
    _nameController = TextEditingController(text: user?.fullName);
    _emailController = TextEditingController(text: user?.email);
    _birthDateController =
        TextEditingController(text: user?.birthDate?.toLocal().formatDate());

    _nameNode = FocusNode();
    _emailNode = FocusNode();
    _birthDateNode = FocusNode();
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
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 23.w,
                vertical: 22.h,
              ),
              child: Column(
                children: [
                  UserProfileImagePicker(
                    currentImage: _image,
                    onImageSelected: (imagePath) {
                      _image = imagePath;
                    },
                  ),
                  SizedBox(height: 8.h),
                  DefaultTextFormField(
                    decoration: InputDecoration(
                      labelText: 'lbl_name'.tr(),
                      labelStyle: CustomTextStyles.bodyMediumOnPrimary_2,
                    ),
                    currentFocusNode: _nameNode,
                    nextFocusNode: _emailNode,
                    currentController: _nameController,
                    isRequired: true,
                    hint: '',
                  ),
                  SizedBox(height: 16.h),
                  DefaultTextFormField(
                    decoration: InputDecoration(
                      labelText: 'lbl_email'.tr(),
                      labelStyle: CustomTextStyles.bodyMediumOnPrimary_2,
                    ),
                    currentFocusNode: _emailNode,
                    currentController: _emailController,
                    isRequired: true,
                    hint: '',
                  ),
                  SizedBox(height: 16.h),
                  _buildBirthDate(context),
                  SizedBox(height: 20.h),
                  _buildGenderRow(),
                  SizedBox(height: 32.h),
                  _buildSaveButton(context),
                  SizedBox(height: 5.h),
                ],
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, AuthState state) {
        if (state.isUpdateUser) {
          NavigatorHelper.of(context).pop();
          showSnackBar(context, message: 'account_updated'.tr());
        }
        if (state.isAccountError)
          showSnackBar(context, message: state.errorMessage);
      },
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: 'lbl_my_profile'.tr(),
      centerTitle: true,
    );
  }

  Widget buildImage(String imagePath) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.w, 17.h, 10.w, 19.h),
      child: CustomImageView(
        imagePath: imagePath,
        height: 20.h,
        width: 20.w,
        color: appTheme.blueGray40001,
      ),
    );
  }

  Widget _buildBirthDate(BuildContext context) {
    return DefaultTextFormField(
      isRequired: true,
      readOnly: true,
      currentFocusNode: _birthDateNode,
      currentController: _birthDateController,
      hint: 'lbl_birth_date',
      prefixIcon: buildImage(ImageConstant.imgCalendar),
      suffixIcon: buildImage(ImageConstant.imgCalendar),
      onTap: () async {
        final initialDate = _birthDateController.text.isNotEmpty
            ? _birthDateController.text.parseDate()
            : system.now;
        final pickedDate = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: system.now.subtract(const Duration(days: 43800)),
            lastDate: system.now,
            builder: (context, child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: AppColors.PRIMARY_COLOR,
                  ),
                ),
                child: child!,
              );
            });
        if (pickedDate != null) {
          _birthDateController.text = pickedDate.formatDate();
        }
      },
    );
  }

  Widget _buildGenderRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: InkWell(
              onTap: () {
                setState(() {
                  _selectedGender = Gender.male;
                  showGenderError = false;
                });
              },
              child: DefaultTab(
                isSelected: _selectedGender == Gender.male,
                title: 'Male'.tr(),
              ),
            )),
            SizedBox(width: 10.w),
            Expanded(
                child: InkWell(
              onTap: () {
                setState(() {
                  _selectedGender = Gender.female;
                  showGenderError = false;
                });
              },
              child: DefaultTab(
                  isSelected: _selectedGender == Gender.female,
                  title: 'Female'.tr()),
            )),
            SizedBox(width: 10.w),
            Expanded(
                child: InkWell(
              onTap: () {
                setState(() {
                  _selectedGender = Gender.other;
                  showGenderError = false;
                });
              },
              child: DefaultTab(
                  isSelected: _selectedGender == Gender.other,
                  title: 'other'.tr()),
            )),
          ],
        ),
        const SizedBox(height: 10),
        if (showGenderError)
          const SubtitleText.small(
            text: 'empty_field_not_valid',
            color: AppColors.ERROR_COLOR,
          )
      ],
    );
  }

  /// Section Widget
  Widget _buildSaveButton(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return DefaultButton(
      label: 'lbl_save'.tr(),
      onPressed: () async {
        if (_isValid()) {
          final newUser = cubit.state.user?.copyWith(
              birthDate: _birthDateController.text.parseDate(),
              email: _emailController.text,
              fullName: _nameController.text,
              gender: _selectedGender,
              profileImage: _image);
          await cubit.editAccountData(newUser);
        }
      },
      isExpanded: true,
    );
  }

  bool _isValid() {
    if (!_formKey.currentState!.validate()) {
      return false;
    }
    if (_selectedGender == null) {
      showSnackBar(context, message: 'msg_choose_your_gender'.tr());
      return false;
    }
    return true;
  }
}
