/// State of a UCP transport channel.
enum UcpTransportState {
  disconnected('disconnected'),
  connecting('connecting'),
  connected('connected'),
  closing('closing'),
  error('error');

  const UcpTransportState(this.wireName);
  final String wireName;

  static UcpTransportState? fromWireName(String value) {
    for (final state in values) {
      if (state.wireName == value) return state;
    }
    return null;
  }

  @override
  String toString() => wireName;
}
