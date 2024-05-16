import 'package:masaj/core/data/clients/network_service.dart';
import 'package:masaj/core/data/constants/api_end_point.dart';
import 'package:masaj/core/domain/exceptions/request_exception.dart';
import 'package:masaj/features/medical_form/data/model/condition_model.dart';
import 'package:masaj/features/medical_form/data/model/medical_form_model.dart';

abstract class MedicalFormDataSource {
  Future<MedicalForm> getMedicalForm();
  Future<MedicalForm> addMedicalForm(MedicalForm medicalForm);
  Future<List<MedicalCondition>> getConditions();
}

class MedicalFormDataSourceImpl extends MedicalFormDataSource {
  final NetworkService _networkService;

  MedicalFormDataSourceImpl({required NetworkService networkService})
      : _networkService = networkService;

  @override
  Future<MedicalForm> addMedicalForm(MedicalForm medicalForm) {
    const url = ApiEndPoint.MEDICAL_FORM;

    final conditions = medicalForm.conditions!.map((e) => e.id).toList();
    final data = medicalForm.toMap()
      ..remove('conditions')
      ..addAll({'conditions': conditions})
      ..removeWhere((key, value) => value == null);
    return _networkService
        .post(
      url,
      data: data,
    )
        .then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
      final result = response.data;

      return MedicalForm.fromMap(result);
    });
  }

  @override
  Future<MedicalForm> getMedicalForm() {
    const url = ApiEndPoint.MEDICAL_FORM;
    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
      final result = response.data;

      return MedicalForm.fromMap(result);
    });
  }

  @override
  Future<List<MedicalCondition>> getConditions() {
    const url = ApiEndPoint.MEDICAL_CONDITION;
    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
      final result = response.data;

      return result != null
          ? (result as List).map((e) => MedicalCondition.fromMap(e)).toList()
          : [];
    });
  }
}
