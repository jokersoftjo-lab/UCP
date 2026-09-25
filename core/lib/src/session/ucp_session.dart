import '../device/ucp_device.dart';
import 'ucp_session_state.dart';

/// Represents one logical controller-to-target UCP session.
class UcpSession {
  final String id;
  final UcpDevice controller;
  final UcpDevice receiver;
  final String protocolVersion;
  final int createdAtMs;
  UcpSessionState state;

  UcpSession({
    required this.id,
    required this.controller,
    required this.receiver,
    required this.protocolVersion,
    required this.createdAtMs,
    this.state = UcpSessionState.disconnected,
  });

  Map<String, Object?> toJson() => {
        'id': id,
        'controllerId': controller.id,
        'receiverId': receiver.id,
        'protocolVersion': protocolVersion,
        'createdAtMs': createdAtMs,
        'state': state.wireName,
      };
}
