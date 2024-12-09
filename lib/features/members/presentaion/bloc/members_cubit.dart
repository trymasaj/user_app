import 'dart:developer';

import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/core/domain/exceptions/redundant_request_exception.dart';
import 'package:masaj/features/members/data/model/member_model.dart';
import 'package:masaj/features/members/data/repo/members_repo.dart';

part 'members_state.dart';

class MembersCubit extends BaseCubit<MembersState> {
  MembersCubit({
    required MembersRepository membersRepository,
  })  : _membersRepository = membersRepository,
        super(const MembersState());

  final MembersRepository _membersRepository;

  void initEditMember(int? id) async {
    if (id == null) return;
    return getMember(id);
  }

  void updateSelectedMembers(bool? value, MemberModel member) {
    if (value ?? false) {
      member.isSelected = value ?? false;
      final List<MemberModel> updatedMembers = [
        ...state.selectedMembers ?? [],
        member
      ];
      emit(state.copyWith(selectedMembers: updatedMembers));
    } else {
      member.isSelected = value ?? false;
      final List<MemberModel> updatedMembers = [...state.selectedMembers ?? []];
      updatedMembers.remove(member);
      emit(state.copyWith(selectedMembers: updatedMembers));
    }
  }

  Future<void> refresh() async {
    emit(state.copyWith(selectedMembers: []));
    await getMembers();
  }

  Future<void> getMembers() async {
    emit(state.copyWith(status: MembersStateStatus.loading));
    try {
      final members = await _membersRepository.getMembers();
      emit(state.copyWith(status: MembersStateStatus.loaded, members: members));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: MembersStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> getMember(int? id) async {
    if (id == null) return;
    emit(state.copyWith(status: MembersStateStatus.loading));
    try {
      final selectedMember = await _membersRepository.getMember(id);
      emit(state.copyWith(
          status: MembersStateStatus.loaded, selectedMember: selectedMember));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: MembersStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> updateMember(MemberModel? member) async {
    if (member == null) return;
    emit(state.copyWith(status: MembersStateStatus.loading));
    try {
      await _membersRepository.updateMember(member);
      emit(state.copyWith(status: MembersStateStatus.added));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: MembersStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> deleteMember(int? id) async {
    log(id.toString());
    if (id == null) return;

    emit(state.copyWith(status: MembersStateStatus.loading));
    try {
      await _membersRepository.deleteMember(id);
      emit(state.copyWith(status: MembersStateStatus.deleted));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: MembersStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> addMember(MemberModel? member) async {
    if (member == null) return;
    emit(state.copyWith(status: MembersStateStatus.loading));
    try {
      await _membersRepository.addMember(member);
      emit(state.copyWith(status: MembersStateStatus.added));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: MembersStateStatus.error, errorMessage: e.toString()));
    }
  }
}
