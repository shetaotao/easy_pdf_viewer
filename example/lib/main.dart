import 'dart:io';

import 'package:easy_pdf_viewer_example/with_progress.dart';
import 'package:flutter/material.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() => runApp(App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({this.progressExample = false});

  final bool progressExample;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;
  late PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromAsset('assets/sample.pdf');

    setState(() => _isLoading = false);
  }

  changePDF(value) async {
    setState(() => _isLoading = true);
    if (value == 1) {
      document = await PDFDocument.fromAsset('assets/sample2.pdf');
    } else if (value == 2) {
      document = await PDFDocument.fromURL(
        "https://www.orimi.com/pdf-test.pdf",

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

  Future<PDFDocument> loadFromFile() async {
    // Copy asset to temp file and load from file
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/sample_from_file.pdf');
    
    final byteData = await rootBundle.load('assets/sample.pdf');
    await tempFile.writeAsBytes(byteData.buffer.asUint8List());
    
    return await PDFDocument.fromFile(tempFile);
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
      body: Center(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : PDFViewer(
                document: document,
                lazyLoad: false,
                zoomSteps: 1,
                numberPickerConfirmWidget: const Text(
                  "Confirm",
                ),
                //uncomment below line to preload all pages
                // lazyLoad: false,
                // uncomment below line to scroll vertically
                // scrollDirection: Axis.vertical,

                //uncomment below code to replace bottom navigation with your own
                /* navigationBuilder:
                      (context, page, totalPages, jumpToPage, animateToPage) {
                    return ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.first_page),
                          onPressed: () {
                            jumpToPage()(page: 0);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            animateToPage(page: page - 2);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () {
                            animateToPage(page: page);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.last_page),
                          onPressed: () {
                            jumpToPage(page: totalPages - 1);
                          },
                        ),
                      ],
                    );
                  }, */
              ),
      ),
    );
  }
}
