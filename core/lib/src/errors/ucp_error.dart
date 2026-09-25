/// Stable UCP protocol error codes.
enum UcpErrorCode {
  protocolVersion('UCP_ERR_PROTOCOL_VERSION'),
  invalidMessage('UCP_ERR_INVALID_MESSAGE'),
  authFailed('UCP_ERR_AUTH_FAILED'),
  sessionNotFound('UCP_ERR_SESSION_NOT_FOUND'),
  capabilityNotSupported('UCP_ERR_CAPABILITY_NOT_SUPPORTED'),
  permissionDenied('UCP_ERR_PERMISSION_DENIED'),
  deviceNotFound('UCP_ERR_DEVICE_NOT_FOUND'),
  transport('UCP_ERR_TRANSPORT'),
  timeout('UCP_ERR_TIMEOUT');

  const UcpErrorCode(this.wireName);
  final String wireName;

  static UcpErrorCode? fromWireName(String value) {
    for (final code in values) {
      if (code.wireName == value) return code;
    }
    return null;
  }

  @override
  String toString() => wireName;
}

class UcpError implements Exception {
  final UcpErrorCode code;
  final String message;
  final Map<String, Object?> details;

  const UcpError({
    required this.code,
    required this.message,
    this.details = const {},
  });

  Map<String, Object?> toJson() => {
        'code': code.wireName,
        'message': message,
        if (details.isNotEmpty) 'details': details,
      };

  factory UcpError.fromJson(Map<String, Object?> json) {
    final codeName = json['code'];
    final message = json['message'];
    if (codeName is! String || message is! String) {
      throw const FormatException('Invalid UCP error object.');
    }
    final code = UcpErrorCode.fromWireName(codeName);
    if (code == null) {
      throw FormatException('Unknown UCP error code: $codeName');
    }
    final details = json['details'];
    return UcpError(
      code: code,
      message: message,
      details: details is Map
          ? Map<String, Object?>.from(details)
          : const <String, Object?>{},
    );
  }

  @override
  String toString() => '$code: $message';
}
