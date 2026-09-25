import '../protocol/ucp_message_type.dart';

class UcpHandshakeMessage {
  final UcpMessageType type;
  final String protocolVersion;
  final String deviceId;

  const UcpHandshakeMessage({
    required this.type,
    required this.protocolVersion,
    required this.deviceId,
  });

  Map<String, Object?> toJson() => {
        'type': type.wireName,
        'protocolVersion': protocolVersion,
        'deviceId': deviceId,
      };
}
