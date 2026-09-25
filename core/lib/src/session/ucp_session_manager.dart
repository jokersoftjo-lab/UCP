import '../errors/ucp_error.dart';
import 'ucp_session.dart';
import 'ucp_session_state.dart';

/// In-memory registry and lifecycle coordinator for UCP sessions.
class UcpSessionManager {
  final Map<String, UcpSession> _sessions = {};

  Iterable<UcpSession> get sessions => _sessions.values;

  UcpSession? find(String sessionId) => _sessions[sessionId];

  void add(UcpSession session) {
    if (_sessions.containsKey(session.id)) {
      throw UcpError(
        code: UcpErrorCode.invalidMessage,
        message: 'Session already exists',
      );
    }
    _sessions[session.id] = session;
  }

  UcpSession require(String sessionId) {
    final session = find(sessionId);
    if (session == null) {
      throw UcpError(
        code: UcpErrorCode.sessionNotFound,
        message: 'Session not found',
      );
    }
    return session;
  }

  void transition(String sessionId, UcpSessionState state) {
    final session = require(sessionId);
    session.state = state;
  }

  void touch(String sessionId, int timestampMs, {int? sequence}) {
    final session = require(sessionId);
    if (timestampMs < session.lastActivityMs) {
      throw UcpError(
        code: UcpErrorCode.invalidMessage,
        message: 'Session activity timestamp moved backwards',
      );
    }
    session.lastActivityMs = timestampMs;
    if (sequence != null) {
      if (sequence < session.lastSequence) {
        throw UcpError(
          code: UcpErrorCode.invalidMessage,
          message: 'Session sequence moved backwards',
        );
      }
      session.lastSequence = sequence;
    }
  }

  UcpSession? remove(String sessionId) => _sessions.remove(sessionId);

  void clear() => _sessions.clear();
}
