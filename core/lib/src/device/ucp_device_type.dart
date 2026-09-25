/// Roles/types a UCP participant may expose.
enum UcpDeviceType {
  controller('controller'),
  receiver('receiver'),
  bridge('bridge'),
  game('game'),
  application('application'),
  tv('tv'),
  computer('computer'),
  phone('phone'),
  tablet('tablet'),
  hardware('hardware'),
  reader('reader'),
  custom('custom');

  const UcpDeviceType(this.wireName);
  final String wireName;

  static UcpDeviceType? fromWireName(String value) {
    for (final type in values) {
      if (type.wireName == value) return type;
    }
    return null;
  }

  @override
  String toString() => wireName;
}
