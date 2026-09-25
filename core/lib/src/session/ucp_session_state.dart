/// Lifecycle states for a UCP session.
enum UcpSessionState {
  disconnected('disconnected'),
  discovering('discovering'),
  connecting('connecting'),
  authenticating('authenticating'),
  negotiating('negotiating'),
  connected('connected'),
  paused('paused'),
  closing('closing'),
  closed('closed'),
  error('error');

  const UcpSessionState(this.wireName);
  final String wireName;

  static UcpSessionState? fromWireName(String value) {
    for (final state in values) {
      if (state.wireName == value) return state;
    }
    return null;
  }

  @override
  String toString() => wireName;
}
