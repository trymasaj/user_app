part of 'members_cubit.dart';

enum MembersStateStatus { initial, loading, loaded, error, deleted, added }

extension MembersStateX on MembersState {
  bool get isInitial => status == MembersStateStatus.initial;
  bool get isLoading => status == MembersStateStatus.loading;
  bool get isLoaded => status == MembersStateStatus.loaded;
  bool get isError => status == MembersStateStatus.error;
  bool get isDeleted => status == MembersStateStatus.deleted;
  bool get isAdded => status == MembersStateStatus.added;
}

class MembersState {
  final MembersStateStatus status;
  final List<MemberModel>? members;
  final MemberModel? selectedMember;
  final String? errorMessage;
  final List<MemberModel>? selectedMembers;

  const MembersState({
    this.members,
    this.selectedMember,
    this.status = MembersStateStatus.initial,
    this.errorMessage,
    this.selectedMembers,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as MembersState).status == status &&
        other.members == members &&
        other.selectedMember == selectedMember &&
        other.errorMessage == errorMessage &&
        other.selectedMembers == members;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      errorMessage.hashCode ^
      Object.hashAll(members ?? []) ^
      selectedMember.hashCode ^
      Object.hashAll(selectedMembers ?? []);

  MembersState copyWith(
      {MembersStateStatus? status,
      String? errorMessage,
      MemberModel? selectedMember,
      List<MemberModel>? members,
      List<MemberModel>? selectedMembers}) {
    return MembersState(
      status: status ?? this.status,
      members: members ?? this.members,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedMember: selectedMember ?? this.selectedMember,
      selectedMembers: selectedMembers ?? this.selectedMembers,
    );
  }
}
