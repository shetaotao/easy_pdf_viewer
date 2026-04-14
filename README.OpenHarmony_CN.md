# easy_pdf_viewer

本项目基于 [easy_pdf_viewer](https://github.com/kaichii/pdf_viewer) 开发。

## 1. 安装与使用

### 1.1 安装方式

进入工程目录并在 `pubspec.yaml` 中添加依赖：

#### pubspec.yaml

```yaml
dependencies:
  easy_pdf_viewer:
    git:
      url: https://gitcode.com/org/OpenHarmony-Flutter/easy_pdf_viewer
      ref: main
```
执行命令：

```bash
flutter pub get
```

### 1.2 使用案例

使用案例详见 [example](example/lib/main.dart)。


## 2. 约束与限制

### 2.1 兼容性

在以下版本中已测试通过：
1. Flutter: 3.22.1-ohos-1.1.0; SDK: 5.0.0(12); IDE: DevEco Studio: 6.0.2.640; ROM: 6.0.0.130 SP18;
2. Flutter: 3.27.5-ohos-1.0.4; SDK: 5.0.0(12); IDE: DevEco Studio: 6.0.2.640; ROM: 6.0.0.130 SP18;
3. Flutter: 3.35.8-ohos-0.0.2; SDK: 5.0.0(12); IDE: DevEco Studio: 6.0.2.640; ROM: 6.0.0.130 SP18;

## 3. 版本和框架对应关系

| Version | 3.7 | 3.22 | 3.27 | 3.35 |
| --- | --- | --- | --- | --- |
| 1.0.0 | ❌ | ✅ | ✅ | ✅ |

## 4. API

> [!TIP] "ohos Support"列为 yes 表示 ohos 平台支持该属性；no 则表示不支持

| 名称 | 说明 | 类型 | 参数及说明 | 输出 | ohos Support |
| --- | --- | --- | --- | --- | --- |
| PDFDocument.fromFile | 从本地文件加载 PDF 文档 | static Future<PDFDocument> | file：PDF文件；clearPreviewCache[可选]：是否清除预览缓存，默认true | PDFDocument | yes |
| PDFDocument.fromURL | 从网络 URL 加载 PDF 文档 | static Future<PDFDocument> | url：PDF链接；headers[可选]：请求头；cacheManager[可选]：缓存管理器；clearPreviewCache[可选]：是否清除预览缓存，默认true | PDFDocument | yes |
| PDFDocument.fromURLWithDownloadProgress | 从 URL 加载并监听下载进度 | static void | url：PDF链接；headers[可选]：请求头；cacheManager[可选]：缓存管理器；clearPreviewCache[可选]：是否清除预览缓存，默认true；downloadProgress：下载进度回调；onDownloadComplete：下载完成回调 | void | yes |
| PDFDocument.fromAsset | 从资源文件加载 PDF 文档 | static Future<PDFDocument> | asset：资源路径；clearPreviewCache[可选]：是否清除预览缓存，默认true | PDFDocument | yes |
| PDFDocument.clearPreviewCache | 清除 PDF 预览缓存 | static Future<void> | 无 | void | yes |
| PDFViewer | PDF 查看器组件 | Widget | document：PDFDocument 实例（必填）；scrollDirection[可选]：滚动方向；lazyLoad[可选]：是否懒加载；showIndicator[可选]：是否显示页码指示器；showPicker[可选]：是否显示页码选择器；showNavigation[可选]：是否显示导航栏；enableSwipeNavigation[可选]：是否启用滑动导航；zoomSteps[可选]：缩放步数；minScale[可选]：最小缩放比例；maxScale[可选]：最大缩放比例；onPageChanged[可选]：页面切换回调；controller[可选]：页面控制器 | Widget | yes |
| PDFPage | PDF 页面组件 | Widget | data：页面数据；pageNumber：页码；onZoomChanged[可选]：缩放回调；zoomSteps[可选]：缩放步数；minScale[可选]：最小缩放；maxScale[可选]：最大缩放；panLimit[可选]：平移限制 | Widget | yes |


## 5. 开源协议

本项目基于 [BSD-3-Clause](LICENSE) 开源。
