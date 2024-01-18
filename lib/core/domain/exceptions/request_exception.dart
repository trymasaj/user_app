import 'package:masaj/core/domain/exceptions/app_exception.dart';

class RequestException extends AppException {
  RequestException({super.message, super.stackTrace, super.exception});
}
