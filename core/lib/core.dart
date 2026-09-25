/// UCP Core public API.
///
/// Platform-independent protocol models and contracts for UCP/1.0.
library ucp_core;

export 'src/protocol/ucp_protocol.dart';
export 'src/protocol/ucp_message.dart';
export 'src/protocol/ucp_message_type.dart';
export 'src/protocol/ucp_flags.dart';
export 'src/device/ucp_device.dart';
export 'src/device/ucp_capability.dart';
export 'src/device/ucp_device_type.dart';
export 'src/device/ucp_device_state.dart';
export 'src/session/ucp_session.dart';
export 'src/session/ucp_session_state.dart';
export 'src/session/ucp_session_manager.dart';
export 'src/transport/ucp_transport.dart';
export 'src/transport/ucp_transport_state.dart';
export 'src/errors/ucp_error.dart';
export 'src/messages/discovery_message.dart';
export 'src/messages/handshake_message.dart';
export 'src/messages/input_message.dart';
export 'src/messages/feedback_message.dart';
export 'src/messages/error_message.dart';
export 'src/wire/ucp_wire_encoder.dart';
export 'src/wire/ucp_wire_decoder.dart';
export 'src/wire/ucp_wire_codec.dart';
