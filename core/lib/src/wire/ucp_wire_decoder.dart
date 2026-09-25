import 'dart:convert';

import '../protocol/ucp_message.dart';
import '../protocol/ucp_protocol.dart';

/// Decodes UTF-8 JSON bytes into a validated UCP message.
class UcpWireDecoder {
  const UcpWireDecoder();

  UcpMessage decode(List<int> data) {
    try {
      return decodeString(utf8.decode(data, allowMalformed: false));
    } on FormatException {
      rethrow;
    } on Object catch (error) {
      throw FormatException('Invalid UCP wire data: $error');
    }
  }

  UcpMessage decodeString(String data) {
    if (data.isEmpty) throw const FormatException('UCP wire data must not be empty.');

    dynamic decoded;
    try {
      decoded = jsonDecode(data);
    } on FormatException {
      rethrow;
    } on Object catch (error) {
      throw FormatException('Invalid UCP JSON: $error');
    }

    if (decoded is! Map) {
      throw const FormatException('UCP wire message must be a JSON object.');
    }

    final json = Map<String, Object?>.from(decoded as Map);
    _validateEnvelope(json);
    return UcpMessage.fromJson(json);
  }

  void _validateEnvelope(Map<String, Object?> json) {
    final version = json['version'];
    if (version is! String || version.isEmpty) {
      throw const FormatException('Missing or invalid UCP version.');
    }
    if (!UcpProtocol.isCompatible(version)) {
      throw FormatException('Unsupported UCP protocol version: $version.');
    }

    _requiredString(json, 'messageId');
    _requiredString(json, 'type');
    _requiredString(json, 'source');
    _optionalNonEmptyString(json, 'destination');
    _optionalNonEmptyString(json, 'session');
    _requiredNonNegativeInt(json, 'timestampMs');
    _optionalNonNegativeInt(json, 'sequence');
    _optionalNonNegativeInt(json, 'flags');

    final payload = json['payload'];
    if (payload != null && payload is! Map) {
      throw const FormatException('UCP payload must be a JSON object.');
    }
  }

  void _requiredString(Map<String, Object?> json, String key) {
    final value = json[key];
    if (value is! String || value.isEmpty) throw FormatException('Missing or invalid UCP field: $key');
  }

  void _optionalNonEmptyString(Map<String, Object?> json, String key) {
    if (!json.containsKey(key)) return;
    final value = json[key];
    if (value is! String || value.isEmpty) throw FormatException('Invalid UCP field: $key');
  }

  void _requiredNonNegativeInt(Map<String, Object?> json, String key) {
    final value = json[key];
    if (value is! int || value < 0) throw FormatException('Missing or invalid UCP field: $key');
  }

  void _optionalNonNegativeInt(Map<String, Object?> json, String key) {
    if (!json.containsKey(key)) return;
    final value = json[key];
    if (value is! int || value < 0) throw FormatException('Invalid UCP field: $key');
  }
}
