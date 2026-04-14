import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:easy_pdf_viewer/src/page.dart';

void main() {
  const MethodChannel channel = MethodChannel('easy_pdf_viewer_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'getNumberOfPages') {
        return '5';
      }
      if (methodCall.method == 'getPage') {
        return '/tmp/page_${methodCall.arguments['pageNumber']}.png';
      }
      if (methodCall.method == 'clearCacheDir') {
        return null;
      }
      return null;
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  group('PDFViewerTooltip Tests', () {
    test('test 1: PDFViewerTooltip default values', () {
      const tooltip = PDFViewerTooltip();

      expect(tooltip.first, 'First');
      expect(tooltip.previous, 'Previous');
      expect(tooltip.next, 'Next');
      expect(tooltip.last, 'Last');
      expect(tooltip.pick, 'Pick a page');
      expect(tooltip.jump, 'Jump');
    });

    test('test 2: PDFViewerTooltip custom values', () {
      const tooltip = PDFViewerTooltip(
        first: '首页',
        previous: '上一页',
        next: '下一页',
        last: '末页',
        pick: '选择页面',
        jump: '跳转',
      );

      expect(tooltip.first, '首页');
      expect(tooltip.previous, '上一页');
      expect(tooltip.next, '下一页');
      expect(tooltip.last, '末页');
      expect(tooltip.pick, '选择页面');
      expect(tooltip.jump, '跳转');
    });
  });

  group('IndicatorPosition Tests', () {
    test('test 3: IndicatorPosition enum values', () {
      expect(IndicatorPosition.values.length, 4);
      expect(IndicatorPosition.values.contains(IndicatorPosition.topLeft), true);
      expect(IndicatorPosition.values.contains(IndicatorPosition.topRight), true);
      expect(IndicatorPosition.values.contains(IndicatorPosition.bottomLeft), true);
      expect(IndicatorPosition.values.contains(IndicatorPosition.bottomRight), true);
    });
  });

  group('PDFPage Tests', () {
    test('test 4: PDFPage creation with default parameters', () {
      final page = PDFPage('/tmp/test.pdf', 1);

      expect(page.num, 1);
      expect(page.imgPath, '/tmp/test.pdf');
      expect(page.zoomSteps, 3);
      expect(page.minScale, 1.0);
      expect(page.maxScale, 5.0);
      expect(page.panLimit, 1.0);
    });

    test('test 5: PDFPage creation with custom parameters', () {
      final page = PDFPage(
        '/tmp/test.pdf',
        5,
        zoomSteps: 5,
        minScale: 0.5,
        maxScale: 10.0,
        panLimit: 2.0,
      );

      expect(page.num, 5);
      expect(page.imgPath, '/tmp/test.pdf');
      expect(page.zoomSteps, 5);
      expect(page.minScale, 0.5);
      expect(page.maxScale, 10.0);
      expect(page.panLimit, 2.0);
    });
  });

  // API Tests from README.OpenHarmony_CN.md
  group('API Tests - PDFDocument', () {
    test('test 6: PDFDocument.fromFile - verify document creation', () async {
      // Create a temporary file for testing
      final tempDir = Directory.systemTemp;
      final testFile = File('${tempDir.path}/test.pdf');
      await testFile.writeAsBytes([0x25, 0x50, 0x44, 0x46]); // PDF header bytes

      final document = await PDFDocument.fromFile(testFile);

      expect(document, isNotNull);
      expect(document.count, 5);
      expect(document.filePath, testFile.path);

      // Cleanup
      await testFile.delete();
    });

    test('test 7: PDFDocument.clearPreviewCache - verify method exists', () async {
      // Test that clearPreviewCache method can be called without error
      await PDFDocument.clearPreviewCache();
      // If no exception is thrown, the test passes
      expect(true, true);
    });

    test('test 8: PDFDocument.get - retrieve specific page', () async {
      final tempDir = Directory.systemTemp;
      final testFile = File('${tempDir.path}/test.pdf');
      await testFile.writeAsBytes([0x25, 0x50, 0x44, 0x46]);

      final document = await PDFDocument.fromFile(testFile);
      final page = await document.get(page: 1);

      expect(page, isNotNull);
      expect(page.num, 1);
      expect(page.imgPath, '/tmp/page_1.png');

      await testFile.delete();
    });

    test('test 9: PDFDocument.get with custom zoom parameters', () async {
      final tempDir = Directory.systemTemp;
      final testFile = File('${tempDir.path}/test.pdf');
      await testFile.writeAsBytes([0x25, 0x50, 0x44, 0x46]);

      final document = await PDFDocument.fromFile(testFile);
      final page = await document.get(
        page: 2,
        zoomSteps: 5,
        minScale: 0.5,
        maxScale: 10.0,
        panLimit: 2.0,
      );

      expect(page, isNotNull);
      expect(page.num, 2);
      expect(page.zoomSteps, 5);
      expect(page.minScale, 0.5);
      expect(page.maxScale, 10.0);
      expect(page.panLimit, 2.0);

      await testFile.delete();
    });

    test('test 10: PDFDocument.preloadPages - preload all pages', () async {
      final tempDir = Directory.systemTemp;
      final testFile = File('${tempDir.path}/test.pdf');
      await testFile.writeAsBytes([0x25, 0x50, 0x44, 0x46]);

      final document = await PDFDocument.fromFile(testFile);
      await document.preloadPages();

      // After preloading, getting a page should return cached page
      final page = await document.get(page: 1);
      expect(page, isNotNull);

      await testFile.delete();
    });
  });
}
