/// Message delivery and ordering flags.
enum UcpMessageFlag {
  reliable(1 << 0),
  ordered(1 << 1),
  acknowledged(1 << 2),
  priority(1 << 3);

  const UcpMessageFlag(this.bit);
  final int bit;
}

class UcpFlags {
  const UcpFlags._();

  static int encode(Iterable<UcpMessageFlag> flags) {
    var value = 0;
    for (final flag in flags) {
      value |= flag.bit;
    }
    return value;
  }

  static bool has(int value, UcpMessageFlag flag) =>
      (value & flag.bit) == flag.bit;
}
