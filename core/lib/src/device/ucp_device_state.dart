/// Runtime state of a UCP device.
enum UcpDeviceState {
  online('online'),
  offline('offline'),
  busy('busy'),
  available('available'),
  paired('paired'),
  connected('connected'),
  locked('locked');

  const UcpDeviceState(this.wireName);
  final String wireName;

  static UcpDeviceState? fromWireName(String value) {
    for (final state in values) {
      if (state.wireName == value) return state;
    }
    return null;
  }

  @override
  String toString() => wireName;
}
