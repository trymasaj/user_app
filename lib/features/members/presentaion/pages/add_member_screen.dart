import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/domain/enums/gender.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateful/default_tab.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateful/user_profile_image_picker.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/default_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/phone_number_text_field.dart';
import 'package:masaj/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:masaj/features/members/data/model/member_model.dart';
import 'package:masaj/features/members/presentaion/bloc/members_cubit.dart';

class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({super.key, int? id}) : _id = id;
  static const String routeName = '/add_member';
  final int? _id;

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  final TextEditingController memberNameController = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();

  final FocusNode memberNameFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();
  final FocusNode phoneNumberFocusNode = FocusNode();
  Gender? _selectedGender;
  bool showGenderError = false;
  PhoneNumber? _selectedPhoneNumber;
  String? image;

  @override
  void initState() {
    final cubit = context.read<MembersCubit>();
    cubit.initEditMember(widget._id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return CustomAppPage(
        child: Scaffold(
          appBar: CustomAppBar(
            title: widget._id == null
                ? 'lbl_add_member'.tr()
                : 'lbl_edit_member'.tr(),
            centerTitle: true,
          ),
          body: BlocListener<MembersCubit, MembersState>(
            listener: (context, state) async {
              if (state.isError) {
                showSnackBar(context, message: state.errorMessage);
              }
              if (state.isAdded) {
                await context.read<MembersCubit>().getMembers();
                Navigator.pop(context);
              }
              if (state.isLoaded) {
                if (widget._id != null) {
                  memberNameController.text = state.selectedMember?.name ?? '';
                  phoneNumberController.text =
                      state.selectedMember?.phone ?? '';
                  _selectedGender = state.selectedMember?.gender;
                  image = state.selectedMember?.image;
                  _selectedPhoneNumber = PhoneNumber(
                      countryISOCode: '',
                      countryCode: state.selectedMember?.countryCode ?? '',
                      number: state.selectedMember?.phone ?? '');
                }
              }
            },
            child: BlocListener<MembersCubit, MembersState>(
              listener: (context, state) {},
              child: BlocBuilder<MembersCubit, MembersState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const CustomLoading();
                  }

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 23),
                      child: Form(
                        key: formKey,
                        child: Column(children: [
                          SizedBox(height: 24.h),
                          UserProfileImagePicker(
                            currentImage: image,
                            onImageSelected: (imagePath) {
                              image = imagePath;
                            },
                          ),
                          SizedBox(height: 24.h),
                          DefaultTextFormField(
                            currentFocusNode: memberNameFocusNode,
                            currentController: memberNameController,
                            isRequired: true,
                            hint: 'name'.tr(),
                          ),
                          const SizedBox(height: 16),
                          PhoneTextFormField(
                            currentFocusNode: phoneNumberFocusNode,
                            currentController: phoneNumberController,
                            hint: 'phone_number'.tr(),
                            initialValue: _selectedPhoneNumber,
                            nextFocusNode: memberNameFocusNode,
                            onInputChanged: (PhoneNumber? value) {
                              _selectedPhoneNumber = value;
                            },
                          ),
                          const SizedBox(height: 16),
                          _buildGenderRow(),
                          SizedBox(height: 32.h),
                          DefaultButton(
                            onPressed: () async {
                              final String customerId =
                                  context.read<AuthCubit>().state.user?.id ??
                                      '';

                              if (!_notValid()) {
                                MemberModel member = MemberModel(
                                    id: widget._id,
                                    customerId: int.parse(customerId),
                                    image: image,
                                    countryCode:
                                        _selectedPhoneNumber?.countryCode ?? '',
                                    name: memberNameController.text,
                                    phone: phoneNumberController.text,
                                    gender: _selectedGender);

                                if (widget._id == null) {
                                  await context
                                      .read<MembersCubit>()
                                      .addMember(member);
                                } else {
                                  await context
                                      .read<MembersCubit>()
                                      .updateMember(member);
                                }
                              }
                            },
                            label: 'save'.tr(),
                            isExpanded: true,
                          )
                        ]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    });
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

  bool _notValid() {
    if (!formKey.currentState!.validate()) {
      return true;
    }
    if (_selectedGender == null) {
      setState(() {
        showGenderError = true;
      });
      return true;
    }
    // if (_selectedPhoneNumber == null) {
    //   showSnackBar(context,
    //       message: 'err_msg_please_enter_valid_phone_number'.tr());
    //   return true;
    // }
    setState(() {
      showGenderError = false;
    });

    return false;
  }
}
