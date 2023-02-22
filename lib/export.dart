import 'dart:convert';
import 'dart:io';

import 'package:artistic_swimming_app/model/export.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ExportPage extends StatelessWidget {
  final ExportMeta meta;
  final List<ExportData> data;

  const ExportPage({super.key, required this.meta, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Export"),
      ),
      body: SafeArea(
        child: Center(
          child: PageView(
            controller: PageController(
                initialPage: 0
            ),
            children: _createQrImages(),
          ),
        ),
      ),
    );
  }

  List<Widget> _createQrImages() {
    final widgets = [
      QrImage(data: _encodeData(meta.toMap())),
    ];
    for (var value in data) {
      widgets.add(QrImage(data: _encodeData(value.toMap())));
    }

    return widgets;
  }

  String _encodeData(Map<String, dynamic> data) {
    final enCodedJson = utf8.encode(json.encode(data));
    final gZipJson = gzip.encode(enCodedJson);
    return base64.encode(gZipJson);
  }
}
