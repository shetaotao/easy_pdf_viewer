# easy_pdf_viewer

本项目基于 [easy_pdf_viewer](https://pub.dev/packages/easy_pdf_viewer/) 开发。

## 简介

easy_pdf_viewer 是一个用于处理 PDF 文件的 Flutter 插件，支持从本地文件、网络 URL 和资源文件加载 PDF 文档，并提供易于使用的 PDF 查看器组件。<br/>

## 下载安装

进入到工程目录并在 pubspec.yaml 中添加以下依赖：

```yaml
dependencies:
  easy_pdf_viewer:
    git:
      url: https://gitcode.com/OpenHarmony-Flutter/fluttertpc_easy_pdf_viewer.git
      ref: 1.0.8-ohos-1.0.0
```

执行命令

```bash
flutter pub get
```

> TAG 命名规则：`原库版本-ohos-版本号-betax`，不同 TAG 之间的变更详见 CHANGELOG.md。

| Flutter 框架版本 | TAG 名称 | 备注 |
| ---------------- | -------- | ---- |
| 3.22.1-ohos-1.1.0 | 1.0.8-ohos-1.0.0 | |
| 3.27.5-ohos-1.0.4 | 1.0.8-ohos-1.0.0 | |
| 3.35.8-ohos-0.0.2 | 1.0.8-ohos-1.0.0 | |

## 约束与限制

### 兼容性

在以下版本中已测试通过：

1. Flutter: 3.22.1-ohos-1.1.0; SDK: 5.0.0(12); IDE: DevEco Studio: 6.1.0.830; ROM: 6.0.0.130 SP25;
2. Flutter: 3.27.5-ohos-1.0.4; SDK: 5.0.0(12); IDE: DevEco Studio: 6.1.0.830; ROM: 6.0.0.130 SP25;
3. Flutter: 3.35.8-ohos-0.0.2; SDK: 5.0.0(12); IDE: DevEco Studio: 6.1.0.830; ROM: 6.0.0.130 SP25;

### 权限要求

本插件需要网络权限用于从 URL 加载 PDF 文件。

**在 entry 目录下的 module.json5 中添加权限**

打开 `entry/src/main/module.json5`，添加：

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

**在 entry 目录下添加申请以上权限的原因**

打开 `entry/src/main/resources/base/element/string.json`，添加：

```json
{
  "string": [
    {
      "name": "network_reason",
      "value": "使用网络加载 PDF 文件"
    }
  ]
}
```

## 使用示例

easy_pdf_viewer 提供了简单易用的 API 和 Widget，以下片段是该小部件最简单的使用方式：<br/>

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

## 使用说明

### 1. 加载 PDF 文档

从资源文件加载（需要在 pubspec.yaml 中声明）

```dart
PDFDocument document = await PDFDocument.fromAsset('assets/sample.pdf');
```

从本地文件加载

```dart
import 'dart:io';
File file = File('/path/to/file.pdf');
PDFDocument document = await PDFDocument.fromFile(file);
```

从网络 URL 加载

```dart
PDFDocument document = await PDFDocument.fromURL(
  'https://example.com/sample.pdf',
  headers: {'Authorization': 'Bearer token'},
);
```

带下载进度监听的加载

```dart
PDFDocument.fromURLWithDownloadProgress(
  'https://example.com/sample.pdf',
  downloadProgress: (progress) {
    print('下载进度: ${progress.downloaded / progress.total * 100}%');
  },
  onDownloadComplete: (document) {
    setState(() {
      this.document = document;
    });
  },
);
```

### 2. 使用 PDFViewer 组件

```dart
PDFViewer(
  document: document,
  scrollDirection: Axis.vertical,  // 滚动方向
  lazyLoad: true,                  // 是否懒加载
  showIndicator: true,             // 是否显示页码指示器
  showPicker: true,                // 是否显示页码选择器
  showNavigation: true,            // 是否显示导航栏
  enableSwipeNavigation: true,     // 是否启用滑动导航
  minScale: 1.0,                   // 最小缩放比例
  maxScale: 5.0,                   // 最大缩放比例
  onPageChanged: (page) {
    print('当前页码: $page');
  },
)
```

### 3. 清除缓存

```dart
await PDFDocument.clearPreviewCache();
```

## 接口说明

> [!TIP] "ohos Support"列为 yes 表示 ohos 平台支持该属性；no 则表示不支持

### PDFDocument

| 名称 | 类型 | 参数 | 返回值 | ohos Support | 说明 |
|------|------|------|--------|--------------|------|
| fromFile() | 方法 | File file, {bool clearPreviewCache = true} | Future<PDFDocument> | yes | 从本地文件加载 PDF 文档 |
| fromURL() | 方法 | String url, {Map<String, String>? headers, CacheManager? cacheManager, bool clearPreviewCache = true} | Future<PDFDocument> | yes | 从网络 URL 加载 PDF 文档 |
| fromURLWithDownloadProgress() | 方法 | String url, {Map<String, String>? headers, CacheManager? cacheManager, bool clearPreviewCache = true, required void Function(DownloadProgress) downloadProgress, required void Function(PDFDocument) onDownloadComplete} | void | yes | 从 URL 加载并监听下载进度 |
| fromAsset() | 方法 | String asset, {bool clearPreviewCache = true} | Future<PDFDocument> | yes | 从资源文件加载 PDF 文档 |
| clearPreviewCache() | 方法 | / | Future<void> | yes | 清除 PDF 预览缓存 |

### PDFViewer

| 名称 | 类型 | 参数 | 默认值 | ohos Support | 说明 |
|------|------|------|--------|--------------|------|
| document | 属性 | / | required | yes | PDF 文档实例 |
| scrollDirection | 属性 | / | Axis? | yes | 滚动方向 |
| lazyLoad | 属性 | / | true | yes | 是否懒加载页面 |
| showIndicator | 属性 | / | true | yes | 是否显示页码指示器 |
| showPicker | 属性 | / | true | yes | 是否显示页码选择器 |
| showNavigation | 属性 | / | true | yes | 是否显示导航栏 |
| enableSwipeNavigation | 属性 | / | true | yes | 是否启用滑动导航 |
| minScale | 属性 | / | double? | yes | 最小缩放比例 |
| maxScale | 属性 | / | double? | yes | 最大缩放比例 |
| zoomSteps | 属性 | / | int? | yes | 缩放步数 |
| onPageChanged | 属性 | / | ValueChanged<int>? | yes | 页面切换回调 |
| controller | 属性 | / | PageController? | yes | 页面控制器 |

### IndicatorPosition

页码指示器位置枚举：

- `topLeft`: 左上角
- `topRight`: 右上角
- `bottomLeft`: 左下角
- `bottomRight`: 右下角

## 遗留问题

无

## 其他

无

## 目录结构

```
|---- 目录
|     |---- android   # Android 适配代码
|     |---- example   # 多平台的完整示例应用
|           |---- lib  # 示例代码
|           |---- ohos # OpenHarmony 工程
|     |---- ios       # iOS 适配代码
|     |---- lib       # 核心代码实现
|           |---- src
|           |---- document.dart    # PDF 文档处理
|           |---- viewer.dart      # PDF 查看器组件
|           |---- page.dart        # PDF 页面组件
|           |---- page_picker.dart # 页码选择器
|           |---- tooltip.dart     # 工具提示
|           |---- zoomable_widget.dart # 可缩放组件
|           |---- easy_pdf_viewer.dart # 库入口文件
|     |---- ohos      # OpenHarmony 适配代码
|     |---- test      # 单元测试文件
|     |---- CHANGELOG.md              # 更新日志
|     |---- LICENSE                   # 开源协议
|     |---- README.OpenHarmony.md     # 英文说明文档
|     |---- README.OpenHarmony_CN.md  # 中文说明文档
|     |---- README.md                 # 原库说明文档
|     |---- pubspec.yaml              # 配置文件
```

## 贡献代码

使用过程中发现任何问题都可以提 [Issue](https://gitcode.com/OpenHarmony-Flutter/fluttertpc_easy_pdf_viewer/issues) ，当然，也非常欢迎发 [PR](https://gitcode.com/OpenHarmony-Flutter/fluttertpc_easy_pdf_viewer/pulls) 共建。

## 开源协议

本项目基于 [BSD-3-Clause](LICENSE) ，请自由地享受和参与开源。
