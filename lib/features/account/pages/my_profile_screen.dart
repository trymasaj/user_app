import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/extensions/extensions.dart';
import 'package:masaj/core/domain/enums/gender.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateful/default_tab.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_outlined_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/default_text_form_field.dart';
import 'package:masaj/features/account/bloc/my_profile_bloc/my_profile_bloc.dart';
import 'package:masaj/features/account/models/my_profile_model.dart';
import 'package:masaj/features/auth/application/auth_cubit/auth_cubit.dart';

class MyProfileScreen extends StatefulWidget {
  static const routeName = '/my_profile';

  MyProfileScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<MyProfileBloc>(
      create: (context) => MyProfileBloc(MyProfileState(
        myProfileModelObj: const MyProfileModel(),
      )),
      child: MyProfileScreen(),
    );
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
  @override
  void initState() {
    super.initState();
    final authCubit = context.read<AuthCubit>();
    final user = authCubit.state.user;
    _selectedGender = user?.gender;
    _nameController = TextEditingController(text: user?.fullName);
    _emailController = TextEditingController(text: user?.email);
    _birthDateController = TextEditingController(
        text: user?.birthDate?.toLocal().toIso8601String());

    _nameNode = FocusNode();
    _emailNode = FocusNode();
    _birthDateNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
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
                  SizedBox(
                    height: 102.h,
                    width: 104.w,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgRectangle4237,
                          height: 96.adaptSize,
                          width: 96.adaptSize,
                          radius: BorderRadius.circular(
                            12.w,
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        CustomIconButton(
                          height: 30.adaptSize,
                          width: 30.adaptSize,
                          padding: EdgeInsets.all(7.w),
                          decoration: IconButtonStyleHelper.outlineBlackTL15,
                          alignment: Alignment.bottomRight,
                          child: CustomImageView(
                            imagePath: ImageConstant.imgSolarCameraOutline,
                          ),
                        ),
                      ],
                    ),
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
            : DateTime.now();
        final pickedDate = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: DateTime.now().subtract(const Duration(days: 43800)),
            lastDate: DateTime.now(),
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

  /// Section Widget
  Widget _buildGenderButton(String title) {
    return Expanded(
      child: CustomOutlinedButton(
        text: title.tr(),
        margin: EdgeInsets.only(right: 4.w),
        buttonStyle: CustomButtonStyles.outlineBlueGray,
        buttonTextStyle: CustomTextStyles.bodyMediumBluegray40001_1,
      ),
    );
  }

  /// Section Widget
  Widget _buildFemaleButton(BuildContext context) {
    return Expanded(
      child: CustomOutlinedButton(
        text: 'lbl_female'.tr(),
        margin: EdgeInsets.only(right: 4.w),
        buttonStyle: CustomButtonStyles.outlineBlueGray,
        buttonTextStyle: CustomTextStyles.bodyMediumBluegray40001_1,
      ),
    );
  }

  /// Section Widget
  Widget _buildFrameRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildGenderButton('lbl_male'),
        _buildGenderButton('lbl_female'),
      ],
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
    return CustomElevatedButton(
      text: 'lbl_save'.tr(),
      buttonStyle: CustomButtonStyles.none,
      decoration:
          CustomButtonStyles.gradientSecondaryContainerToPrimaryDecoration,
    );
  }
}
/*
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 4.h),
        child: OutlineGradientButton(
            elevation: 0,
            padding:
                EdgeInsets.only(left: 1.h, top: 1.v, right: 1.h, bottom: 1.v),
            strokeWidth: 1.h,
            gradient: LinearGradient(
                begin: Alignment(0, 0.5),
                end: Alignment(1, 0.5),
                colors: [
                  theme.colorScheme.secondaryContainer,
                  theme.colorScheme.primary
                ]),
            corners: Corners(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12)),
            child: CustomOutlinedButton(
              text: "lbl_female".tr(),
              buttonStyle: CustomButtonStyles.none,
              decoration: CustomButtonStyles
                  .gradientSecondaryContainerToDeepOrangeDecoration,
              buttonTextStyle: CustomTextStyles.bodyMediumSecondaryContainer,
            )),
      ),
    );

 */
