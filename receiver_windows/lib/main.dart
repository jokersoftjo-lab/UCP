import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ucp_core/core.dart';

void main() => runApp(const UcpWindowsReceiver());

class UcpWindowsReceiver extends StatelessWidget {
  const UcpWindowsReceiver({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UCP Windows Receiver',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      home: const ReceiverPage(),
    );
  }
}

class ReceiverPage extends StatefulWidget {
  const ReceiverPage({super.key});

  @override
  State<ReceiverPage> createState() => _ReceiverPageState();
}

class _ReceiverPageState extends State<ReceiverPage> {
  RawDatagramSocket? _socket;
  StreamSubscription<RawSocketEvent>? _subscription;
  String _status = 'تشغيل المستقبل...';
  String _lastInput = 'لا يوجد إدخال';
  String _source = '-';
  int _sequence = 0;

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    try {
      final socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 50001);
      _socket = socket;
      setState(() => _status = 'Listening UDP :50001');

      _subscription = socket.listen((event) {
        if (event != RawSocketEvent.read) return;
        final datagram = socket.receive();
        if (datagram == null) return;

        try {
          final message = const UcpWireDecoder().decode(datagram.data);
          final payload = message.payload;
          final control = payload['control'] ?? '?';
          final pressed = payload['pressed'] ?? false;

          if (!mounted) return;
          setState(() {
            _lastInput = control.toString() + (pressed == true ? ' DOWN' : ' UP');
            _source = message.sourceId;
            _sequence = message.sequence;
            _status = 'Received from ' + datagram.address.address + ':' +
                datagram.port.toString();
          });
        } catch (error) {
          if (!mounted) return;
          setState(() => _status = 'Invalid UCP packet: ' + error.toString());
        }
      });
    } catch (error) {
      setState(() => _status = 'Socket error: ' + error.toString());
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _socket?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('UCP Windows Receiver')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('آخر إدخال', style: TextStyle(fontSize: 22)),
            const SizedBox(height: 12),
            Text(
              _lastInput,
              style: const TextStyle(fontSize: 56, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Text('Sequence: ' + _sequence.toString()),
            Text('Source: ' + _source),
            const SizedBox(height: 24),
            Text(_status),
            const SizedBox(height: 40),
            const Text('UDP 50001 — UCP Wire Experiment'),
          ],
        ),
      ),
    );
  }
}
