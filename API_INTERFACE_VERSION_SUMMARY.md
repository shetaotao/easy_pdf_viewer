# EasyPdfViewerPlugin 接口级别 API 版本号汇总

本文档详细汇总了 `EasyPdfViewerPlugin.ets` 中使用的每个具体接口及其 API 版本号信息。

## 文件信息

- **源文件**: `ohos/src/main/ets/dev/kaichi/easy_pdf_viewer/EasyPdfViewerPlugin.ets`
- **生成日期**: 2026-04-14
- **参考文档**: `.trae/skills/harmony-next.skills/harmony-next/references/`

---

## 1. @ohos.app.ability.common (AbilityKit)

### 1.1 common.Context

| 属性 | 值 |
|------|-----|
| **接口** | `common.Context` |
| **类型** | Type Alias (类型别名) |
| **所属模块** | `@ohos.app.ability.common` |
| **API 版本** | API version 9+ |
| **元服务支持** | API version 11+ |
| **系统能力** | SystemCapability.Ability.AbilityRuntime.Core |
| **用途** | Stage 模型的上下文基类，用于获取应用目录等 |

**使用代码**:
```ets
private applicationContext: common.Context | null = null;
this.applicationContext = binding.getApplicationContext();
```

**访问属性**:
- `context.cacheDir` - 应用缓存目录 (继承自 BaseContext)

---

## 2. @kit.CoreFileKit (核心文件服务)

### 2.1 fileIo.openSync

| 属性 | 值 |
|------|-----|
| **接口** | `fileIo.openSync(path: string, mode?: number): File` |
| **所属模块** | `@ohos.file.fs` |
| **API 版本** | API version 9+ |
| **元服务支持** | API version 11+ |
| **系统能力** | SystemCapability.FileManagement.File.FileIO |
| **用途** | 同步打开文件或目录 |

**使用代码**:
```ets
const file = fileIo.openSync(previewPath, fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.CREATE | fileIo.OpenMode.TRUNC);
```

---

### 2.2 fileIo.closeSync

| 属性 | 值 |
|------|-----|
| **接口** | `fileIo.closeSync(file: number \| File): void` |
| **所属模块** | `@ohos.file.fs` |
| **API 版本** | API version 9+ |
| **元服务支持** | API version 11+ |
| **系统能力** | SystemCapability.FileManagement.File.FileIO |
| **用途** | 同步关闭文件或目录 |

**使用代码**:
```ets
fileIo.closeSync(file.fd);
```

---

### 2.3 fileIo.statSync

| 属性 | 值 |
|------|-----|
| **接口** | `fileIo.statSync(file: string \| number): Stat` |
| **所属模块** | `@ohos.file.fs` |
| **API 版本** | API version 9+ |
| **元服务支持** | API version 11+ |
| **系统能力** | SystemCapability.FileManagement.File.FileIO |
| **用途** | 同步获取文件或目录详细属性信息 |

**使用代码**:
```ets
const stat = fileIo.statSync(file.fd);
const buffer = new ArrayBuffer(stat.size);
```

**访问属性**:
- `stat.size` - 文件大小 (API 9+)
- `stat.mtime` - 文件修改时间 (API 9+)

---

### 2.4 fileIo.readSync

| 属性 | 值 |
|------|-----|
| **接口** | `fileIo.readSync(fd: number, buffer: ArrayBuffer, options?: ReadOptions): number` |
| **所属模块** | `@ohos.file.fs` |
| **API 版本** | API version 9+ |
| **元服务支持** | API version 11+ |
| **系统能力** | SystemCapability.FileManagement.File.FileIO |
| **用途** | 同步从文件读取数据 |

**使用代码**:
```ets
fileIo.readSync(file.fd, buffer);
```

---

### 2.5 fileIo.accessSync

| 属性 | 值 |
|------|-----|
| **接口** | `fileIo.accessSync(path: string, mode?: AccessModeType): boolean` |
| **所属模块** | `@ohos.file.fs` |
| **API 版本** | API version 9+ |
| **元服务支持** | API version 11+ |
| **系统能力** | SystemCapability.FileManagement.File.FileIO |
| **用途** | 同步检查文件或目录是否存在 |

**使用代码**:
```ets
if (fileIo.accessSync(cacheRoot)) {
  fileIo.rmdirSync(cacheRoot);
}
```

---

### 2.6 fileIo.mkdirSync

| 属性 | 值 |
|------|-----|
| **接口** | `fileIo.mkdirSync(path: string): void` |
| **所属模块** | `@ohos.file.fs` |
| **API 版本** | API version 9+ |
| **元服务支持** | API version 11+ |
| **系统能力** | SystemCapability.FileManagement.File.FileIO |
| **用途** | 同步创建目录 |

**使用代码**:
```ets
fileIo.mkdirSync(cacheRoot);
```

---

### 2.7 fileIo.rmdirSync

| 属性 | 值 |
|------|-----|
| **接口** | `fileIo.rmdirSync(path: string): void` |
| **所属模块** | `@ohos.file.fs` |
| **API 版本** | API version 9+ |
| **元服务支持** | API version 11+ |
| **系统能力** | SystemCapability.FileManagement.File.FileIO |
| **用途** | 同步删除目录及其所有子目录和文件 |

**使用代码**:
```ets
fileIo.rmdirSync(cacheRoot);
```

---

### 2.8 fileIo.OpenMode

| 属性 | 值 |
|------|-----|
| **接口** | `fileIo.OpenMode` (枚举) |
| **所属模块** | `@ohos.file.fs` |
| **API 版本** | API version 9+ |
| **元服务支持** | API version 11+ |
| **系统能力** | SystemCapability.FileManagement.File.FileIO |
| **用途** | 文件打开模式枚举 |

**使用值**:
- `fileIo.OpenMode.READ_WRITE` - 读写模式
- `fileIo.OpenMode.CREATE` - 创建文件
- `fileIo.OpenMode.TRUNC` - 截断文件

---

## 3. @kit.ImageKit (图像处理服务)

### 3.1 image.PixelMap

| 属性 | 值 |
|------|-----|
| **接口** | `image.PixelMap` (Interface) |
| **所属模块** | `@ohos.multimedia.image` |
| **API 版本** | API version 7+ (Interface) / API version 6+ (Module) |
| **元服务支持** | API version 11+ |
| **卡片能力** | API version 12+ |
| **系统能力** | SystemCapability.Multimedia.Image.Core |
| **用途** | 图像像素类，用于读取或写入图像数据 |

**使用代码**:
```ets
const pixelMap: image.PixelMap = this.renderPagePixelMap(page);
```

---

### 3.2 image.ImagePacker

| 属性 | 值 |
|------|-----|
| **接口** | `image.ImagePacker` (Interface) |
| **所属模块** | `@ohos.multimedia.image` |
| **API 版本** | API version 6+ |
| **元服务支持** | API version 13+ |
| **系统能力** | SystemCapability.Multimedia.Image.ImagePacker |
| **用途** | 图片编码器，用于图片压缩和编码 |

**使用代码**:
```ets
const packer: image.ImagePacker = image.createImagePacker();
```

---

### 3.3 image.createImagePacker

| 属性 | 值 |
|------|-----|
| **接口** | `image.createImagePacker(): ImagePacker` |
| **所属模块** | `@ohos.multimedia.image` |
| **API 版本** | API version 6+ |
| **元服务支持** | API version 13+ |
| **系统能力** | SystemCapability.Multimedia.Image.ImagePacker |
| **用途** | 创建 ImagePacker 实例 |

**使用代码**:
```ets
const packer: image.ImagePacker = image.createImagePacker();
```

---

### 3.4 image.PackingOption

| 属性 | 值 |
|------|-----|
| **接口** | `image.PackingOption` (Interface) |
| **所属模块** | `@ohos.multimedia.image` |
| **API 版本** | API version 6+ |
| **系统能力** | SystemCapability.Multimedia.Image.ImagePacker |
| **用途** | 图片编码选项 |

**使用代码**:
```ets
const options: image.PackingOption = { format: 'image/png', quality: 100 };
```

**属性**:
- `format: string` - 编码格式 (如 'image/png')
- `quality: number` - 编码质量 (0-100)

---

### 3.5 image.ImagePacker.packToFile

| 属性 | 值 |
|------|-----|
| **接口** | `image.ImagePacker.packToFile(source: PixelMap, fd: number, options: PackingOption): Promise<void>` |
| **所属模块** | `@ohos.multimedia.image` |
| **API 版本** | API version 6+ |
| **元服务支持** | API version 13+ |
| **系统能力** | SystemCapability.Multimedia.Image.ImagePacker |
| **用途** | 将 PixelMap 编码并写入文件 |

**使用代码**:
```ets
await packer.packToFile(pixelMap, file.fd, options);
```

---

## 4. @kit.PerformanceAnalysisKit (性能分析服务)

### 4.1 hilog.error

| 属性 | 值 |
|------|-----|
| **接口** | `hilog.error(domain: number, tag: string, format: string, ...args: any[]): void` |
| **所属模块** | `@ohos.hilog` |
| **API 版本** | API version 7+ |
| **元服务支持** | API version 11+ |
| **系统能力** | SystemCapability.HiviewDFX.HiLog |
| **用途** | 打印 ERROR 级别日志 |

**使用代码**:
```ets
hilog.error(0x0000, TAG, `getNumberOfPages failed: ${this.toErrorMessage(error)}`);
```

---

### 4.2 hilog.warn

| 属性 | 值 |
|------|-----|
| **接口** | `hilog.warn(domain: number, tag: string, format: string, ...args: any[]): void` |
| **所属模块** | `@ohos.hilog` |
| **API 版本** | API version 7+ |
| **元服务支持** | API version 11+ |
| **系统能力** | SystemCapability.HiviewDFX.HiLog |
| **用途** | 打印 WARN 级别日志 |

**使用代码**:
```ets
hilog.warn(0x0000, TAG, `Failed to calculate file hash: ${this.toErrorMessage(error)}`);
```

---

## 5. @kit.PDFKit (PDF 服务)

### 5.1 pdfService.PdfDocument

| 属性 | 值 |
|------|-----|
| **接口** | `pdfService.PdfDocument` (Class) |
| **所属模块** | `@kit.PDFKit` |
| **API 版本** | 5.0.0(12) / API version 12 |
| **系统能力** | SystemCapability.OfficeService.PDFService.Core |
| **用途** | PDF 文件类，用于加载、操作 PDF 文档 |

**使用代码**:
```ets
const document: pdfService.PdfDocument = new pdfService.PdfDocument();
```

---

### 5.2 pdfService.PdfDocument.constructor

| 属性 | 值 |
|------|-----|
| **接口** | `new pdfService.PdfDocument()` |
| **所属模块** | `@kit.PDFKit` |
| **API 版本** | 5.0.0(12) |
| **系统能力** | SystemCapability.OfficeService.PDFService.Core |
| **用途** | 构造函数，创建 PdfDocument 实例 |

---

### 5.3 pdfService.PdfDocument.loadDocument

| 属性 | 值 |
|------|-----|
| **接口** | `pdfService.PdfDocument.loadDocument(path: string, password?: string, onProgress?: (progress: number) => number): ParseResult` |
| **所属模块** | `@kit.PDFKit` |
| **API 版本** | 5.0.0(12) |
| **系统能力** | SystemCapability.OfficeService.PDFService.Core |
| **用途** | 加载指定文件路径的 PDF 文档 |

**使用代码**:
```ets
const parseResult: pdfService.ParseResult = document.loadDocument(filePath);
```

---

### 5.4 pdfService.PdfDocument.getPageCount

| 属性 | 值 |
|------|-----|
| **接口** | `pdfService.PdfDocument.getPageCount(): number` |
| **所属模块** | `@kit.PDFKit` |
| **API 版本** | 5.0.0(12) |
| **系统能力** | SystemCapability.OfficeService.PDFService.Core |
| **用途** | 获取文档页数 |

**使用代码**:
```ets
const pageCount: number = document.getPageCount();
```

---

### 5.5 pdfService.PdfDocument.getPage

| 属性 | 值 |
|------|-----|
| **接口** | `pdfService.PdfDocument.getPage(index: number): PdfPage` |
| **所属模块** | `@kit.PDFKit` |
| **API 版本** | 5.0.0(12) |
| **系统能力** | SystemCapability.OfficeService.PDFService.Core |
| **用途** | 获取指定页的对象 |

**使用代码**:
```ets
const page: pdfService.PdfPage = document.getPage(pageNumber - 1);
```

---

### 5.6 pdfService.PdfDocument.releaseDocument

| 属性 | 值 |
|------|-----|
| **接口** | `pdfService.PdfDocument.releaseDocument(): void` |
| **所属模块** | `@kit.PDFKit` |
| **API 版本** | 5.0.0(12) |
| **系统能力** | SystemCapability.OfficeService.PDFService.Core |
| **用途** | 释放 PDF 文档资源 |

**使用代码**:
```ets
document.releaseDocument();
```

---

### 5.7 pdfService.PdfPage

| 属性 | 值 |
|------|-----|
| **接口** | `pdfService.PdfPage` (Class) |
| **所属模块** | `@kit.PDFKit` |
| **API 版本** | 5.0.0(12) |
| **系统能力** | SystemCapability.OfficeService.PDFService.Core |
| **用途** | PDF 页面类 |

---

### 5.8 pdfService.PdfPage.getWidth

| 属性 | 值 |
|------|-----|
| **接口** | `pdfService.PdfPage.getWidth(): number` |
| **所属模块** | `@kit.PDFKit` |
| **API 版本** | 5.0.0(12) |
| **系统能力** | SystemCapability.OfficeService.PDFService.Core |
| **用途** | 获取当前页的宽（单位：Points） |

**使用代码**:
```ets
const pageWidthPt: number = page.getWidth();
```

---

### 5.9 pdfService.PdfPage.getHeight

| 属性 | 值 |
|------|-----|
| **接口** | `pdfService.PdfPage.getHeight(): number` |
| **所属模块** | `@kit.PDFKit` |
| **API 版本** | 5.0.0(12) |
| **系统能力** | SystemCapability.OfficeService.PDFService.Core |
| **用途** | 获取当前页的高（单位：Points） |

**使用代码**:
```ets
const pageHeightPt: number = page.getHeight();
```

---

### 5.10 pdfService.PdfPage.getCustomPagePixelMap

| 属性 | 值 |
|------|-----|
| **接口** | `pdfService.PdfPage.getCustomPagePixelMap(matrix: PdfMatrix, isGray: boolean, drawAnnotations: boolean): image.PixelMap` |
| **所属模块** | `@kit.PDFKit` |
| **API 版本** | 5.0.0(12) |
| **系统能力** | SystemCapability.OfficeService.PDFService.Core |
| **用途** | 获取指定 PdfPage 区间的图片内容 |

**使用代码**:
```ets
const pixelMap: image.PixelMap = page.getCustomPagePixelMap(matrix, false, true);
```

---

### 5.11 pdfService.PdfMatrix

| 属性 | 值 |
|------|-----|
| **接口** | `pdfService.PdfMatrix` (Class) |
| **所属模块** | `@kit.PDFKit` |
| **API 版本** | 5.0.0(12) |
| **系统能力** | SystemCapability.OfficeService.PDFService.Core |
| **用途** | PDF 页面的坐标变换矩阵 |

**使用代码**:
```ets
const matrix: pdfService.PdfMatrix = new pdfService.PdfMatrix();
matrix.width = Math.ceil(pageWidthPx);
matrix.height = Math.ceil(pageHeightPx);
matrix.rotate = 0;
```

**属性**:
- `x: number` - 图像左上角相对于页面的 X 偏移
- `y: number` - 图像左上角相对于页面的 Y 偏移
- `width: number` - 相对于原始页面的宽度缩放比例
- `height: number` - 相对于原始页面的高度缩放比例
- `rotate: number` - 旋转角度

---

### 5.12 pdfService.ParseResult

| 属性 | 值 |
|------|-----|
| **接口** | `pdfService.ParseResult` (Enum) |
| **所属模块** | `@kit.PDFKit` |
| **API 版本** | 5.0.0(12) |
| **系统能力** | SystemCapability.OfficeService.PDFService.Core |
| **用途** | PDF 解析结果枚举 |

**使用代码**:
```ets
if (parseResult !== pdfService.ParseResult.PARSE_SUCCESS) {
  document.releaseDocument();
  throw new Error(`Failed to load PDF document, parse result: ${parseResult}`);
}
```

**枚举值**:
- `PARSE_SUCCESS` - 解析成功

---

## 6. @kit.CryptoArchitectureKit (加解密算法框架)

### 6.1 cryptoFramework.createMd

| 属性 | 值 |
|------|-----|
| **接口** | `cryptoFramework.createMd(algName: string): Md` |
| **所属模块** | `@ohos.security.cryptoFramework` |
| **API 版本** | API version 9+ |
| **元服务支持** | API version 12+ |
| **系统能力** | SystemCapability.Security.CryptoFramework.MessageDigest (API 12+) |
| **历史系统能力** | SystemCapability.Security.CryptoFramework (API 9-11) |
| **用途** | 生成 Md 实例，用于消息摘要计算 |

**使用代码**:
```ets
const md = cryptoFramework.createMd('MD5');
```

---

### 6.2 cryptoFramework.Md

| 属性 | 值 |
|------|-----|
| **接口** | `cryptoFramework.Md` (Class) |
| **所属模块** | `@ohos.security.cryptoFramework` |
| **API 版本** | API version 9+ |
| **元服务支持** | API version 12+ |
| **系统能力** | SystemCapability.Security.CryptoFramework.MessageDigest (API 12+) |
| **历史系统能力** | SystemCapability.Security.CryptoFramework (API 9-11) |
| **用途** | 消息摘要计算类 |

---

### 6.3 cryptoFramework.Md.updateSync

| 属性 | 值 |
|------|-----|
| **接口** | `cryptoFramework.Md.updateSync(input: DataBlob): void` |
| **所属模块** | `@ohos.security.cryptoFramework` |
| **API 版本** | API version 12+ |
| **元服务支持** | API version 12+ |
| **系统能力** | SystemCapability.Security.CryptoFramework.MessageDigest |
| **用途** | 同步更新摘要数据 |

**使用代码**:
```ets
md.updateSync({ data: new Uint8Array(buffer) });
```

---

### 6.4 cryptoFramework.Md.digestSync

| 属性 | 值 |
|------|-----|
| **接口** | `cryptoFramework.Md.digestSync(): DataBlob` |
| **所属模块** | `@ohos.security.cryptoFramework` |
| **API 版本** | API version 12+ |
| **元服务支持** | API version 12+ |
| **系统能力** | SystemCapability.Security.CryptoFramework.MessageDigest |
| **用途** | 同步获取摘要结果 |

**使用代码**:
```ets
const hashResult = md.digestSync();
return this.bufferToHex(hashResult.data);
```

---

### 6.5 cryptoFramework.DataBlob

| 属性 | 值 |
|------|-----|
| **接口** | `cryptoFramework.DataBlob` (Interface) |
| **所属模块** | `@ohos.security.cryptoFramework` |
| **API 版本** | API version 9+ |
| **元服务支持** | API version 11+ |
| **系统能力** | SystemCapability.Security.CryptoFramework |
| **用途** | 数据块类型，用于传递二进制数据 |

**使用代码**:
```ets
md.updateSync({ data: new Uint8Array(buffer) });
```

**属性**:
- `data: Uint8Array` - 数据内容

---

## 7. @kit.ArkUI (声明式 UI 框架)

### 7.1 display.getDefaultDisplaySync

| 属性 | 值 |
|------|-----|
| **接口** | `display.getDefaultDisplaySync(): Display` |
| **所属模块** | `@ohos.display` |
| **API 版本** | API version 9+ |
| **元服务支持** | API version 11+ |
| **系统能力** | SystemCapability.WindowManager.WindowManager.Core |
| **用途** | 同步获取当前默认的 Display 对象 |

**使用代码**:
```ets
const displayInfo = display.getDefaultDisplaySync();
const pageWidthPx: number = displayInfo.width;
```

---

### 7.2 display.Display

| 属性 | 值 |
|------|-----|
| **接口** | `display.Display` (Interface) |
| **所属模块** | `@ohos.display` |
| **API 版本** | API version 7+ |
| **元服务支持** | API version 12+ |
| **系统能力** | SystemCapability.WindowManager.WindowManager.Core |
| **用途** | 显示设备信息 |

**访问属性**:
- `width: number` - 屏幕宽度 (px)
- `height: number` - 屏幕高度 (px)

---

## 接口版本汇总表

### 按 Kit 分组

| Kit | 接口数量 | 最低 API 版本 | 关键接口 |
|-----|----------|---------------|----------|
| AbilityKit | 1 | API 9 | `common.Context` |
| CoreFileKit | 8 | API 9 | `openSync`, `closeSync`, `statSync`, `readSync`, `accessSync`, `mkdirSync`, `rmdirSync` |
| ImageKit | 5 | API 6+ | `PixelMap`, `ImagePacker`, `createImagePacker`, `PackingOption`, `packToFile` |
| PerformanceAnalysisKit | 2 | API 7 | `hilog.error`, `hilog.warn` |
| PDFKit | 9 | API 12 | `PdfDocument`, `PdfPage`, `PdfMatrix`, `ParseResult` |
| CryptoArchitectureKit | 4 | API 12 | `createMd`, `Md.updateSync`, `Md.digestSync` |
| ArkUI | 2 | API 9 | `display.getDefaultDisplaySync`, `display.Display` |

### 按 API 版本分组

| API 版本 | 接口数量 | 接口列表 |
|----------|----------|----------|
| API 6+ | 5 | ImageKit 基础接口 |
| API 7+ | 2 | hilog 接口 |
| API 9+ | 13 | AbilityKit, CoreFileKit, ArkUI display |
| API 12+ | 13 | PDFKit, CryptoArchitectureKit (同步接口) |

---

## 最低 API 版本要求

**整体最低要求: API version 12**

限制因素：
1. **PDFKit** 所有接口要求 API version 12
2. **CryptoArchitectureKit** 的同步接口 (`updateSync`, `digestSync`) 要求 API version 12

如果不使用 MD5 哈希功能（用于缓存文件命名），最低可降至 API version 9。

---

## 参考文档路径

根据 `SKILL.md` 导航：

1. **Kit 导航**: `references/KITS.md`
2. **API 索引**: `references/JsEtsAPIReference/INDEX.md`
3. **详细文档**:
   - `references/JsEtsAPIReference/modules/ohos/@ohos.app.ability.common (Ability公共模块).md`
   - `references/JsEtsAPIReference/modules/ohos/@ohos.file.fs (文件管理).md`
   - `references/JsEtsAPIReference/modules/ohos/@ohos.multimedia.image (图片处理).md`
   - `references/JsEtsAPIReference/modules/ohos/@ohos.hilog (HiLog日志打印).md`
   - `references/JsEtsAPIReference/topics/system-services/pdfService（PDF服务）.md`
   - `references/JsEtsAPIReference/modules/ohos/@ohos.security.cryptoFramework (加解密算法库框架).md`
   - `references/JsEtsAPIReference/modules/ohos/@ohos.display (屏幕属性).md`

---

*文档生成基于 HarmonyOS NEXT 离线参考库 (API 12+)*
