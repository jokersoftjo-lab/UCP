/// Standard UCP message types for Protocol v1.0.
enum UcpMessageType {
  hello('system.hello'),
  helloAck('system.hello_ack'),
  capabilities('device.capabilities'),
  capabilitiesAck('device.capabilities_ack'),
  sessionRequest('session.request'),
  sessionAccept('session.accept'),
  sessionReject('session.reject'),
  sessionClose('session.close'),
  ping('system.ping'),
  pong('system.pong'),
  discoveryAdvertise('discovery.advertise'),
  discoveryRequest('discovery.request'),
  input('input.event'),
  feedback('feedback.event'),
  state('state.update'),
  config('config.update'),
  profile('profile.update'),
  reading('reading.command'),
  remote('remote.command'),
  usb('usb.event'),
  error('error');

  const UcpMessageType(this.wireName);
  final String wireName;

  static UcpMessageType? fromWireName(String value) {
    for (final type in values) {
      if (type.wireName == value) return type;
    }
    return null;
  }

  @override
  String toString() => wireName;
}
