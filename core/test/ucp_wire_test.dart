import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ucp_core/core.dart';

void main() {
  group('UCP Wire v1.0', () {
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
        'values': {'pressure': 0.5},
      },
    );

    test('encodes message as UTF-8 JSON', () {
      const encoder = UcpWireEncoder();
      final bytes = encoder.encode(message);
      final json = jsonDecode(utf8.decode(bytes));

      expect(json['version'], '1.0');
      expect(json['messageId'], 'msg-001');
      expect(json['type'], 'input.event');
      expect(json['source'], 'phone-001');
      expect(json['sequence'], 7);
      expect(json['flags'], 3);
      expect(json['payload']['values']['pressure'], 0.5);
    });

    test('round-trips a message through encoder and decoder', () {
      const encoder = UcpWireEncoder();
      const decoder = UcpWireDecoder();
      final restored = decoder.decode(encoder.encode(message));
      expect(restored.toJson(), message.toJson());
    });

    test('rejects invalid UTF-8 and non-object JSON', () {
      const decoder = UcpWireDecoder();

      expect(() => decoder.decode([0xff, 0xfe]), throwsFormatException);
      expect(() => decoder.decodeString('[1, 2, 3]'), throwsFormatException);
    });

    test('rejects incompatible versions and negative values', () {
      const decoder = UcpWireDecoder();

      expect(
        () => decoder.decodeString('{"version":"2.0","messageId":"x",'
            '"type":"input.event","source":"phone","timestampMs":1}'),
        throwsFormatException,
      );
      expect(
        () => decoder.decodeString('{"version":"1.0","messageId":"x",'
            '"type":"input.event","source":"phone","timestampMs":-1}'),
        throwsFormatException,
      );
      expect(
        () => decoder.decodeString('{"version":"1.0","messageId":"x",'
            '"type":"input.event","source":"phone","timestampMs":1,'
            '"sequence":-1}'),
        throwsFormatException,
      );
    });

    test('allows extension message types', () {
      const message = UcpMessage(
        messageId: 'ext-001',
        type: 'extension.jokersoft.game_special',
        sourceId: 'phone-001',
        timestampMs: 10,
      );
      const codec = UcpWireCodec();
      expect(codec.decode(codec.encode(message)).type,
          'extension.jokersoft.game_special');
    });

    test('frames and restores a message for stream transport', () {
      const codec = UcpWireCodec();
      final frame = codec.frame(message);
      expect(frame.length, greaterThan(UcpWireCodec.frameHeaderSize));
      expect(codec.decodeFrame(frame).toJson(), message.toJson());

      final payloadLength = frame.length - UcpWireCodec.frameHeaderSize;
      expect(frame.sublist(0, 4), <int>[
        (payloadLength >> 24) & 0xff,
        (payloadLength >> 16) & 0xff,
        (payloadLength >> 8) & 0xff,
        payloadLength & 0xff,
      ]);
    });

    test('rejects incomplete, mismatched and oversized frames', () {
      const codec = UcpWireCodec();
      final frame = codec.frame(message);

      expect(() => codec.decodeFrame(frame.sublist(0, 3)),
          throwsFormatException);
      expect(() => codec.decodeFrame(frame.sublist(0, frame.length - 1)),
          throwsFormatException);
      expect(
        () => UcpWireCodec(maxFrameSize: 16)
            .framePayload(List<int>.filled(17, 0)),
        throwsFormatException,
      );
    });

    test('rejects invalid outgoing messages', () {
      const encoder = UcpWireEncoder();

      expect(
        () => encoder.encode(const UcpMessage(
          messageId: '',
          type: 'input.event',
          sourceId: 'phone',
          timestampMs: 1,
        )),
        throwsFormatException,
      );
      expect(
        () => encoder.encode(const UcpMessage(
          messageId: 'x',
          type: 'input.event',
          sourceId: 'phone',
          timestampMs: -1,
        )),
        throwsFormatException,
      );
    });
  });
}
