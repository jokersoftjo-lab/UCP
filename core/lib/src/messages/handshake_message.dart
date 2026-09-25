import '../protocol/ucp_message_type.dart';

/// Supported UCP handshake stages.
enum UcpHandshakeStage {
  hello('hello'),
  helloAck('hello_ack'),
  capabilities('capabilities'),
  capabilitiesAck('capabilities_ack'),
  sessionRequest('session_request'),
  sessionAccept('session_accept'),
  sessionReject('session_reject');

  const UcpHandshakeStage(this.wireName);
  final String wireName;

  static UcpHandshakeStage? fromWireName(String value) {
    for (final stage in values) {
      if (stage.wireName == value) return stage;
    }
    return null;
  }
}

/// Handshake payload exchanged while establishing a UCP session.
class UcpHandshakeMessage {
  final UcpHandshakeStage stage;
  final String protocolVersion;
  final String deviceId;
  final UcpMessageType messageType;
  final String? sessionId;
  final String? reason;

  const UcpHandshakeMessage({
    required this.stage,
    required this.protocolVersion,
    required this.deviceId,
    required this.messageType,
    this.sessionId,
    this.reason,
  });

  Map<String, Object?> toJson() => {
        'stage': stage.wireName,
        'protocolVersion': protocolVersion,
        'deviceId': deviceId,
        'type': messageType.wireName,
        if (sessionId != null) 'sessionId': sessionId,
        if (reason != null) 'reason': reason,
      };

  factory UcpHandshakeMessage.fromJson(Map<String, Object?> json) {
    final stageName = json['stage'];
    final version = json['protocolVersion'];
    final deviceId = json['deviceId'];
    final typeName = json['type'];

    if (stageName is! String ||
        version is! String ||
        deviceId is! String ||
        typeName is! String) {
      throw const FormatException('Invalid UCP handshake message.');
    }

    final stage = UcpHandshakeStage.fromWireName(stageName);
    final type = UcpMessageType.fromWireName(typeName);
    if (stage == null || type == null) {
      throw const FormatException('Unknown UCP handshake stage or message type.');
    }

    return UcpHandshakeMessage(
      stage: stage,
      protocolVersion: version,
      deviceId: deviceId,
      messageType: type,
      sessionId: json['sessionId'] as String?,
      reason: json['reason'] as String?,
    );
  }
}
