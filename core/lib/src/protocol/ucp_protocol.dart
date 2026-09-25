/// UCP Core Protocol version 1.0.
class UcpProtocol {
  static const int major = 1;
  static const int minor = 0;
  static const String version = '$major.$minor';
  static const String wirePrefix = 'UCP/$version';

  /// A 1.x peer is compatible with another 1.x peer at the protocol level.
  static bool isCompatible(String remoteVersion) {
    final parts = remoteVersion.split('.');
    if (parts.length != 2) return false;
    final remoteMajor = int.tryParse(parts[0]);
    final remoteMinor = int.tryParse(parts[1]);
    if (remoteMajor == null || remoteMinor == null) return false;
    return remoteMajor == major && remoteMinor <= minor;
  }

  const UcpProtocol._();
}
