import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ucp_core/core.dart';

void main() => runApp(const UcpPhoneExperiment());

class UcpPhoneExperiment extends StatelessWidget {
  const UcpPhoneExperiment({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UCP Phone Experiment',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const ControllerPage(),
    );
  }
}

class ControllerPage extends StatefulWidget {
  const ControllerPage({super.key});

  @override
  State<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  final _ipController = TextEditingController();
  RawDatagramSocket? _socket;
  String _status = 'غير متصل';
  int _sequence = 0;

  @override
  void dispose() {
    _socket?.close();
    _ipController.dispose();
    super.dispose();
  }

  Future<void> _connect() async {
    final ip = _ipController.text.trim();
    if (ip.isEmpty) {
      setState(() => _status = 'أدخل IP جهاز Windows');
      return;
    }
    try {
      _socket ??= await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
      setState(() => _status = 'جاهز للإرسال إلى ' + ip + ':50001');
    } catch (error) {
      setState(() => _status = 'خطأ الشبكة: ' + error.toString());
    }
  }

  void _send(String control, {bool pressed = true}) {
    final ip = _ipController.text.trim();
    final socket = _socket;
    if (ip.isEmpty || socket == null) {
      setState(() => _status = 'اتصل أولاً');
      return;
    }

    final message = UcpMessage(
      messageId: 'phone-' + DateTime.now().microsecondsSinceEpoch.toString(),
      type: 'input.event',
      sourceId: 'phone-experiment',
      destinationId: 'windows-experiment',
      timestampMs: DateTime.now().millisecondsSinceEpoch,
      sequence: ++_sequence,
      flags: UcpFlags.encode([UcpMessageFlag.ordered]),
      payload: {
        'inputType': 'button',
        'control': control,
        'pressed': pressed,
      },
    );

    final bytes = const UcpWireEncoder().encode(message);
    socket.send(bytes, InternetAddress(ip), 50001);
    setState(() => _status =
        control + ' ' + (pressed ? 'DOWN' : 'UP') + ' seq=' + _sequence.toString());
  }

  Widget _button(String label) {
    return Listener(
      onPointerDown: (_) => _send(label),
      onPointerUp: (_) => _send(label, pressed: false),
      onPointerCancel: (_) => _send(label, pressed: false),
      child: SizedBox(
        width: 110,
        height: 80,
        child: ElevatedButton(
          onPressed: () {},
          child: Text(label, style: const TextStyle(fontSize: 22)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('UCP — Phone Input Experiment')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _ipController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Windows IP',
                hintText: 'مثال: 192.168.1.100',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _connect,
              icon: const Icon(Icons.wifi),
              label: const Text('اتصال'),
            ),
            const SizedBox(height: 16),
            Text(_status, textAlign: TextAlign.center),
            const Spacer(),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                _button('UP'),
                _button('DOWN'),
                _button('LEFT'),
                _button('RIGHT'),
                _button('A'),
                _button('B'),
              ],
            ),
            const Spacer(),
            const Text('اضغط مطولاً أو ارفع إصبعك لرؤية DOWN / UP على Windows'),
          ],
        ),
      ),
    );
  }
}
