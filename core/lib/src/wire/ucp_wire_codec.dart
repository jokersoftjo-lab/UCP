import 'dart:typed_data';

import '../protocol/ucp_message.dart';
import 'ucp_wire_decoder.dart';
import 'ucp_wire_encoder.dart';

/// JSON wire codec plus length-prefixed framing for byte-stream transports.
///
/// Frame format:
/// [4-byte unsigned big-endian payload length][UTF-8 JSON payload]
class UcpWireCodec {
  static const int frameHeaderSize = 4;
  static const int defaultMaxFrameSize = 1024 * 1024;

  final UcpWireEncoder encoder;
  final UcpWireDecoder decoder;
  final int maxFrameSize;

  const UcpWireCodec({
    this.encoder = const UcpWireEncoder(),
    this.decoder = const UcpWireDecoder(),
    this.maxFrameSize = defaultMaxFrameSize,
  }) : assert(maxFrameSize > 0);

  List<int> encode(UcpMessage message) => encoder.encode(message);

  UcpMessage decode(List<int> data) => decoder.decode(data);

  List<int> frame(UcpMessage message) => framePayload(encode(message));

  List<int> framePayload(List<int> payload) {
    _validatePayloadLength(payload.length);

    final bytes = Uint8List(frameHeaderSize + payload.length);
    final length = payload.length;
    bytes[0] = (length >> 24) & 0xff;
    bytes[1] = (length >> 16) & 0xff;
    bytes[2] = (length >> 8) & 0xff;
    bytes[3] = length & 0xff;
    bytes.setRange(frameHeaderSize, bytes.length, payload);
    return bytes;
  }

  UcpMessage decodeFrame(List<int> frameData) =>
      decoder.decode(extractPayload(frameData));

  List<int> extractPayload(List<int> frameData) {
    if (frameData.length < frameHeaderSize) {
      throw const FormatException('UCP frame header is incomplete.');
    }

    final length = (frameData[0] << 24) |
        (frameData[1] << 16) |
        (frameData[2] << 8) |
        frameData[3];

    _validatePayloadLength(length);

    final expectedLength = frameHeaderSize + length;
    if (frameData.length != expectedLength) {
      throw FormatException(
        'UCP frame length mismatch: expected ' + expectedLength.toString() +
        ' bytes, received ' + frameData.length.toString() + '.',
      );
    }

    return frameData.sublist(frameHeaderSize);
  }

  void _validatePayloadLength(int length) {
    if (length <= 0) {
      throw const FormatException('UCP frame payload must not be empty.');
    }
    if (length > maxFrameSize) {
      throw FormatException(
        'UCP frame payload exceeds maximum size of ' +
        maxFrameSize.toString() + ' bytes.',
      );
    }
  }
}
