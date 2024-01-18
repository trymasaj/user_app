import 'package:masaj/core/domain/exceptions/app_exception.dart';

class ConnectionException extends AppException {
  ConnectionException({super.message, super.stackTrace, super.exception});
}
