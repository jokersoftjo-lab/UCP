/// Capabilities a UCP device can advertise.
enum UcpCapability {
  gamepad('gamepad'),
  keyboard('keyboard'),
  mouse('mouse'),
  touchpad('touchpad'),
  motion('motion'),
  microphone('microphone'),
  camera('camera'),
  vibration('vibration'),
  audio('audio'),
  usb('usb'),
  hid('hid'),
  reading('reading'),
  smartRemote('smart_remote'),
  custom('custom');

  const UcpCapability(this.wireName);

  final String wireName;

  static UcpCapability? fromWireName(String value) {
    for (final capability in values) {
      if (capability.wireName == value) return capability;
    }
    return null;
  }

  @override
  String toString() => wireName;
}
