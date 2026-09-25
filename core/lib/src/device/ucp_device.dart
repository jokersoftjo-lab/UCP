import 'ucp_capability.dart';
import 'ucp_device_state.dart';
import 'ucp_device_type.dart';

/// Describes a device participating in UCP.
class UcpDevice {
  final String id;
  final String name;
  final UcpDeviceType type;
  final String platform;
  final String? osVersion;
  final String ucpVersion;
  final List<UcpCapability> capabilities;
  final List<String> connectionTypes;
  UcpDeviceState state;

  UcpDevice({
    required this.id,
    required this.name,
    required this.type,
    required this.platform,
    this.osVersion,
    this.ucpVersion = '1.0',
    this.capabilities = const [],
    this.connectionTypes = const [],
    this.state = UcpDeviceState.online,
  });

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'type': type.wireName,
        'platform': platform,
        if (osVersion != null) 'osVersion': osVersion,
        'ucpVersion': ucpVersion,
        'capabilities': capabilities.map((e) => e.wireName).toList(),
        'connectionTypes': connectionTypes,
        'state': state.wireName,
      };
}
