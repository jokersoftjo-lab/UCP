import '../errors/ucp_error.dart';
import 'ucp_session.dart';
import 'ucp_session_state.dart';

/// In-memory session registry for the protocol core.
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
    require(sessionId).state = state;
  }

  UcpSession? remove(String sessionId) => _sessions.remove(sessionId);
  void clear() => _sessions.clear();
}
