import 'dart:convert';

import '../protocol/ucp_message.dart';

/// Encodes a UCP message as UTF-8 JSON bytes.
class UcpWireEncoder {
  const UcpWireEncoder();

  List<int> encode(UcpMessage message) {
    _validate(message);
    return utf8.encode(jsonEncode(message.toJson()));
  }

  String encodeString(UcpMessage message) {
    _validate(message);
    return jsonEncode(message.toJson());
  }

  void _validate(UcpMessage message) {
    if (message.version.isEmpty) throw const FormatException('UCP version must not be empty.');
    if (message.messageId.isEmpty) throw const FormatException('UCP messageId must not be empty.');
    if (message.type.isEmpty) throw const FormatException('UCP type must not be empty.');
    if (message.sourceId.isEmpty) throw const FormatException('UCP source must not be empty.');
    if (message.destinationId == '') throw const FormatException('UCP destination must not be empty.');
    if (message.sessionId == '') throw const FormatException('UCP session must not be empty.');
    if (message.timestampMs < 0) throw const FormatException('UCP timestampMs must be >= 0.');
    if (message.sequence < 0) throw const FormatException('UCP sequence must be >= 0.');
    if (message.flags < 0) throw const FormatException('UCP flags must be >= 0.');
  }
}
