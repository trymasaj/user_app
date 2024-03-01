import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injection_setup.config.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/domain/enums/gender.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
import 'package:masaj/features/account/widgets/member_tile.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/features/account/models/member.dart';
import 'package:masaj/features/account/pages/manage_members_screen.dart';
import 'package:masaj/features/members/presentaion/bloc/members_cubit.dart';

class SelectMembersScreen extends StatefulWidget {
  const SelectMembersScreen({super.key});

  @override
  State<SelectMembersScreen> createState() => _SelectMembersScreenState();
}

class _SelectMembersScreenState extends State<SelectMembersScreen> {
  late final List<Member> members;
  final List<Member> selectedMembers = [];

  @override
  void initState() {
    members = dummyMembersData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Injector().membersCubit..getMembers(),
      child: Scaffold(
          appBar: CustomAppBar(
            title: 'lbl_select_member'.tr(),
            actions: [buildAddMemberButton(context)],
          ),
          body: BlocBuilder<MembersCubit, MembersState>(
            builder: (context, state) {
              if (state.isLoading) {
                return CustomLoading();
              }
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    SizedBox(height: 25.h),
                    _buildWaringMsg(),
                    SizedBox(height: 25.h),
                    Expanded(
                      flex: 10,
                      child: ListView.builder(
                        itemCount: members.length,
                        itemBuilder: (context, index) =>
                            _buildMemberItem(index),
                      ),
                    ),
                    const Spacer(flex: 3),
                    DefaultButton(
                      padding: EdgeInsets.symmetric(horizontal: 130.w),
                      onPressed: () {},
                      label: 'continue',
                    ),
                    const Spacer(),
                  ],
                ),
              );
            },
          )),
    );
  }

  Widget _buildMemberItem(int index) {
    return InkWell(
      onTap: () {
        _validateMembers(!members[index].isSelected, index);
      },
      child: MemberTile(
        member: members[index],
        action: Checkbox.adaptive(
          activeColor: AppColors.PRIMARY_COLOR,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          onChanged: (value) {
            _validateMembers(value, index);
          },
          value: members[index].isSelected,
        ),
      ),
    );
  }

  void _validateMembers(bool? value, int index) {
    if (selectedMembers.isNotEmpty && !members[index].isSelected) {
      if (selectedMembers.length >= 2) {
        return showSnackBar(context, message: 'members_number_limit');
      }
      if (selectedMembers[0].gender != members[index].gender) {
        return showSnackBar(context, message: 'members_number_gender_limit');
      }
    }
    setState(() {
      if (value ?? false) {
        members[index].isSelected = value ?? false;
        selectedMembers.add(members[index]);
      } else {
        members[index].isSelected = value ?? false;

        selectedMembers.remove(members[index]);
      }
    });
  }

  Widget _buildWaringMsg() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.PRIMARY_DARK_COLOR.withOpacity(0.08)),
      child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(Icons.info_outline_rounded,
            size: 25, color: AppColors.PRIMARY_DARK_COLOR),
        SizedBox(width: 6),
        Expanded(
            child: SubtitleText(
          text: 'msg_you_undertake_to',
          subtractedSize: 2.5,
        ))
      ]),
    );
  }
}

final dummyMembersData = [
  Member(
      gender: Gender.male.name,
      name: '7amo',
      image: '',
      phone: '+201156665020'),
  Member(
      gender: Gender.male.name,
      name: 'Memo',
      image: '',
      phone: '+201156665020'),
  Member(
      gender: Gender.female.name,
      name: 'Donia',
      image: '',
      phone: '+201156665020'),
  Member(
      gender: Gender.female.name,
      name: 'Sa7ar',
      image: '',
      phone: '+201156665020'),
  Member(
      gender: Gender.male.name,
      name: '7amo',
      image: '',
      phone: '+201156665020'),
  Member(
      gender: Gender.male.name,
      name: '7amo',
      image: '',
      phone: '+201156665020'),
  Member(
      gender: Gender.male.name,
      name: '7amo',
      image: '',
      phone: '+201156665020'),
  Member(
      gender: Gender.male.name,
      name: '7amo',
      image: '',
      phone: '+201156665020'),
  Member(
      gender: Gender.male.name,
      name: '7amo',
      image: '',
      phone: '+201156665020'),
  Member(
      gender: Gender.male.name,
      name: '7amo',
      image: '',
      phone: '+201156665020'),
];
