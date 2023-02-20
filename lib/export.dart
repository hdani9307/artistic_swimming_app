import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ExportPage extends StatelessWidget {
  final String qrData;

  const ExportPage({super.key, required this.qrData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Export"),
      ),
      body: SafeArea(
        child: Center(
          child: QrImage(
            data: qrData,
            version: QrVersions.auto,
          ),
        ),
      ),
    );
  }
}
