import '../device/ucp_device.dart';
import '../protocol/ucp_message_type.dart';

class UcpDiscoveryMessage {
  final UcpMessageType type;
  final UcpDevice device;

  const UcpDiscoveryMessage({
    required this.type,
    required this.device,
  });

  Map<String, Object?> toJson() => {
        'type': type.wireName,
        'device': {
          'id': device.id,
          'name': device.name,
          'platform': device.platform,
        },
      };
}
