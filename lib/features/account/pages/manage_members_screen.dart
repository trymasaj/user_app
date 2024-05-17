import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/empty_page_message.dart';
import 'package:masaj/features/members/data/model/member_model.dart';
import 'package:masaj/features/members/presentaion/bloc/members_cubit.dart';
import 'package:masaj/features/members/presentaion/pages/add_member_screen.dart';
import 'package:masaj/features/account/widgets/member_tile.dart';

class ManageMembersScreen extends StatefulWidget {
  static const routeName = '/manage-members';

  const ManageMembersScreen({super.key});

  @override
  State<ManageMembersScreen> createState() => _ManageMembersScreenState();
}

class _ManageMembersScreenState extends State<ManageMembersScreen> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<MembersCubit>();
    cubit.getMembers();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppPage(
      child: Scaffold(
          appBar: CustomAppBar(
            title: 'lbl_manage_members'.tr(),
            actions: [buildAddMemberButton(context)],
            centerTitle: true,
          ),
          body: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    final cubit = context.read<MembersCubit>();

    return Builder(builder: (context) {
      return BlocListener<MembersCubit, MembersState>(
        listener: (context, state) {
          if (state.isError) {
            showSnackBar(context, message: state.errorMessage);
          }
          if (state.isDeleted) {
            cubit.getMembers();
          }
        },
        child: BlocBuilder<MembersCubit, MembersState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const CustomLoading();
            }
            final members = state.members;
            if ((members == null || members.isEmpty)) {
              return RefreshIndicator(
                  onRefresh: cubit.getMembers,
                  child: const EmptyPageMessage(
                    heightRatio: 0.6,
                  ));
            }
            return _buildMembersList(members, context);
          },
        ),
      );
    });
  }

  Widget _buildMembersList(List<MemberModel>? members, BuildContext context) {
    return RefreshIndicator(
      onRefresh: context.read<MembersCubit>().getMembers,
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 23.h),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return _buildMemberTile(members[index], context, index);
          },
          itemCount: members!.length,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildMemberTile(MemberModel member, BuildContext context, int index) {
    final cubit = context.read<MembersCubit>();

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => AddMemberScreen(
                  id: member.id,
                )));
      },
      child: Slidable(
        key: ValueKey(member.id),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(
            onDismissed: () => cubit.deleteMember(member.id),
          ),
          children: [
            SlidableAction(
              onPressed: (context) => cubit.deleteMember(member.id),
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: MemberTile(
          index: index,
          member: member,
        ),
      ),
    );
  }

  /// Navigates to the addMember1Screen when the action is triggered.
  onTapAdd(BuildContext context) {
    NavigatorHelper.of(context).pushNamed(AddMemberScreen.routeName);
  }
}

Widget buildAddMemberButton(BuildContext context, {VoidCallback? onPop}) {
  return Builder(builder: (context) {
    return GestureDetector(
      onTap: () {
        NavigatorHelper.of(context)
            .pushNamed(AddMemberScreen.routeName)
            .then((value) async {
          await context.read<MembersCubit>().getMembers();
          onPop != null ? onPop() : null;
        });
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
  });
}
