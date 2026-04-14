# easy_pdf_viewer

This project is based on [easy_pdf_viewer](https://pub.dev/packages/easy_pdf_viewer/).

## Introduction

easy_pdf_viewer is a Flutter plugin for handling PDF files. It supports loading PDF documents from local files, network URLs, and asset files, and provides an easy-to-use PDF viewer widget.<br/>

## Installation

Navigate to your project directory and add the following dependency to your pubspec.yaml:

```yaml
dependencies:
  easy_pdf_viewer:
    git:
      url: https://gitcode.com/OpenHarmony-Flutter/fluttertpc_easy_pdf_viewer.git
      ref: 1.0.8-ohos-1.0.0
```

Execute the command

```bash
flutter pub get
```

> TAG naming convention: `original-version-ohos-version-betax`. For changes between different TAGs, please refer to CHANGELOG.md.

| Flutter Framework Version | TAG Name | Remarks |
| ---------------- | -------- | ---- |
| 3.22.1-ohos-1.1.0 | 1.0.8-ohos-1.0.0 | |
| 3.27.5-ohos-1.0.4 | 1.0.8-ohos-1.0.0 | |
| 3.35.8-ohos-0.0.2 | 1.0.8-ohos-1.0.0 | |

## Constraints and Limitations

### Compatibility

Tested and verified on the following versions:

1. Flutter: 3.22.1-ohos-1.1.0; SDK: 5.0.0(12); IDE: DevEco Studio: 6.1.0.830; ROM: 6.0.0.130 SP25;
2. Flutter: 3.27.5-ohos-1.0.4; SDK: 5.0.0(12); IDE: DevEco Studio: 6.1.0.830; ROM: 6.0.0.130 SP25;
3. Flutter: 3.35.8-ohos-0.0.2; SDK: 5.0.0(12); IDE: DevEco Studio: 6.1.0.830; ROM: 6.0.0.130 SP25;

### Permission Requirements

This plugin requires internet permission for loading PDF files from URLs.

**Add permissions in module.json5 under the entry directory**

Open `entry/src/main/module.json5` and add:

```json
"requestPermissions": [
  {
    "name": "ohos.permission.INTERNET",
    "reason": "$string:network_reason",
    "usedScene": {
      "abilities": [
        "EntryAbility"
      ],
      "when": "inuse"
    }
  }
]
```

**Add the reason for requesting the above permissions under the entry directory**

Open `entry/src/main/resources/base/element/string.json` and add:

```json
{
  "string": [
    {
      "name": "network_reason",
      "value": "Use network to load PDF files"
    }
  ]
}
```

## Usage Example

easy_pdf_viewer provides simple and easy-to-use APIs and widgets. The following snippet shows the simplest usage of this widget:<br/>

```dart
import 'package:flutter/material.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';

class PDFViewerPage extends StatefulWidget {
  const PDFViewerPage({Key? key}) : super(key: key);

  @override
  State<PDFViewerPage> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  PDFDocument? document;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  Future<void> loadDocument() async {
    final doc = await PDFDocument.fromAsset('assets/sample.pdf');
    setState(() {
      document = doc;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PDF Viewer')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : PDFViewer(document: document!),
    );
  }
}
```

## Usage Instructions

### 1. Loading PDF Documents

Load from asset file (needs to be declared in pubspec.yaml)

```dart
PDFDocument document = await PDFDocument.fromAsset('assets/sample.pdf');
```

Load from local file

```dart
import 'dart:io';
File file = File('/path/to/file.pdf');
PDFDocument document = await PDFDocument.fromFile(file);
```

Load from network URL

```dart
PDFDocument document = await PDFDocument.fromURL(
  'https://example.com/sample.pdf',
  headers: {'Authorization': 'Bearer token'},
);
```

Load with download progress monitoring

```dart
PDFDocument.fromURLWithDownloadProgress(
  'https://example.com/sample.pdf',
  downloadProgress: (progress) {
    print('Download progress: ${progress.downloaded / progress.total * 100}%');
  },
  onDownloadComplete: (document) {
    setState(() {
      this.document = document;
    });
  },
);
```

### 2. Using the PDFViewer Widget

```dart
PDFViewer(
  document: document,
  scrollDirection: Axis.vertical,  // Scroll direction
  lazyLoad: true,                  // Whether to lazy load
  showIndicator: true,             // Whether to show page indicator
  showPicker: true,                // Whether to show page picker
  showNavigation: true,            // Whether to show navigation bar
  enableSwipeNavigation: true,     // Whether to enable swipe navigation
  minScale: 1.0,                   // Minimum zoom scale
  maxScale: 5.0,                   // Maximum zoom scale
  onPageChanged: (page) {
    print('Current page: $page');
  },
)
```

### 3. Clear Cache

```dart
await PDFDocument.clearPreviewCache();
```

## API Reference

> [!TIP] The "ohos Support" column indicates yes for properties supported on the ohos platform, and no for unsupported ones.

### PDFDocument

| Name | Type | Parameters | Return Value | ohos Support | Description |
|------|------|------------|--------------|--------------|-------------|
| fromFile() | Method | File file, {bool clearPreviewCache = true} | Future<PDFDocument> | yes | Load PDF document from local file |
| fromURL() | Method | String url, {Map<String, String>? headers, CacheManager? cacheManager, bool clearPreviewCache = true} | Future<PDFDocument> | yes | Load PDF document from network URL |
| fromURLWithDownloadProgress() | Method | String url, {Map<String, String>? headers, CacheManager? cacheManager, bool clearPreviewCache = true, required void Function(DownloadProgress) downloadProgress, required void Function(PDFDocument) onDownloadComplete} | void | yes | Load from URL with download progress monitoring |
| fromAsset() | Method | String asset, {bool clearPreviewCache = true} | Future<PDFDocument> | yes | Load PDF document from asset file |
| clearPreviewCache() | Method | / | Future<void> | yes | Clear PDF preview cache |

### PDFViewer

| Name | Type | Parameters | Default Value | ohos Support | Description |
|------|------|------------|---------------|--------------|-------------|
| document | Property | / | required | yes | PDF document instance |
| scrollDirection | Property | / | Axis? | yes | Scroll direction |
| lazyLoad | Property | / | true | yes | Whether to lazy load pages |
| showIndicator | Property | / | true | yes | Whether to show page indicator |
| showPicker | Property | / | true | yes | Whether to show page picker |
| showNavigation | Property | / | true | yes | Whether to show navigation bar |
| enableSwipeNavigation | Property | / | true | yes | Whether to enable swipe navigation |
| minScale | Property | / | double? | yes | Minimum zoom scale |
| maxScale | Property | / | double? | yes | Maximum zoom scale |
| zoomSteps | Property | / | int? | yes | Zoom steps |
| onPageChanged | Property | / | ValueChanged<int>? | yes | Page change callback |
| controller | Property | / | PageController? | yes | Page controller |

### IndicatorPosition

Page indicator position enumeration:

- `topLeft`: Top left corner
- `topRight`: Top right corner
- `bottomLeft`: Bottom left corner
- `bottomRight`: Bottom right corner

## Known Issues

None

## Others

None

## Directory Structure

```
|---- Directory
|     |---- android   # Android adaptation code
|     |---- example   # Complete example app for multiple platforms
|           |---- lib  # Example code
|           |---- ohos # OpenHarmony project
|     |---- ios       # iOS adaptation code
|     |---- lib       # Core code implementation
|           |---- src
|           |---- document.dart    # PDF document handling
|           |---- viewer.dart      # PDF viewer widget
|           |---- page.dart        # PDF page widget
|           |---- page_picker.dart # Page picker
|           |---- tooltip.dart     # Tooltip
|           |---- zoomable_widget.dart # Zoomable widget
|           |---- easy_pdf_viewer.dart # Library entry file
|     |---- ohos      # OpenHarmony adaptation code
|     |---- test      # Unit test files
|     |---- CHANGELOG.md              # Changelog
|     |---- LICENSE                   # License
|     |---- README.OpenHarmony.md     # English documentation
|     |---- README.OpenHarmony_CN.md  # Chinese documentation
|     |---- README.md                 # Original library documentation
|     |---- pubspec.yaml              # Configuration file
```

## Contributing

If you encounter any issues during use, please feel free to submit an [Issue](https://gitcode.com/OpenHarmony-Flutter/fluttertpc_easy_pdf_viewer/issues). Of course, [PRs](https://gitcode.com/OpenHarmony-Flutter/fluttertpc_easy_pdf_viewer/pulls) are also very welcome.

## License

This project is licensed under [BSD-3-Clause](LICENSE). Please enjoy and participate in open source freely.
