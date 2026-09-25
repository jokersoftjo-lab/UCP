import 'ucp_transport_state.dart';

/// Abstract transport used by the UCP protocol layer.
abstract interface class UcpTransport {
  UcpTransportState get state;
  Future<void> connect();
  Future<void> send(List<int> data);
  Stream<List<int>> get received;
  Future<void> close();
}
