import 'ucp_capability.dart';

/// Describes a device participating in a UCP session.
class UcpDevice {
  final String id;
  final String name;
  final String platform;
  final List<UcpCapability> capabilities;

  const UcpDevice({
    required this.id,
    required this.name,
    required this.platform,
    this.capabilities = const [],
  });
}
