# easy_pdf_viewer

This project is based on [easy_pdf_viewer](https://github.com/kaichii/pdf_viewer).

## 1. Installation and Usage

### 1.1 Installation

Navigate to your project directory and add the dependency in `pubspec.yaml`:

#### pubspec.yaml

```yaml
dependencies:
  easy_pdf_viewer:
    git:
      url: https://gitcode.com/org/OpenHarmony-Flutter/easy_pdf_viewer
      ref: main
```

Run the command:

```bash
flutter pub get
```

### 1.2 Usage Example

For usage examples, please refer to [example](example/lib/main.dart).


## 2. Constraints and Limitations

### 2.1 Compatibility

Tested and verified on the following versions:
1. Flutter: 3.22.1-ohos-1.1.0; SDK: 5.0.0(12); IDE: DevEco Studio: 6.0.2.640; ROM: 6.0.0.130 SP18;
2. Flutter: 3.27.5-ohos-1.0.4; SDK: 5.0.0(12); IDE: DevEco Studio: 6.0.2.640; ROM: 6.0.0.130 SP18;
3. Flutter: 3.35.8-ohos-0.0.2; SDK: 5.0.0(12); IDE: DevEco Studio: 6.0.2.640; ROM: 6.0.0.130 SP18;

## 3. Version and Framework Compatibility

| Version | 3.7 | 3.22 | 3.27 | 3.35 |
| --- | --- | --- | --- | --- |
| 1.0.0 | ❌ | ✅ | ✅ | ✅ |

## 4. API

> [!TIP] The "ohos Support" column indicates whether the property is supported on the ohos platform: yes means supported, no means not supported.

| Name | Description | Type | Parameters and Description | Output | ohos Support |
| --- | --- | --- | --- | --- | --- |
| PDFDocument.fromFile | Load PDF document from local file | static Future<PDFDocument> | file: PDF file; clearPreviewCache[optional]: whether to clear preview cache, default is true | PDFDocument | yes |
| PDFDocument.fromURL | Load PDF document from network URL | static Future<PDFDocument> | url: PDF link; headers[optional]: request headers; cacheManager[optional]: cache manager; clearPreviewCache[optional]: whether to clear preview cache, default is true | PDFDocument | yes |
| PDFDocument.fromURLWithDownloadProgress | Load from URL and monitor download progress | static void | url: PDF link; headers[optional]: request headers; cacheManager[optional]: cache manager; clearPreviewCache[optional]: whether to clear preview cache, default is true; downloadProgress: download progress callback; onDownloadComplete: download completion callback | void | yes |
| PDFDocument.fromAsset | Load PDF document from asset file | static Future<PDFDocument> | asset: asset path; clearPreviewCache[optional]: whether to clear preview cache, default is true | PDFDocument | yes |
| PDFDocument.clearPreviewCache | Clear PDF preview cache | static Future<void> | None | void | yes |
| PDFViewer | PDF viewer widget | Widget | document: PDFDocument instance (required); scrollDirection[optional]: scroll direction; lazyLoad[optional]: whether to lazy load; showIndicator[optional]: whether to show page indicator; showPicker[optional]: whether to show page picker; showNavigation[optional]: whether to show navigation bar; enableSwipeNavigation[optional]: whether to enable swipe navigation; zoomSteps[optional]: zoom steps; minScale[optional]: minimum zoom scale; maxScale[optional]: maximum zoom scale; onPageChanged[optional]: page change callback; controller[optional]: page controller | Widget | yes |
| PDFPage | PDF page widget | Widget | data: page data; pageNumber: page number; onZoomChanged[optional]: zoom callback; zoomSteps[optional]: zoom steps; minScale[optional]: minimum zoom; maxScale[optional]: maximum zoom; panLimit[optional]: pan limit | Widget | yes |


## 5. License

This project is licensed under [BSD-3-Clause](LICENSE).
