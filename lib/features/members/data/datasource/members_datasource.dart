// ignore_for_file: void_checks
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:masaj/core/data/clients/network_service.dart';
import 'package:masaj/core/data/constants/api_end_point.dart';
import 'package:masaj/core/domain/enums/request_result_enum.dart';
import 'package:masaj/core/domain/exceptions/request_exception.dart';
import 'package:masaj/features/members/data/model/member_model.dart';

abstract class MembersDataSource {
  Future<void> addMember(MemberModel member);
  Future<List<MemberModel>> getMembers();
  Future<MemberModel> getMember(int id);
  Future<void> updateMember(int id);
  Future<void> deleteMember(int id);
}

class MembersDataSourceImpl extends MembersDataSource {
  final NetworkService _networkService;

  MembersDataSourceImpl({required NetworkService networkService})
      : _networkService = networkService;

  Future<FormData> _createFormData(Map<String, dynamic> member) async {
    if (member['image'] == null) return FormData.fromMap(member);

    member['image'] = await MultipartFile.fromFile(member['image']);

    return FormData.fromMap(member);
  }

  @override
  Future<void> addMember(MemberModel member) async {
    const url = ApiEndPoint.ADD_MEMBER;
    var formData = await _createFormData(member.toMap());
    var header = await _networkService.getDefaultHeaders();

    header.putIfAbsent(
        'Content-Type',
        () =>
            'multipart/form-data; boundary=<calculated when request is sent>');
    return _networkService.post(url, data: formData).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data['detail']);
      }
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name) {
        throw RequestException(message: result['msg']);
      }
      return MemberModel.fromMap(result);
    });
  }

  @override
  Future<void> deleteMember(int id) {
    const url = ApiEndPoint.DELETE_MEMBER;
    return _networkService.delete('$url/$id').then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
      final result = response.data;
      final resultStatus = result['status'];
      if (resultStatus == RequestResult.Failed.name) {
        throw RequestException(message: result['msg']);
      }
      // return MemberModel.fromMap(result);
    });
  }

  @override
  Future<MemberModel> getMember(int id) {
    const url = ApiEndPoint.GET_MEMBER;
    return _networkService.get(url + '/' + id.toString()).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
      final result = response.data;
      final resultStatus = result['status'];
      if (resultStatus == RequestResult.Failed.name) {
        throw RequestException(message: result['msg']);
      }
      return MemberModel.fromMap(result);
    });
  }

  @override
  Future<List<MemberModel>> getMembers() {
    const url = ApiEndPoint.GET_MEMBERS;
    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
      final result = response.data;
      log(response.data.toString());
      // final resultStatus = result['status'];
      // if (resultStatus == RequestResult.Failed.name) {
      //   throw RequestException(message: result['msg']);
      // }
      return result != null
          ? (result as List).map((e) => MemberModel.fromMap(e)).toList()
          : [];
    });
  }

  @override
  Future<void> updateMember(int id) {
    const url = ApiEndPoint.UPDATE_MEMBER;
    return _networkService.put(url + id.toString()).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
      final result = response.data;
      final resultStatus = result['status'];
      if (resultStatus == RequestResult.Failed.name) {
        throw RequestException(message: result['msg']);
      }
      return MemberModel.fromMap(result);
    });
  }
}
