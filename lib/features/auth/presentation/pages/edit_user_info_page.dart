import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/domain/enums/age_group.dart';
import 'package:masaj/core/domain/enums/gender.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateful/custom_drop_down_menu.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/email_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/first_name_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/title_text.dart';
import 'package:masaj/features/auth/domain/entities/user.dart';
import 'package:masaj/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:masaj/features/auth/presentation/widgets/user_image_selection_widget.dart';

class EditUserInfoPage extends StatefulWidget {
  static const routeName = '/EditUserInfoPage';

  const EditUserInfoPage({super.key});

  @override
  State<EditUserInfoPage> createState() => _EditUserInfoPageState();
}

class _EditUserInfoPageState extends State<EditUserInfoPage> {
  late final GlobalKey<FormState> _formKey;

  late final TextEditingController _fullNameTextController;
  late final TextEditingController _emailTextController;

  late final FocusNode _fullNameFocusNode;
  late final FocusNode _emailFocusNode;

  Gender? _userGender;
  AgeGroup? _userAgeGroup;

  bool _isAutoValidating = false;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();

    _createTextControllers();
    setState(() {});

    super.initState();
  }

  @override
  void dispose() {
    _disposeControllers();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(listener: (context, state) {
      if (state.isError) showSnackBar(context, message: state.errorMessage);
    }, child: Builder(builder: (context) {
      return CustomAppPage(
        child: Scaffold(
          body: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: const TitleText(text: 'edit_profile'),
                leading: IconButton(
                  icon: const Icon(
                    Icons.chevron_left,
                    size: 40.0,
                  ),
                  onPressed: () {
                    NavigatorHelper.of(context).pop();
                  },
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildUserImageSelection(),
                      _buildForm(),
                    ],
                  ),
                ),
              ),
              _buildSaveChangesButton(context),
            ],
          ),
        ),
      );
    }));
  }

  Widget _buildUserImageSelection() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state.isInitial || state.isLoading) return const SizedBox();

        return UserImageSelection(
          key: ValueKey(state.selectedGender?.id.toString()),
          isMale: (state.selectedGender ?? state.user?.gender) == Gender.male,
        );
      },
    );
  }

  Widget _buildForm() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state.isInitial || state.isLoading) {
          return const CustomLoading(
            loadingStyle: LoadingStyle.Default,
          );
        }

        final authCubit = context.read<AuthCubit>();

        return Form(
            key: _formKey,
            autovalidateMode: _isAutoValidating
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const TitleText(text: 'full_name'),
                  const SizedBox(height: 8.0),
                  FirstNameTextFormField(
                    currentController: _fullNameTextController,
                    currentFocusNode: _fullNameFocusNode,
                    nextFocusNode: _emailFocusNode,
                  ),
                  const SizedBox(height: 16.0),
                  const TitleText(text: 'your_email'),
                  const SizedBox(height: 8.0),
                  EmailTextFormField(
                    currentController: _emailTextController,
                    currentFocusNode: _emailFocusNode,
                    nextFocusNode: null,
                    prefixIcon:
                        buildImage(ImageConstant.imgCheckmarkBlueGray40001),
                  ),
                  const SizedBox(height: 16.0),
                  const TitleText(text: 'choose_your_gender'),
                  const SizedBox(height: 8.0),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return CustomDropDownMenu<Gender>.adaptive(
                        key: ValueKey(state.selectedGender?.id.toString()),
                        currentItem: state.selectedGender ?? _userGender,
                        items: Gender.values,
                        hint: 'gender',
                        onChanged: (value) {
                          _userGender = value;
                          authCubit.selectGender(value!);
                        },
                        getStringFromItem: (item) => item.name.tr(),
                      );
                    },
                  ),
                  const SizedBox(height: 16.0),
                  const TitleText(text: 'how_old_are_you'),
                  const SizedBox(height: 8.0),
                  CustomDropDownMenu<AgeGroup>.adaptive(
                    currentItem: _userAgeGroup,
                    items: AgeGroup.values,
                    hint: 'age_group',
                    onChanged: (value) => _userAgeGroup = value,
                    getStringFromItem: (item) => item.name.tr(),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ));
      },
    );
  }

  Padding buildImage(String imagePath) {
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

  Widget _buildSaveChangesButton(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return DefaultButton(
      label: AppText.save_changes,
      backgroundColor: AppColors.PRIMARY_COLOR,
      isExpanded: true,
      icon: const Icon(Icons.arrow_forward),
      iconLocation: DefaultButtonIconLocation.End,
      margin: const EdgeInsets.all(16.0),
      onPressed: () async {
        if (_isNotValid()) return;

        final isSuccess = await authCubit.editAccountData(
          User(
            fullName: _fullNameTextController.text.trim(),
            email: _emailTextController.text.trim(),
            gender: authCubit.state.selectedGender ?? _userGender,
            ageGroup: _userAgeGroup,
            mobile: authCubit.state.user?.mobile?.isEmpty == true
                ? null
                : authCubit.state.user?.mobile,
          ),
        );

        if (isSuccess) {
          NavigatorHelper.of(context).pop();
          showSnackBar(context, message: AppText.edit_profile_success);
        } else {
          showSnackBar(context, message: AppText.nothing_changed);
        }
      },
    );
  }

  bool _isNotValid() {
    if (!_formKey.currentState!.validate()) {
      setState(() => _isAutoValidating = true);
      return true;
    }
    return false;
  }

  void _createTextControllers() async {
    final authCubit = context.read<AuthCubit>();
    await authCubit.getUserData(true);
    await authCubit.getInterestData();
    final user = authCubit.state.user;
    _fullNameTextController = TextEditingController(text: user?.fullName);
    _emailTextController = TextEditingController(text: user?.email);

    _userGender = user?.gender;
    _userAgeGroup = user?.ageGroup;

    _fullNameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
  }

  void _disposeControllers() {
    _fullNameTextController.dispose();
    _emailTextController.dispose();

    _fullNameFocusNode.dispose();
    _emailFocusNode.dispose();
  }
}
