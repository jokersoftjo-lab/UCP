import '../errors/ucp_error.dart';

class UcpErrorMessage {
  final UcpError error;

  const UcpErrorMessage(this.error);

  Map<String, Object?> toJson() => {
        'type': 'error',
        'error': error.toJson(),
      };
}
