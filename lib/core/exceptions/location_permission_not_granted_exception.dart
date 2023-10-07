
class LocationPermissionNotGrantedException implements Exception {
  final String _message;

  LocationPermissionNotGrantedException([message])
      : _message = (message ??= 'location_permission_not_granted') is String
            ? message
            : message is List
                ? message.join(',\n')
                : message.toString();

  @override
  String toString() => _message;
}
