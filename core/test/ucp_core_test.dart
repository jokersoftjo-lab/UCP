import 'package:flutter_test/flutter_test.dart';
import 'package:ucp_core/core.dart';

void main() {
  group('UCP Protocol v1.0', () {
    test('reports protocol version and compatibility', () {
      expect(UcpProtocol.version, '1.0');
      expect(UcpProtocol.wirePrefix, 'UCP/1.0');
      expect(UcpProtocol.isCompatible('1.0'), isTrue);
      expect(UcpProtocol.isCompatible('1.1'), isFalse);
      expect(UcpProtocol.isCompatible('2.0'), isFalse);
    });

    test('serializes and restores a message envelope', () {
      const message = UcpMessage(
        messageId: 'msg-001',
        type: 'input.event',
        sourceId: 'phone-001',
        destinationId: 'windows-001',
        sessionId: 'session-001',
        timestampMs: 1000,
        sequence: 7,
        flags: 3,
        payload: {
          'inputType': 'button',
          'control': 'A',
          'pressed': true,
        },
      );

      final restored = UcpMessage.fromJson(message.toJson());

      expect(restored.version, '1.0');
      expect(restored.messageId, 'msg-001');
      expect(restored.type, 'input.event');
      expect(restored.sourceId, 'phone-001');
      expect(restored.destinationId, 'windows-001');
      expect(restored.sessionId, 'session-001');
      expect(restored.sequence, 7);
      expect(restored.hasFlag(UcpMessageFlag.reliable), isTrue);
      expect(restored.hasFlag(UcpMessageFlag.ordered), isTrue);
      expect(restored.payload['control'], 'A');
    });

    test('rejects malformed messages', () {
      expect(
        () => UcpMessage.fromJson({
          'messageId': 'x',
          'type': 'input.event',
          'timestampMs': 'not-an-int',
          'source': 'phone',
        }),
        throwsFormatException,
      );
    });

    test('creates a device with protocol capabilities', () {
      final device = UcpDevice(
        id: 'phone-001',
        name: 'UCP Phone',
        type: UcpDeviceType.phone,
        platform: 'android',
        osVersion: '5.1',
        capabilities: const [
          UcpCapability.gamepad,
          UcpCapability.motion,
        ],
        connectionTypes: const ['wifi'],
      );

      final json = device.toJson();

      expect(json['id'], 'phone-001');
      expect(json['type'], 'phone');
      expect(json['platform'], 'android');
      expect(json['osVersion'], '5.1');
      expect(json['capabilities'], ['gamepad', 'motion']);
      expect(json['connectionTypes'], ['wifi']);
    });

    test('manages sessions and rejects duplicate session ids', () {
      final controller = UcpDevice(
        id: 'phone-001',
        name: 'Phone',
        type: UcpDeviceType.phone,
        platform: 'android',
      );
      final receiver = UcpDevice(
        id: 'windows-001',
        name: 'Windows Receiver',
        type: UcpDeviceType.receiver,
        platform: 'windows',
      );

      final session = UcpSession(
        id: 'session-001',
        controller: controller,
        receiver: receiver,
        protocolVersion: UcpProtocol.version,
        createdAtMs: 1000,
      );

      final manager = UcpSessionManager();
      manager.add(session);
      manager.transition('session-001', UcpSessionState.connected);

      expect(manager.require('session-001').state, UcpSessionState.connected);
      expect(
        () => manager.add(session),
        throwsA(isA<UcpError>()),
      );
    });

    test('encodes protocol flags', () {
      final flags = UcpFlags.encode([
        UcpMessageFlag.reliable,
        UcpMessageFlag.ordered,
      ]);

      expect(UcpFlags.has(flags, UcpMessageFlag.reliable), isTrue);
      expect(UcpFlags.has(flags, UcpMessageFlag.ordered), isTrue);
      expect(UcpFlags.has(flags, UcpMessageFlag.priority), isFalse);
    });
  });
}
