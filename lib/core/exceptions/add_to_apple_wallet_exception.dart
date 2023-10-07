class AddToAppleWalletException implements Exception {
  final String _message;

  AddToAppleWalletException([message])
      : _message = (message ??= 'failed_to_add_to_wallet') is String
            ? message
            : message is List
                ? message.join(',\n')
                : message.toString();

  @override
  String toString() => _message;
}
