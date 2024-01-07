import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/features/account/widgets/member_tile.dart';
import 'package:masaj/features/account/models/member.dart';

import '../bloc/manage_members_bloc/manage_members_bloc.dart';
import '../models/manage_members_model.dart';

class ManageMembersScreen extends StatelessWidget {
  static const routeName = '/manage-members';

  const ManageMembersScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<ManageMembersBloc>(
        create: (context) => ManageMembersBloc(
            ManageMembersState(manageMembersModelObj: ManageMembersModel())),
        child: ManageMembersScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageMembersBloc, ManageMembersState>(
        builder: (context, state) {
      return Scaffold(
          appBar: _buildAppBar(context),
          body: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 23.h),
              child: Column(children: [
                for (int i = 0; i < 5; i++)
                  _buildMemberTile(Member(
                      name: "Ahmed Mohamed".tr(),
                      image: ImageConstant.imgRectangle3943650x50,
                      phone: "96528271116")),
                SizedBox(height: 5.h)
              ])));
    });
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("lbl_manage_members".tr()),
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
/*
    NavigatorService.pushNamed(
      AppRoutes.addMember1Screen,
    );
*/
  }
}
