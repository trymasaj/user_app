import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/clients/cache_manager.dart';
import 'package:masaj/core/data/constants/api_end_point.dart';
import 'package:masaj/core/data/datasources/device_type_data_source.dart';
import 'package:masaj/core/data/debug/custom_printer.dart';
import 'package:masaj/core/data/logger/abs_logger.dart';
import 'package:masaj/core/domain/enums/request_result_enum.dart';
import 'package:masaj/core/domain/exceptions/connection_exception.dart';
import 'package:masaj/core/domain/exceptions/redundant_request_exception.dart';
import 'package:masaj/core/domain/exceptions/request_exception.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/features/auth/domain/entities/user.dart';
import 'package:masaj/features/auth/presentation/pages/login_page.dart';
import 'package:masaj/main.dart';
import 'package:requests_inspector/requests_inspector.dart';

abstract class NetworkService {


  NetworkService();

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool refreshTokenIfNeeded = true,
    ResponseType? responseType,
  });

  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool refreshTokenIfNeeded = true,
    ResponseType? responseType,
  });

  Future<Response> patch(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool refreshTokenIfNeeded = true,
    ResponseType? responseType,
  });

  Future<Response> put(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool refreshTokenIfNeeded = true,
    ResponseType? responseType,
  });

  Future<Response> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool refreshTokenIfNeeded = true,
    ResponseType? responseType,
  });

  Future<Response> downloadFile(
    String apiBaseUrl,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<Uint8List> readBytes(String apiBaseUrl);

  Future<Map<String, dynamic>> getDefaultHeaders([String? language]);

  Map<String, dynamic>? formatQueryIfNeeded(
    Map<String, dynamic>? queryParameters,
  );

  Future<Map<String, String>> createRefreshTokenBody();

  Future<void> updateCurrentTokens(Map data);

  Future<void> logout();
}


class NetworkServiceImpl implements NetworkService {
  NetworkServiceImpl(
    this._networkServiceUtil,
    this._deviceTypeDataSource,
    this._logger
  );

  final NetworkServiceUtil _networkServiceUtil;
  final DeviceTypeDataSource _deviceTypeDataSource;
  final AbsLogger _logger;

  final _dio = Dio(BaseOptions(validateStatus: (_) => true))
    ..interceptors.add(BUILD_TYPE != BuildType.release
        ? RequestsInspectorInterceptor()
        : const Interceptor());

  String? _requestName;

  final _pendingRequests = <String>[];

  @override
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool refreshTokenIfNeeded = true,
    ResponseType? responseType,
  }) async {
    _requestName = _extractName(url);
    headers ??= await getDefaultHeaders();
    final requestId = _generateRequestId(
        url: url, queryParameters: queryParameters, headers: headers);
    if (_pendingRequests.contains(requestId)) {
      throw RedundantRequestException('Request is already pending for $url');
    }

    _pendingRequests.add(requestId);
    return _connectionExceptionCatcher(() => _get(
          url,
          queryParameters: formatQueryIfNeeded(queryParameters),
          headers: headers!,
          refreshTokenIfNeeded: refreshTokenIfNeeded,
          responseType: responseType,
        )).whenComplete(() => _pendingRequests.remove(requestId));
  }

  @override
  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool refreshTokenIfNeeded = true,
    ResponseType? responseType,
  }) async {
    _requestName = _extractName(url);
    headers ??= await getDefaultHeaders();
    final requestId = _generateRequestId(
      url: url,
      headers: headers,
      queryParameters: queryParameters,
      data: data,
    );
    if (_pendingRequests.contains(requestId)) {
      throw RedundantRequestException('Request is already pending for $url');
    }

    _pendingRequests.add(requestId);
    return _connectionExceptionCatcher(() => _post(
          url,
          queryParameters: formatQueryIfNeeded(queryParameters),
          data: data,
          headers: headers!,
          refreshTokenIfNeeded: refreshTokenIfNeeded,
          responseType: responseType,
        )).whenComplete(() => _pendingRequests.remove(requestId));
  }

  @override
  Future<Response> patch(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool refreshTokenIfNeeded = true,
    ResponseType? responseType,
  }) async {
    _requestName = _extractName(url);
    headers ??= await getDefaultHeaders();
    final requestId = _generateRequestId(
      url: url,
      headers: headers,
      queryParameters: queryParameters,
      data: data,
    );
    if (_pendingRequests.contains(requestId)) {
      throw RedundantRequestException('Request is already pending for $url');
    }

    _pendingRequests.add(requestId);
    return _connectionExceptionCatcher(() => _patch(
          url,
          queryParameters: formatQueryIfNeeded(queryParameters),
          data: data,
          headers: headers!,
          refreshTokenIfNeeded: refreshTokenIfNeeded,
          responseType: responseType,
        )).whenComplete(() => _pendingRequests.remove(requestId));
  }

  @override
  Future<Response> put(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool refreshTokenIfNeeded = true,
    ResponseType? responseType,
  }) async {
    _requestName = _extractName(url);
    headers ??= await getDefaultHeaders();
    final requestId = _generateRequestId(
      url: url,
      headers: headers,
      queryParameters: queryParameters,
      data: data,
    );
    if (_pendingRequests.contains(requestId)) {
      throw RedundantRequestException('Request is already pending for $url');
    }

    _pendingRequests.add(requestId);
    return _connectionExceptionCatcher(() => _put(
          url,
          queryParameters: formatQueryIfNeeded(queryParameters),
          data: data,
          headers: headers!,
          refreshTokenIfNeeded: refreshTokenIfNeeded,
          responseType: responseType,
        )).whenComplete(() => _pendingRequests.remove(requestId));
  }

  @override
  Future<Response> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool refreshTokenIfNeeded = true,
    ResponseType? responseType,
  }) async {
    _requestName = _extractName(url);
    headers ??= await getDefaultHeaders();
    final requestId = _generateRequestId(
      url: url,
      headers: headers,
      queryParameters: queryParameters,
      data: data,
    );
    if (_pendingRequests.contains(requestId)) {
      throw RedundantRequestException('Request is already pending for $url');
    }

    _pendingRequests.add(requestId);
    return _connectionExceptionCatcher(() => _delete(
          url,
          queryParameters: formatQueryIfNeeded(queryParameters),
          data: data,
          headers: headers!,
          refreshTokenIfNeeded: refreshTokenIfNeeded,
          responseType: responseType,
        )).whenComplete(() => _pendingRequests.remove(requestId));
  }

  @override
  Future<Response> downloadFile(
    String apiBaseUrl,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    _requestName = _extractName(apiBaseUrl);
    headers ??= await getDefaultHeaders();
    final requestId = _generateRequestId(
        url: apiBaseUrl, queryParameters: queryParameters, headers: headers);
    if (_pendingRequests.contains(requestId)) {
      throw RedundantRequestException(
          'Request is already pending for $apiBaseUrl');
    }

    _pendingRequests.add(requestId);
    return _connectionExceptionCatcher(() => _downloadFile(
          apiBaseUrl,
          savePath,
          queryParameters: formatQueryIfNeeded(queryParameters),
          headers: headers!,
        )).whenComplete(() => _pendingRequests.remove(requestId));
  }

  String _generateRequestId({
    url,
    queryParameters,
    headers,
    data,
  }) =>
      '${url ?? ''}${queryParameters ?? ''}${headers ?? ''}${data ?? ''}';

  String _extractName(String url) {
    url = url.split('?').first;
    final name = url.split('/').last;
    return name.toUpperCase();
  }

  Future<Response> _get(
    String apiBaseUrl, {
    Map<String, dynamic>? queryParameters,
    required Map<String, dynamic> headers,
    bool refreshTokenIfNeeded = true,
    ResponseType? responseType,
  }) async {
    final requestName = _requestName;
    _logRequest(requestName, apiBaseUrl, queryParameters, headers);
    var response = await _dio.get(
      apiBaseUrl,
      queryParameters: queryParameters,
      options: Options(headers: headers, responseType: responseType),
    );
    _logResponse(requestName, response);

    if ([401, 403].contains(response.statusCode) && refreshTokenIfNeeded) {
      // response = (await _refreshToken((_) async {
      //   _requestName = requestName!;
      //   return _get(
      //     apiBaseUrl,
      //     queryParameters: queryParameters,
      //     headers: await _updateHeaderWithNewToken(headers),
      //     responseType: responseType,
      //   );
      // }))!;
      showGuestSnackBar(navigatorKey.currentContext!);
    }

    _requestName = null;
    return response;
  }

  @override
  Future<Uint8List> readBytes(String apiBaseUrl) {
    final url = Uri.parse(apiBaseUrl);
    return http.readBytes(url);
  }

  Future<Response> _post(
    String apiBaseUrl, {
    Map<String, dynamic>? queryParameters,
    data,
    required Map<String, dynamic> headers,
    bool refreshTokenIfNeeded = true,
    ResponseType? responseType,
  }) async {
    final requestName = _requestName;
    _logRequest(requestName, apiBaseUrl, queryParameters, headers, data);
    var response = await _dio.post(
      apiBaseUrl,
      queryParameters: queryParameters,
      data: data,
      options: Options(headers: headers, responseType: responseType),
    );
    _logResponse(requestName, response);

    if ([401, 403].contains(response.statusCode) && refreshTokenIfNeeded) {
      // response = (await _refreshToken((_) async {
      //   _requestName = requestName!;
      //   return _post(
      //     apiBaseUrl,
      //     queryParameters: queryParameters,
      //     data: _regenerateDataIfFormData(data),
      //     headers: await _updateHeaderWithNewToken(headers),
      //     responseType: responseType,
      //   );
      // }))!;
      showGuestSnackBar(navigatorKey.currentContext!);
    }

    _requestName = null;
    return response;
  }

  Future<Response> _patch(
    String apiBaseUrl, {
    Map<String, dynamic>? queryParameters,
    data,
    required Map<String, dynamic> headers,
    bool refreshTokenIfNeeded = true,
    ResponseType? responseType,
  }) async {
    final requestName = _requestName;
    _logRequest(requestName, apiBaseUrl, queryParameters, headers, data);
    var response = await _dio.patch(
      apiBaseUrl,
      queryParameters: queryParameters,
      data: data,
      options: Options(headers: headers, responseType: responseType),
    );
    _logResponse(requestName, response);

    if ([401, 403].contains(response.statusCode) && refreshTokenIfNeeded) {
      // response = (await _refreshToken((_) async {
      //   _requestName = requestName!;
      //   return _patch(
      //     apiBaseUrl,
      //     queryParameters: queryParameters,
      //     data: _regenerateDataIfFormData(data),
      //     headers: await _updateHeaderWithNewToken(headers),
      //     responseType: responseType,
      //   );
      // }))!;
      showGuestSnackBar(navigatorKey.currentContext!);
    }

    _requestName = null;
    return response;
  }

  Future<Response> _put(
    String apiBaseUrl, {
    Map<String, dynamic>? queryParameters,
    data,
    required Map<String, dynamic> headers,
    bool refreshTokenIfNeeded = true,
    ResponseType? responseType,
  }) async {
    final requestName = _requestName;
    _logRequest(requestName, apiBaseUrl, queryParameters, headers, data);
    var response = await _dio.put(
      apiBaseUrl,
      queryParameters: queryParameters,
      data: data,
      options: Options(headers: headers, responseType: responseType),
    );
    _logResponse(requestName, response);

    if ([401, 403].contains(response.statusCode) && refreshTokenIfNeeded) {
      // response = (await _refreshToken((_) async {
      //   _requestName = requestName!;
      //   return _put(
      //     apiBaseUrl,
      //     queryParameters: queryParameters,
      //     data: _regenerateDataIfFormData(data),
      //     headers: await _updateHeaderWithNewToken(headers),
      //     responseType: responseType,
      //   );
      // }))!;
      showGuestSnackBar(navigatorKey.currentContext!);
    }

    _requestName = null;
    return response;
  }

  Future<Response> _delete(
    String apiBaseUrl, {
    Map<String, dynamic>? queryParameters,
    data,
    required Map<String, dynamic> headers,
    bool refreshTokenIfNeeded = true,
    ResponseType? responseType,
  }) async {
    final requestName = _requestName;
    _logRequest(requestName, apiBaseUrl, queryParameters, headers, data);
    var response = await _dio.delete(
      apiBaseUrl,
      queryParameters: queryParameters,
      data: data,
      options: Options(headers: headers, responseType: responseType),
    );
    _logResponse(requestName, response);

    if ([401, 403].contains(response.statusCode) && refreshTokenIfNeeded) {
      // response = (await _refreshToken((_) async {
      //   _requestName = requestName!;
      //   return _delete(
      //     apiBaseUrl,
      //     queryParameters: queryParameters,
      //     data: _regenerateDataIfFormData(data),
      //     headers: await _updateHeaderWithNewToken(headers),
      //     responseType: responseType,
      //   );
      // }))!;
      showGuestSnackBar(navigatorKey.currentContext!);
    }

    _requestName = null;
    return response;
  }

  void _logRequest(
    String? requestName,
    String apiBaseUrl,
    Map<String, dynamic>? params,
    Map<String, dynamic> headers, [
    data,
  ]) {
    if (requestName == null) return;

    _logger.debug(CustomPrinter.logRequestPretty(
      header: headers,
      params: params,
      url: apiBaseUrl,
      title: requestName,
    ));
    if (data != null) {
      _logger.debug('[$requestName] body: ${data is FormData ? Map.fromEntries([
              ...data.fields,
              ...data.files
            ]) : data}');
    }
  }

  void _logResponse(String? requestName, Response<dynamic> response) {
    if (requestName == null) return;

    _logger.debug(CustomPrinter.logJsonResponsePretty(title: requestName, response: response));
  }

  Future<Response> _downloadFile(
    String apiBaseUrl,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return _dio.download(
      apiBaseUrl,
      savePath,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  @override
  Future<Map<String, dynamic>> getDefaultHeaders([String? language]) async {
    final accessToken = await _networkServiceUtil.getCurrentAccessToken();
    final languageCode =
        await _networkServiceUtil.getLanguageCode() ?? language ?? 'en';
    final deviceType = _deviceTypeDataSource.getDeviceType();
    final currentCountryId = await _networkServiceUtil.getCurrentCountryId();

    final headers = <String, dynamic>{
      if (accessToken != null) 'Authorization': 'Bearer $accessToken',
      if (currentCountryId != null) 'x-country-id': currentCountryId,
      'x-lang': languageCode,
      'Accept': '*/*',
      'deviceType': deviceType,
    };

    return headers;
  }

// todo
  Future<T> _connectionExceptionCatcher<T>(Future<T> Function() request) async {
    try {
      return await request();
    } catch (e) {
      var message = e.toString();
      if ([
        'SocketException',
        'HttpException',
        'time out',
        'HandshakeException',
        'Failed host lookup'
      ].any((e) => message.contains(e))) {
        throw ConnectionException(message: 'connection_error'.tr());
      }
      rethrow;
    }
  }

  //This is a workaround for saving http request from requesting the refresh access token multiple times at the same time.
  //By making all http requests wait until the first refresh request done.
  //and then resend pending requests with the new access token.
  Future? _alreadyRequestedFuture;

  Future<T?> _refreshToken<T>(Future<T> Function(void) onSuccess) async {
    if (_alreadyRequestedFuture != null) {
      return _alreadyRequestedFuture!
          .then(onSuccess)
          .whenComplete(() => _alreadyRequestedFuture = null);
    }
    const url = ApiEndPoint.REFRESH_TOKEN;
    final headers = (await getDefaultHeaders())..remove('Authorization');
    final body = await createRefreshTokenBody();

    _logRequest('REFRESHTOKEN', url, headers, body);

    final refreshRequest = _dio
        .post(url, data: body, options: Options(headers: headers))
        .then((response) {
      _logResponse('REFRESHTOKEN', response);

      if (!([200, 201].contains(response.statusCode))) {
        return logout().then(
          (_) {
            _alreadyRequestedFuture = null;
            throw RequestException(message: 'session_expired');
          },
        );
      }

      if (response.data['result'] == RequestResult.Failed.name) {
        throw RequestException(message: response.data['msg']);
      }

      if (response.statusCode == 200) {
        return updateCurrentTokens(response.data['data'])
            .then(onSuccess)
            .whenComplete(() => _alreadyRequestedFuture = null);
      }

      throw RequestException(message: response.data);
    });
    _alreadyRequestedFuture = refreshRequest;

    return refreshRequest.then((value) => value);
  }

  Future<void> _navigateToLoginPage() => navigatorKey.currentState!
      .pushNamedAndRemoveUntil(LoginPage.routeName, (route) => false);

  @override
  Future<Map<String, String>> createRefreshTokenBody() async {
    final accessToken = await _networkServiceUtil.getCurrentAccessToken();
    final refreshToken = await _networkServiceUtil.getCurrentRefreshToken();
    return {
      if (accessToken != null) 'accessToken': accessToken,
      if (refreshToken != null) 'refreshToken': refreshToken,
    };
  }

  @override
  Future<void> updateCurrentTokens(Map data) =>
      _networkServiceUtil.updateCurrentTokens(
        accessToken: data['accessToken'],
        refreshToken: data['refreshToken'],
      );

  @override
  Future<void> logout() async {
    await _networkServiceUtil.clearCurrentUserData();
    // _navigateToLoginPage();
  }

  Future<Map<String, dynamic>> _updateHeaderWithNewToken(
      Map<String, dynamic> headers) async {
    final newHeaders = await getDefaultHeaders();
    headers['Authorization'] = newHeaders['Authorization'];
    return headers;
  }

  @override
  Map<String, dynamic>? formatQueryIfNeeded(
    Map<String, dynamic>? queryParameters,
  ) {
    if (queryParameters == null) return null;
    final newQueryParameters = <String, dynamic>{};

    for (final entry in queryParameters.entries) {
      if (entry.value is Map || entry.value is List) {
        final newEntries = _extractNormalEntriesFromMap(entry.key, entry.value);
        newQueryParameters.addEntries(newEntries);
      } else {
        newQueryParameters[entry.key] = entry.value;
      }
    }

    return newQueryParameters;
  }

  List<MapEntry<String, dynamic>> _extractNormalEntriesFromMap(
    String key,
    value,
  ) {
    if (value is! Map && value is! List) return [MapEntry(key, value)];

    final newEntries = <MapEntry<String, dynamic>>[];

    if (value is List)
      for (var i = 0; i < value.length; i++) {
        final item = value[i];
        if (item is! List && item is! Map) {
          newEntries.add(MapEntry('$key[$i]', item));
        } else {
          newEntries.addAll(_extractNormalEntriesFromMap('$key[$i]', item));
        }
      }
    else if (value is Map)
      for (var entry in value.entries) {
        if (entry.value is! Map && entry.value is! List) {
          newEntries.add(MapEntry('$key.${entry.key}', entry.value));
        } else {
          newEntries.addAll(
              _extractNormalEntriesFromMap('$key.${entry.key}', entry.value));
        }
      }

    return newEntries;
  }

  FormData _regenerateDataIfFormData(data) {
    if (data is! FormData) return data;
    final newFormData = FormData();

    newFormData.fields.addAll(data.fields);
    newFormData.files.addAll(data.files);

    return newFormData;
  }
}

abstract class NetworkServiceUtil {
  Future<String?> getCurrentAccessToken();

  Future<int?> getCurrentCountryId();

  Future<String?> getCurrentRefreshToken();

  Future<String?> getLanguageCode();

  Future<void> updateCurrentTokens({
    String? accessToken,
    String? refreshToken,
  });

  Future<void> clearCurrentUserData();
}

///Used only as a helper inside NetworkService to handle tokens and language code.
///DONT: use it outside the NetworkService.
class NetworkServiceUtilImpl implements NetworkServiceUtil {
  NetworkServiceUtilImpl(this._cacheManager);

  final CacheManager _cacheManager;

  @override
  Future<String?> getCurrentAccessToken() async {
    final userJson = await _cacheManager.getUserData();
    if (userJson == null) return null;
    final user = User.fromJson(userJson);
    return user.token;
  }

  @override
  Future<String?> getCurrentRefreshToken() async {
    final userJson = await _cacheManager.getUserData();
    if (userJson == null) return null;
    final user = User.fromJson(userJson);
    return user.refreshToken;
  }

  @override
  Future<String?> getLanguageCode() async {
    final languageString = await _cacheManager.getLanguageCode();
    if (languageString == null) return null;
    final languageCode = languageString.split('_').first;
    return languageCode;
  }

  @override
  Future<void> updateCurrentTokens({
    String? accessToken,
    String? refreshToken,
    String? ticketMXAccessToken,
  }) async {
    final userJson = await _cacheManager.getUserData();
    if (userJson == null) return;
    final user = User.fromJson(userJson);
    final newUser = user.copyWith(
      token: accessToken ?? user.token,
      refreshToken: refreshToken ?? user.refreshToken,
    );
    await _cacheManager.saveUserData(newUser.toJson());
  }

  @override
  Future<void> clearCurrentUserData() => _cacheManager.clearUserData();

  @override
  Future<int?> getCurrentCountryId() async {
    final country = await _cacheManager.getCurrentCountry();
    return country?.id;
  }
}
