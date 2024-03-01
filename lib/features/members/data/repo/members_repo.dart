import 'package:masaj/features/members/data/datasource/members_datasource.dart';
import 'package:masaj/features/members/data/model/member_model.dart';

abstract class MembersRepository {
  Future<void> addMember(MemberModel member);
  Future<List<MemberModel>> getMembers();
  Future<MemberModel> getMember(int id);
  Future<void> updateMember(int id);
  Future<void> deleteMember(int id);
}

class MembersRepositoryImp extends MembersRepository {
  final MembersDataSource _membersDataSource;

  MembersRepositoryImp({required MembersDataSource membersDataSource})
      : _membersDataSource = membersDataSource;
  @override
  Future<void> addMember(MemberModel member) =>
      _membersDataSource.addMember(member);

  @override
  Future<void> deleteMember(int id) => _membersDataSource.deleteMember(id);

  @override
  Future<MemberModel> getMember(int id) => _membersDataSource.getMember(id);

  @override
  Future<List<MemberModel>> getMembers() =>
      _membersDataSource.getMembers();

  @override
  Future<void> updateMember(int id) => _membersDataSource.updateMember(id);
}
