import 'package:dio/dio.dart';
import 'package:masaj/core/data/clients/network_service.dart';
import 'package:masaj/core/data/constants/api_end_point.dart';
import 'package:masaj/core/domain/enums/age_group.dart';
import 'package:masaj/core/domain/enums/gender.dart';
import 'package:masaj/core/domain/enums/request_result_enum.dart';
import 'package:masaj/core/domain/exceptions/request_exception.dart';

import 'package:masaj/core/data/models/interest_model.dart';
import 'package:masaj/features/account/data/models/contact_us_message_model.dart';
import 'package:masaj/features/auth/domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<User> login(
    String phoneNumber,
    String countryCode,
    String password,
    String? mobileAppId,
    int? deviceType,
  );

  Future<User> externalLogin(User user);

  Future<User> signUp(User user);

  Future<User> updateProfileInformation(User user);

  Future<void> forgetPassword(String email);
  Future<User> verifyForgetPassword(String email, String otp);
  Future<User> resetPassword(
      String newPassword, String confirmPassword, int userId, String token);

  Future<void> changePassword(String oldPassword, String newPassword);

  Future<User?> getUserData();

  Future<User> editAccountData(User newUser);

  Future<void> logout(String userId);

  Future<void> deleteAccount(ContactUsMessage message);

  Future<void> informBackendAboutLanguageChanges(String languageCode);

  Future<String?> completeRegistration({
    required String fullName,
    required String mobile,
    Gender? gender,
    AgeGroup? ageGroup,
  });

  Future<List<InterestModel>> getInterestData();

  Future<void> editUserInterests(List<int> selectedInterests);

  Future<bool> checkEmailVerified();

  Future<void> resendVerificationEmail();

  Future<void> selectProject(int projectId);

  Future<void> updateUserNotificationStatus(bool isEnabled);
  Future<User?> verifyOtp(User user, String otp);
  Future<void> resendOtp(User user);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final NetworkService _networkService;

  AuthRemoteDataSourceImpl(this._networkService);

  @override
  Future<User> signUp(User user) async {
    const url = ApiEndPoint.SIGN_UP;

    // final formData = await _createFormData(user.toMap());

    return _networkService.post(url, data: user.toMap()).then((response) {
      if (![201, 200].contains(response.statusCode)) {
        throw RequestException.fromStatusCode(
            statusCode: response.statusCode!, response: response.data);
      }
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name) {
        throw RequestException(message: result['msg']);
      }
      return User.fromMap(result);
    });
  }

  Future<FormData> _createFormData(Map<String, dynamic> user) async {
    if (user['imageFile'] == null) return FormData.fromMap(user);

    user['imageFile'] = await MultipartFile.fromFile(user['imageFile']);

    return FormData.fromMap(user);
  }

  @override
  Future<User> login(
    String phoneNumber,
    String countryCode,
    String password,
    String? mobileAppId,
    int? deviceType,
  ) {
    const url = ApiEndPoint.LOGIN;
    final data = {
      'phone': phoneNumber,
      'countryCode': countryCode,
      // 'phone': phoneNumber,
      'password': password,
      'mobileAppId': mobileAppId,
      'deviceType': deviceType,
    }..removeWhere((_, v) => v == null);
    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) {
        throw RequestException.fromStatusCode(
            statusCode: response.statusCode!, response: response.data);
      }
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name) {
        throw RequestException(message: result['msg']);
      }
      return User.fromMap(result);
    });
  }

  @override
  Future<User> externalLogin(
    User user,
  ) {
    const url = ApiEndPoint.EXTERNAL_LOGIN;
    final data = user.toSocialMediaMap();
    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) {
        throw RequestException.fromStatusCode(
            statusCode: response.statusCode!, response: response.data);
      }
      final result = response.data;
      // final resultStatus = result['result'];
      // if (resultStatus == RequestResult.Failed.name) {
      //   throw RequestException(message: result['msg']);
      // }

      return User.fromMap(result);
    });
  }

  @override
  Future<void> forgetPassword(String email) {
    const url = ApiEndPoint.FORGET_PASSWORD;
    final data = {'emailOrPhone': email};
    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) {
        throw RequestException.fromStatusCode(
            statusCode: response.statusCode!, response: response.data);
      }
      final result = response.data;
    
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name) {
        throw RequestException(message: result['msg']);
      }
    });
  }

  @override
  Future<void> changePassword(String oldPassword, String newPassword) {
    const url = ApiEndPoint.CHANGE_PASSWORD;
    final data = {
      'OldPassword': oldPassword,
      'NewPassword': newPassword,
    };

    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) {
        throw RequestException.fromStatusCode(
            statusCode: response.statusCode!, response: response.data);
      }
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name) {
        throw RequestException(message: result['msg']);
      }
    });
  }

  @override
  Future<User?> getUserData() async {
    const url = ApiEndPoint.USER_INFO;

    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) {
        throw RequestException.fromStatusCode(
            statusCode: response.statusCode!, response: response.data);
      }
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name) {
        throw RequestException(message: result['msg']);
      }
      return User.fromMap(result['data']);
    });
  }

  @override
  Future<User> editAccountData(User newUser) async {
    const url = ApiEndPoint.EDIT_USER_INFO;

    final formData = await _createFormData(newUser.toMap());

    return _networkService.post(url, data: formData).then((response) {
      if (response.statusCode != 200) {
        throw RequestException.fromStatusCode(
            statusCode: response.statusCode!, response: response.data);
      }
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name) {
        throw RequestException(message: result['msg']);
      }
      return User.fromMap(result['data']);
    });
  }

  @override
  Future<void> logout(String userId) {
    const url = ApiEndPoint.LOGOUT;
    final data = {'userId': userId};

    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) {
        throw RequestException.fromStatusCode(
            statusCode: response.statusCode!, response: response.data);
      }
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name) {
        throw RequestException(message: result['msg']);
      }
    });
  }

  @override
  Future<void> deleteAccount(ContactUsMessage message) {
    const url = ApiEndPoint.CONTACT_US;

    return _networkService.post(url, data: message.toMap()).then((response) {
      if (response.statusCode != 200) {
        throw RequestException.fromStatusCode(
            statusCode: response.statusCode!, response: response.data);
      }
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name) {
        throw RequestException(message: result['msg']);
      }
    });
  }

  @override
  Future<void> informBackendAboutLanguageChanges(String languageCode) async {
    const url = ApiEndPoint.UPDATE_USER_LANGUAGE;
    final params = {'language': languageCode};

    return _networkService.post(url, queryParameters: params).then((response) {
      if (response.statusCode != 200) {
        throw RequestException.fromStatusCode(
            statusCode: response.statusCode!, response: response.data);
      }
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name) {
        throw RequestException(message: result['msg']);
      }
    });
  }

  @override
  Future<String?> completeRegistration({
    required String fullName,
    required String mobile,
    Gender? gender,
    AgeGroup? ageGroup,
  }) async {
    const url = ApiEndPoint.CONFIRM_REGISTRATION;
    final data = {
      'fullName': fullName,
      'mobile': mobile,
      if (gender != null) 'gender': gender.id,
      if (ageGroup != null) 'ageGroup': ageGroup.index,
    };

    final formData = await _createFormData(data);
    return _networkService.post(url, data: formData).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name) {
        throw RequestException(message: result['msg']);
      }

      return result['data']['ticketMXAccessToken'];
    });
  }

  @override
  Future<List<InterestModel>> getInterestData() {
    const url = ApiEndPoint.GET_INTERESTS;

    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name) {
        throw RequestException(message: result['msg']);
      }

      final data = result['data'] as List;
      return data.map((e) => InterestModel.fromMap(e)).toList();
    });
  }

  @override
  Future<void> editUserInterests(List<int> selectedInterests) async {
    const url = ApiEndPoint.EDIT_USER_INTERESTS;
    final data = {'userInterests': selectedInterests};

    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name) {
        throw RequestException(message: result['msg']);
      }
    });
  }

  @override
  Future<bool> checkEmailVerified() {
    const url = ApiEndPoint.CHECK_EMAIL_VERIFIED;

    return _networkService.post(url).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name) {
        throw RequestException(message: result['msg']);
      }
      return result['data'];
    });
  }

  @override
  Future<void> resendVerificationEmail() {
    const url = ApiEndPoint.RESEND_VERIFICATION_EMAIL;

    return _networkService.post(url).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name) {
        throw RequestException(message: result['msg']);
      }
    });
  }

  @override
  Future<void> selectProject(int projectId) {
    const url = ApiEndPoint.SELECT_PROJECT;
    final params = {'id': projectId};

    return _networkService.post(url, queryParameters: params).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name) {
        throw RequestException(message: result['msg']);
      }
    });
  }

  @override
  Future<void> updateUserNotificationStatus(bool isEnabled) {
    const url = ApiEndPoint.UPDATE_USER_NOTIFICATION;
    final params = {'enabled': isEnabled};

    return _networkService.post(url, queryParameters: params).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name) {
        throw RequestException(message: result['msg']);
      }
    });
  }

  @override
  Future<User?> verifyOtp(User user, String otp) {
    const url = ApiEndPoint.VERIFY_OTP;
    final data = {
      'otp': otp,
    };
    // bearerToken: user.token,
    final headers = {'Authorization': 'Bearer ${user.token}'};

    return _networkService
        .post(url, data: data, headers: headers)
        .then((response) {
      if (response.statusCode != 200) {
        throw RequestException.fromStatusCode(
            statusCode: response.statusCode!, response: response.data);
      }
      final result = response.data;

      return User.fromMap(result);
    });
  }

  @override
  Future<void> resendOtp(User user) async {
    const url = ApiEndPoint.RESEND_OTP;
    final headers = {'Authorization': 'Bearer ${user.token}'};

    return _networkService.post(url, headers: headers).then((response) {
      if (response.statusCode != 200) {
        throw RequestException.fromStatusCode(
            statusCode: response.statusCode!, response: response.data);
      }
    });
  }

  @override
  Future<User> verifyForgetPassword(String email, String otp) async {
    const url = ApiEndPoint.VERIFY_FORGET_PASSWORD;
    final data = {
      'emailOrPhone': email,
      'otp': otp,
    };

    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) {
        throw RequestException.fromStatusCode(
            statusCode: response.statusCode!, response: response.data);
      }
      return User.fromMap(response.data);
    });
  }

  @override
  Future<User> resetPassword(String newPassword, String confirmPassword,
      int userId, String token) async {
    const url = ApiEndPoint.RESET_PASSWORD;
    final data = {
      'password': newPassword,
      'confirmPassword': confirmPassword,
      'userId': userId,
    };
    final headers = {'Authorization': 'Bearer $token'};

    return _networkService
        .post(url, data: data, headers: headers)
        .then((response) {
      if (response.statusCode != 200) {
        throw RequestException.fromStatusCode(
            statusCode: response.statusCode!, response: response.data);
      }

      return User.fromMap(response.data);
    });
  }

  @override
  Future<User> updateProfileInformation(User user) {
    const url = ApiEndPoint.UPDATE_PROFILE_INFORMATION;
    final data = {
      'userId': user.id,
      'fullName': user.fullName,
      'email': user.email,
      'phone': user.phone,
      'gender': user.gender?.id,
      'countryCode': user.countryCode,
      'countryId': user.countryId,
      'birthDate': user.birthDate?.toIso8601String(),
    }..removeWhere((_, v) => v == null);

    return _networkService.post(
      url,
      data: data,
      headers: {'Authorization': 'Bearer ${user.token}'},
    ).then((response) {
      if (response.statusCode != 200) {
        throw RequestException.fromStatusCode(
            statusCode: response.statusCode!, response: response.data);
      }

      return User.fromMap(response.data);
    });
  }
}
