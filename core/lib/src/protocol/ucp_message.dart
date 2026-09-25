import '../device/ucp_device.dart';
import 'ucp_flags.dart';

/// Universal UCP/1.0 message envelope.
class UcpMessage {
  final String version;
  final String messageId;
  final String type;
  final String sourceId;
  final String? destinationId;
  final String? sessionId;
  final int timestampMs;
  final int sequence;
  final int flags;
  final Map<String, Object?> payload;

  const UcpMessage({
    this.version = '1.0',
    required this.messageId,
    required this.type,
    required this.sourceId,
    this.destinationId,
    this.sessionId,
    required this.timestampMs,
    this.sequence = 0,
    this.flags = 0,
    this.payload = const {},
  });

  bool hasFlag(UcpMessageFlag flag) => UcpFlags.has(flags, flag);

  Map<String, Object?> toJson() => {
        'version': version,
        'messageId': messageId,
        'type': type,
        'source': sourceId,
        if (destinationId != null) 'destination': destinationId,
        if (sessionId != null) 'session': sessionId,
        'timestampMs': timestampMs,
        'sequence': sequence,
        if (flags != 0) 'flags': flags,
        'payload': payload,
      };

  factory UcpMessage.fromJson(Map<String, Object?> json) {
    String requiredString(String key) {
      final value = json[key];
      if (value is! String || value.isEmpty) {
        throw FormatException('Missing or invalid UCP field: $key');
      }
      return value;
    }

    int requiredInt(String key) {
      final value = json[key];
      if (value is! int) {
        throw FormatException('Missing or invalid UCP field: $key');
      }
      return value;
    }

    final payload = json['payload'];
    if (payload != null && payload is! Map) {
      throw const FormatException('UCP payload must be an object.');
    }

    return UcpMessage(
      version: (json['version'] as String?) ?? '1.0',
      messageId: requiredString('messageId'),
      type: requiredString('type'),
      sourceId: requiredString('source'),
      destinationId: json['destination'] as String?,
      sessionId: json['session'] as String?,
      timestampMs: requiredInt('timestampMs'),
      sequence: (json['sequence'] as int?) ?? 0,
      flags: (json['flags'] as int?) ?? 0,
      payload: payload == null
          ? const <String, Object?>{}
          : Map<String, Object?>.from(payload as Map),
    );
  }

  /// Prevents an unused device import from leaking into the public API while
  /// keeping this file intentionally independent from platform implementations.
  static String deviceId(UcpDevice device) => device.id;
}
