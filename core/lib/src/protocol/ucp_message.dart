import '../device/ucp_device.dart';

/// Base message exchanged by UCP peers.
class UcpMessage {
  final String type;
  final int timestampMs;
  final UcpDevice source;
  final Map<String, Object?> payload;

  const UcpMessage({
    required this.type,
    required this.timestampMs,
    required this.source,
    this.payload = const {},
  });
}
