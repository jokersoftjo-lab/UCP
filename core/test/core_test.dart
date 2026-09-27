import 'package:flutter_test/flutter_test.dart';
import 'package:ucp_core/core.dart';

void main() {
  test('UCP protocol version is 1.0', () {
    expect(UcpProtocol.version, '1.0');
    expect(UcpProtocol.major, 1);
    expect(UcpProtocol.minor, 0);
  });

  test('UCP protocol compatibility works', () {
    expect(UcpProtocol.isCompatible('1.0'), isTrue);
  });
}
