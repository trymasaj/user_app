import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/di_wrapper.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/empty_page_message.dart';
import 'package:masaj/core/presentation/widgets/stateless/warning_container.dart';
import 'package:masaj/features/account/widgets/member_tile.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/features/account/pages/manage_members_screen.dart';
import 'package:masaj/features/book_service/presentation/blocs/book_cubit/book_service_cubit.dart';
import 'package:masaj/features/book_service/presentation/screens/book_servcie_screen.dart';
import 'package:masaj/features/members/data/model/member_model.dart';
import 'package:masaj/features/members/presentaion/bloc/members_cubit.dart';

class SelectMembersScreen extends StatefulWidget {
  const SelectMembersScreen({
    super.key,
  });

  @override
  State<SelectMembersScreen> createState() => _SelectMembersScreenState();
}

class _SelectMembersScreenState extends State<SelectMembersScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DI.find<MembersCubit>()..getMembers(),
        child: BlocBuilder<MembersCubit, MembersState>(
          builder: (context, state) {
            return CustomAppPage(
              child: Scaffold(
                  appBar: CustomAppBar(
                    title: AppText.lbl_select_member,
                    actions: [
                      buildAddMemberButton(context, onPop: () {
                        final cubit = context.read<MembersCubit>();
                        cubit.refresh();
                      })
                    ],
                  ),
                  body: _buildBody(context)),
            );
          },
        ));
  }

  Padding _buildBody(BuildContext context) {
    final cubit = context.read<MembersCubit>();
    final selectedMembers = cubit.state.selectedMembers;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          SizedBox(height: 25.h),
          WarningContainer(title: AppText.msg_you_undertake_to),
          SizedBox(height: 25.h),
          _buildMemberList(),
          DefaultButton(
            margin: const EdgeInsets.symmetric(vertical: 20),
            isExpanded: true,
            onPressed: () async {
              if (selectedMembers!.isEmpty) {
                return showSnackBar(context, message: AppText.select_member);
              }
              final bookingCubit = context.read<BookingCubit>();
              final selectedMembersIds =
                  selectedMembers.map((e) => e.id ?? 0).toList();
              await bookingCubit.addBookingMembers(selectedMembersIds);
              Navigator.of(context)
                  .pushNamed(BookServiceScreen.routeName)
                  .then((value) async => await cubit.refresh());
            },
            label: AppText.continue_,
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
                  onRefresh: cubit.refresh,
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
      onRefresh: cubit.refresh,
      child: ListView.builder(
        itemCount: cubit.state.members?.length,
        itemBuilder: (context, index) => _buildMemberItem(cubit, index),
      ),
    );
  }

  Widget _buildMemberItem(MembersCubit cubit, int index) {
    final members = cubit.state.members;
    return BlocBuilder<MembersCubit, MembersState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            _validateMembers(
                !(members[index].isSelected ?? false), members[index], context);
          },
          child: MemberTile(
            index: index,
            member: members![index],
            action: Checkbox.adaptive(
              activeColor: AppColors.PRIMARY_COLOR,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: const BorderSide(color: AppColors.PRIMARY_COLOR)),
              onChanged: (value) {
                _validateMembers(value, members[index], context);
              },
              value: members[index].isSelected,
            ),
          ),
        );
      },
    );
  }

  void _validateMembers(bool? value, MemberModel member, BuildContext context) {
    final cubit = context.read<MembersCubit>();
    final selectedMembers = cubit.state.selectedMembers ?? [];

    if (selectedMembers.isNotEmpty && !(member.isSelected ?? false)) {
      if (selectedMembers.length >= 2) {
        return showSnackBar(context, message: AppText.members_number_limit);
      }
      if (selectedMembers[0].gender != member.gender) {
        return showSnackBar(context, message: AppText.members_number_gender_limit);
      }
    }
    cubit.updateSelectedMembers(value, member);
  }
}
