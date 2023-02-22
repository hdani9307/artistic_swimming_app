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
    var controller = PageController(initialPage: 0);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Export"),
      ),
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
              onPressed: () {
                controller.previousPage(duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
              },
            ),
            Flexible(
              child: Center(
                child: PageView(
                  controller: controller,
                  children: _createQrImages(),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios_outlined),
              onPressed: () {
                controller.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _createQrImages() {
    const padding = EdgeInsets.all(30);
    final widgets = [
      Center(
        child: QrImage(
          padding: padding,
          data: _encodeData(meta.toMap()),
        ),
      ),
    ];
    for (var value in data) {
      widgets.add(
        Center(
          child: QrImage(
            padding: padding,
            data: _encodeData(value.toMap()),
          ),
        ),
      );
    }

    return widgets;
  }

  String _encodeData(Map<String, dynamic> data) {
    final enCodedJson = utf8.encode(json.encode(data));
    final gZipJson = gzip.encode(enCodedJson);
    return base64.encode(gZipJson);
  }
}
