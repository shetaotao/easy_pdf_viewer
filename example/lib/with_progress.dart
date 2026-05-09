import 'dart:io';

import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class WithProgress extends StatefulWidget {
  WithProgress({Key? key}) : super(key: key);

  @override
  State<WithProgress> createState() => _WithProgressState();
}

class _WithProgressState extends State<WithProgress> {
  bool _isLoading = true;
  late PDFDocument document;
  DownloadProgress? downloadProgress;

  @override
  void initState() {
    loadDocument();
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void loadDocument() async {
    /// Clears the cache before download, so [PDFDocument.fromURLWithDownloadProgress.downloadProgress()]
    /// is always executed (meant only for testing).
    await DefaultCacheManager().emptyCache();

    PDFDocument.fromURLWithDownloadProgress(
      // "https://pdfkit.org/docs/guide.pdf";
      'https://pdfkit.org/docs/guide.pdf',
      downloadProgress: (downloadProgress) => setState(() {
        this.downloadProgress = downloadProgress;
      }),
      onDownloadComplete: (document) => setState(() {
        this.document = document;
        _isLoading = false;
      }),
    );
  }

  Widget buildProgress() {
    if (downloadProgress == null) return SizedBox();

    String parseBytesToKBs(int? bytes) {
      if (bytes == null) return '0 KBs';

      return '${(bytes / 1000).toStringAsFixed(2)} KBs';
    }

    String progressString = parseBytesToKBs(downloadProgress!.downloaded);
    if (downloadProgress!.totalSize != null) {
      progressString += '/ ${parseBytesToKBs(downloadProgress!.totalSize)}';
    }

    return Column(
      children: [
        SizedBox(height: 20),
        Text(progressString),
      ],
    );
  }

  Future<PDFDocument> loadFromFile() async {
    // Copy asset to temp file and load from file
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/sample_from_file.pdf');

    final byteData = await rootBundle.load('assets/sample.pdf');
    await tempFile.writeAsBytes(byteData.buffer.asUint8List());

    return await PDFDocument.fromFile(tempFile);
  }

  changePDF(value) async {
    setState(() => _isLoading = true);
    if (value == 1) {
      document = await PDFDocument.fromAsset('assets/sample2.pdf');
    } else if (value == 2) {
      document = await PDFDocument.fromURL(
        "https://pdfkit.org/docs/guide.pdf",

        /* cacheManager: CacheManager(
          Config(
            "customCacheKey",
            stalePeriod: const Duration(days: 2),
            maxNrOfCacheObjects: 10,
          ),
        ), */
      );
    } else if (value == 4) {
      // Load from File demo
      document = await loadFromFile();
    } else {
      document = await PDFDocument.fromAsset('assets/sample.pdf');
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            SizedBox(height: 36),
            ListTile(
              title: Text('Load from Assets'),
              onTap: () {
                changePDF(1);
              },
            ),
            ListTile(
              title: Text('Load from URL'),
              onTap: () {
                changePDF(2);
              },
            ),
            ListTile(
              title: Text('Restore default'),
              onTap: () {
                changePDF(3);
              },
            ),
            ListTile(
              title: Text('Load from File'),
              onTap: () {
                changePDF(4);
              },
            ),
            ListTile(
              title: Text('With Progress'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WithProgress(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Clear Preview Cache'),
              onTap: () async {
                Navigator.of(context).pop();
                await PDFDocument.clearPreviewCache();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Preview cache cleared!')),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('PDFViewer'),
      ),
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    buildProgress(),
                  ],
                ),
              )
            : PDFViewer(
                document: document,
                numberPickerConfirmWidget: const Text(
                  "Confirm",
                ),
              ),
      ),
    );
  }
}
