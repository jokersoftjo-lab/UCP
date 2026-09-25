import '../device/ucp_device.dart';
import '../protocol/ucp_protocol.dart';
import 'ucp_session_state.dart';

/// Represents one logical controller-to-receiver UCP session.
class UcpSession {
  final String id;
  final UcpDevice controller;
  final UcpDevice receiver;
  final String protocolVersion;
  final int createdAtMs;
  UcpSessionState state;
  int lastSequence;
  int lastActivityMs;

  UcpSession({
    required this.id,
    required this.controller,
    required this.receiver,
    this.protocolVersion = UcpProtocol.version,
    required this.createdAtMs,
    this.state = UcpSessionState.disconnected,
    this.lastSequence = 0,
    int? lastActivityMs,
  }) : lastActivityMs = lastActivityMs ?? createdAtMs;

  Map<String, Object?> toJson() => {
        'id': id,
        'controllerId': controller.id,
        'receiverId': receiver.id,
        'protocolVersion': protocolVersion,
        'createdAtMs': createdAtMs,
        'state': state.wireName,
        'lastSequence': lastSequence,
        'lastActivityMs': lastActivityMs,
      };
}
