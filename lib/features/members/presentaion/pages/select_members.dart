import 'package:flutter/material.dart';

import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/domain/enums/gender.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
import 'package:masaj/features/account/widgets/member_tile.dart';

import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/features/account/models/member.dart';
import 'package:masaj/features/account/pages/manage_members_screen.dart';

class SelectMembersScreen extends StatefulWidget {
  const SelectMembersScreen({super.key});

  @override
  State<SelectMembersScreen> createState() => _SelectMembersScreenState();
}

class _SelectMembersScreenState extends State<SelectMembersScreen> {
  late final List<Member> members;

  @override
  void initState() {
    members = dummyMembersData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'lbl_select_member'.tr(),
          actions: [buildAddMemberButton(context)],
        ),
        body: Padding(
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
                  itemBuilder: (context, index) => MemberTile(
                    member: members[index],
                    action: Checkbox.adaptive(
                      activeColor: AppColors.PRIMARY_COLOR,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      onChanged: (value) {
                        setState(() {
                          members[index].isSelected = value ?? false;
                        });
                      },
                      value: members[index].isSelected,
                    ),
                  ),
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
        ));
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
