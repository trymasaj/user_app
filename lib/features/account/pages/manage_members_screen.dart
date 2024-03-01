import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/domain/enums/gender.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/features/account/models/member.dart';
import 'package:masaj/features/members/presentaion/bloc/members_cubit.dart';
import 'package:masaj/features/members/presentaion/pages/add_member_screen.dart';
import 'package:masaj/features/account/widgets/member_tile.dart';

class ManageMembersScreen extends StatelessWidget {
  static const routeName = '/manage-members';

  const ManageMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Injector().membersCubit..getMembers(),
      child: Scaffold(
          appBar: CustomAppBar(
            title: 'lbl_manage_members'.tr(),
            actions: [buildAddMemberButton(context)],
          ),
          body: BlocBuilder<MembersCubit, MembersState>(
            builder: (context, state) {
              if (state.isLoading) {
                return CustomLoading();
              }
              return Container(
                  width: double.maxFinite,
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 23.h),
                  child: Column(children: [
                    for (int i = 0; i < 5; i++)
                      _buildMemberTile(Member(
                          gender: Gender.male.name,
                          name: 'Ahmed Mohamed'.tr(),
                          image: ImageConstant.imgRectangle3943650x50,
                          phone: '96528271116')),
                    SizedBox(height: 5.h)
                  ]));
            },
          )),
    );
  }

  /// Section Widget
  Widget _buildMemberTile(Member member) {
    return MemberTile(
      member: member,
    );
  }

  /// Navigates to the addMember1Screen when the action is triggered.
  onTapAdd(BuildContext context) {
    NavigatorHelper.of(context).pushNamed(AddMemberScreen.routeName);
  }
}

Widget buildAddMemberButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      NavigatorHelper.of(context).pushNamed(AddMemberScreen.routeName);
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14.0),
      child: Text(
        'lbl_add'.tr(),
        style: CustomTextStyles.titleMediumSecondaryContainer.copyWith(
          color: theme.colorScheme.secondaryContainer,
        ),
      ),
    ),
  );
}
