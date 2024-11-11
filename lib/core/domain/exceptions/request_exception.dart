import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/domain/exceptions/app_exception.dart';

class RequestException extends AppException {
  RequestException({super.message, super.stackTrace, super.exception});

  factory RequestException.fromStatusCode({
    required int statusCode,
    dynamic response,
  }) {
    // Construct a detailed error message
    String message = _parseErrorMessage(response) ?? AppText.error_occurred;

    // Map status codes to specific exceptions
    switch (statusCode) {
      case 400:
        return BadRequestException(message: message);
      case 401:
        return UnAuthorizedException(message: message);
      case 403:
        return ForbiddenException(message: message);
      case 404:
        return NotFoundException(message: message);
      case 500:
        return InternalServerErrorException(message: message);
      case 503:
        return ServiceUnavailableException(message: message);
      default:
        return UnknownException(message: message);
    }
  }

  @override
  String toString() {
    return message;
  }

  // Private method to parse error message from the response
  static String? _parseErrorMessage(dynamic response) {
    if (response is Map<String, dynamic>) {
      String message =
          response['detail'] ?? 'An error occurred, please try again later.';
      message = _parseFieldErrors(response['errors']) ?? message;
      return message;
    } else if (response is String) {
      return response;
    }
    return null;
  }

  // Private method to parse field-specific errors and format them
  static String? _parseFieldErrors(dynamic errors) {
    if (errors is Map<String, dynamic> && errors.isNotEmpty) {
      return errors.values.firstOrNull;
    }
    //if list and not empty return first error
    if (errors is List && errors.isNotEmpty) {
      return errors.firstOrNull;
    }
    if (errors is String?) {
      return errors;
    }
    return null;
  }
}

class NotFoundException extends RequestException {
  NotFoundException({String? message, super.stackTrace, super.exception})
      : super(message: message ?? 'not found, please try again later.');
}

class BadRequestException extends RequestException {
  BadRequestException({String? message, super.stackTrace, super.exception})
      : super(
            message: message ??
                'bad request, please check your request and try again.');
}

class UnAuthorizedException extends RequestException {
  UnAuthorizedException({String? message, super.stackTrace, super.exception})
      : super(message: message ?? 'unauthorized, please login and try again.');
}

class ForbiddenException extends RequestException {
  ForbiddenException({String? message, super.stackTrace, super.exception})
      : super(message: message ?? 'forbidden, please login and try again.');
}

class InternalServerErrorException extends RequestException {
  InternalServerErrorException(
      {String? message, super.stackTrace, super.exception})
      : super(
            message:
                message ?? 'internal server error, please try again later.');
}

class ServiceUnavailableException extends RequestException {
  ServiceUnavailableException(
      {super.message, super.stackTrace, super.exception});
}

class UnknownException extends RequestException {
  UnknownException({String? message, super.stackTrace, super.exception})
      : super(message: message ?? 'unknown error, please try again later.');
}

class NoInternetException extends RequestException {
  NoInternetException({super.message, super.stackTrace, super.exception});
}

class SocialLoginCanceledException extends RequestException {
  SocialLoginCanceledException(
      {super.message, super.stackTrace, super.exception});
}

class InvalidInputException extends RequestException {
  InvalidInputException({super.message, super.stackTrace, super.exception});
}

class InvalidTokenException extends RequestException {
  InvalidTokenException({super.message, super.stackTrace, super.exception});
}

class InvalidCredentialsException extends RequestException {
  InvalidCredentialsException(
      {super.message, super.stackTrace, super.exception});
}
