import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/empty_page_message.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/warning_container.dart';
import 'package:masaj/features/account/widgets/member_tile.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/features/account/pages/manage_members_screen.dart';
import 'package:masaj/features/book_service/presentation/screens/book_servcie_screen.dart';
import 'package:masaj/features/members/data/model/member_model.dart';
import 'package:masaj/features/members/presentaion/bloc/members_cubit.dart';
import 'package:masaj/features/services/data/models/service_model.dart';

class SelectMembersScreen extends StatefulWidget {
  const SelectMembersScreen({super.key, required this.serviceModel});
  final ServiceModel serviceModel;

  @override
  State<SelectMembersScreen> createState() => _SelectMembersScreenState();
}

class _SelectMembersScreenState extends State<SelectMembersScreen> {
  final List<MemberModel> selectedMembers = [];

  @override
  void initState() {
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
            body: _buildBody(context)));
  }

  Padding _buildBody(context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          SizedBox(height: 25.h),
          const WarningContainer(title: 'msg_you_undertake_to'),
          SizedBox(height: 25.h),
          _buildMemberList(),
          DefaultButton(
            margin: const EdgeInsets.symmetric(vertical: 20),
            isExpanded: true,
            onPressed: () {
              if (selectedMembers.isEmpty) {
                return showSnackBar(context, message: 'select_member');
              }
              Navigator.of(context).pushNamed(BookServiceScreen.routeName,
                  arguments: widget.serviceModel);
            },
            label: 'continue',
          ),
          SizedBox(height: bottomPadding)
        ],
      ),
    );
  }

  Widget _buildMemberList() {
    return Builder(builder: (context) {
      final cubit = context.read<MembersCubit>();

      return Expanded(
        flex: 10,
        child: BlocBuilder<MembersCubit, MembersState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const CustomLoading();
            }
            final members = state.members ?? [];

            if ((members == [] || members.isEmpty)) {
              return RefreshIndicator(
                  onRefresh: cubit.getMembers,
                  child: const EmptyPageMessage(
                    heightRatio: 0.6,
                  ));
            }
            return _buildMembersList(cubit);
          },
        ),
      );
    });
  }

  Widget _buildMembersList(MembersCubit cubit) {
    return RefreshIndicator(
      onRefresh: cubit.getMembers,
      child: ListView.builder(
        itemCount: cubit.state.members?.length,
        itemBuilder: (context, index) => _buildMemberItem(cubit, index),
      ),
    );
  }

  Widget _buildMemberItem(MembersCubit cubit, int index) {
    final members = cubit.state.members;
    return InkWell(
      onTap: () {
        _validateMembers(!(members[index].isSelected ?? false), members[index]);
      },
      child: MemberTile(
        member: members![index],
        action: Checkbox.adaptive(
          activeColor: AppColors.PRIMARY_COLOR,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: const BorderSide(color: AppColors.PRIMARY_COLOR)),
          onChanged: (value) {
            _validateMembers(value, members[index]);
          },
          value: members[index].isSelected,
        ),
      ),
    );
  }

  void _validateMembers(bool? value, MemberModel member) {
    if (selectedMembers.isNotEmpty && !(member.isSelected ?? false)) {
      if (selectedMembers.length >= 2) {
        return showSnackBar(context, message: 'members_number_limit');
      }
      if (selectedMembers[0].gender != member.gender) {
        return showSnackBar(context, message: 'members_number_gender_limit');
      }
    }
    setState(() {
      if (value ?? false) {
        member.isSelected = value ?? false;
        selectedMembers.add(member);
      } else {
        member.isSelected = value ?? false;

        selectedMembers.remove(member);
      }
    });
  }
}
