# EasyPdfViewerPlugin API 版本号汇总

本文档汇总了 `EasyPdfViewerPlugin.ets` 中使用的 HarmonyOS API 及其版本号信息。

## 文件信息

- **源文件**: `ohos/src/main/ets/dev/kaichi/easy_pdf_viewer/EasyPdfViewerPlugin.ets`
- **生成日期**: 2026-04-14
- **参考文档**: `.trae/skills/harmony-next.skills/harmony-next/references/`

---

## 导入模块清单

### 1. @ohos.app.ability.common (Ability公共模块)

| 属性 | 值 |
|------|-----|
| **导入语句** | `import common from '@ohos.app.ability.common';` |
| **所属 Kit** | AbilityKit |
| **模块路径** | `modules/ohos/@ohos.app.ability.common (Ability公共模块).md` |
| **首批接口版本** | API version 9 |
| **系统能力** | SystemCapability.Ability.AbilityRuntime.Core |
| **用途** | 提供 Ability Kit 中常用公共能力的类型定义，包含各类上下文对象 |

**使用场景**:
- `common.Context` - 获取应用上下文，访问 `cacheDir` 等应用目录

---

### 2. @kit.CoreFileKit (核心文件服务)

| 属性 | 值 |
|------|-----|
| **导入语句** | `import { fileIo } from '@kit.CoreFileKit';` |
| **所属 Kit** | CoreFileKit |
| **模块路径** | `modules/ohos/@ohos.file.fs (文件管理).md` |
| **首批接口版本** | API version 9 |
| **系统能力** | SystemCapability.FileManagement.File.FileIO |
| **用途** | 提供基础文件操作能力，包括文件管理、目录管理、文件流式读写等 |

**使用的 API**:
- `fileIo.openSync()` - 同步打开文件
- `fileIo.closeSync()` - 同步关闭文件
- `fileIo.statSync()` - 同步获取文件信息
- `fileIo.readSync()` - 同步读取文件
- `fileIo.accessSync()` - 同步检查文件是否存在
- `fileIo.mkdirSync()` - 同步创建目录
- `fileIo.rmdirSync()` - 同步删除目录
- `fileIo.OpenMode` - 文件打开模式枚举

---

### 3. @kit.ImageKit (图像处理服务)

| 属性 | 值 |
|------|-----|
| **导入语句** | `import { image } from '@kit.ImageKit';` |
| **所属 Kit** | ImageKit |
| **模块路径** | `modules/ohos/@ohos.multimedia.image (图片处理).md` |
| **首批接口版本** | API version 6+ (不同子模块版本不同) |
| **系统能力** | SystemCapability.Multimedia.Image |
| **用途** | 提供图片处理、编码、解码、PixelMap 操作等能力 |

**使用的 API**:
- `image.PixelMap` - 图片像素数据容器
- `image.ImagePacker` - 图片编码器
- `image.createImagePacker()` - 创建图片编码器
- `image.PackingOption` - 图片编码选项

---

### 4. @kit.PerformanceAnalysisKit (性能分析服务)

| 属性 | 值 |
|------|-----|
| **导入语句** | `import { hilog } from '@kit.PerformanceAnalysisKit';` |
| **所属 Kit** | PerformanceAnalysisKit |
| **模块路径** | `modules/ohos/@ohos.hilog (HiLog日志打印).md` |
| **首批接口版本** | API version 7 |
| **系统能力** | SystemCapability.HiviewDFX.HiLog |
| **用途** | 提供日志打印能力，支持不同级别的日志输出 |

**使用的 API**:
- `hilog.error()` - 打印 ERROR 级别日志
- `hilog.warn()` - 打印 WARN 级别日志

---

### 5. @kit.PDFKit (PDF 服务)

| 属性 | 值 |
|------|-----|
| **导入语句** | `import { pdfService } from '@kit.PDFKit';` |
| **所属 Kit** | PDFKit / ReaderKit |
| **模块路径** | `topics/system-services/pdfService（PDF服务）.md` |
| **首批接口版本** | 5.0.0(12) / API version 12 |
| **系统能力** | SystemCapability.OfficeService.PDFService.Core |
| **用途** | 提供 PDF 文档解析、页面渲染、文档编辑等能力 |

**使用的 API**:
- `pdfService.PdfDocument` - PDF 文档类
- `pdfService.PdfPage` - PDF 页面类
- `pdfService.PdfMatrix` - PDF 渲染矩阵
- `pdfService.ParseResult` - PDF 解析结果枚举
- `PdfDocument.loadDocument()` - 加载 PDF 文档
- `PdfDocument.getPageCount()` - 获取页面数量
- `PdfDocument.getPage()` - 获取指定页面
- `PdfDocument.releaseDocument()` - 释放文档资源
- `PdfPage.getWidth()` - 获取页面宽度
- `PdfPage.getHeight()` - 获取页面高度
- `PdfPage.getCustomPagePixelMap()` - 获取页面像素数据

---

### 6. @kit.CryptoArchitectureKit (加解密算法框架)

| 属性 | 值 |
|------|-----|
| **导入语句** | `import { cryptoFramework } from '@kit.CryptoArchitectureKit';` |
| **所属 Kit** | CryptoArchitectureKit |
| **模块路径** | `topics/components/CryptoArchitectureKit.md` |
| **首批接口版本** | API version 12 |
| **系统能力** | SystemCapability.Security.CryptoFramework |
| **用途** | 提供加密算法框架，支持 MD5、SHA 等哈希算法 |

**使用的 API**:
- `cryptoFramework.createMd()` - 创建消息摘要实例
- `cryptoFramework.Md.updateSync()` - 同步更新摘要数据
- `cryptoFramework.Md.digestSync()` - 同步获取摘要结果

---

### 7. @kit.ArkUI (声明式 UI 框架)

| 属性 | 值 |
|------|-----|
| **导入语句** | `import { display } from '@kit.ArkUI';` |
| **所属 Kit** | ArkUI |
| **模块路径** | `modules/ohos/@ohos.display (屏幕属性).md` |
| **首批接口版本** | API version 7 |
| **系统能力** | SystemCapability.WindowManager.WindowManager.Core |
| **用途** | 提供屏幕属性管理、显示设备信息获取等能力 |

**使用的 API**:
- `display.getDefaultDisplaySync()` - 同步获取默认显示设备信息
- `display.Display.width` - 屏幕宽度

---

## API 版本汇总表

| 序号 | 模块/Kit | 导入路径 | 首批版本 | 系统能力 |
|------|----------|----------|----------|----------|
| 1 | AbilityKit | `@ohos.app.ability.common` | API 9 | SystemCapability.Ability.AbilityRuntime.Core |
| 2 | CoreFileKit | `@kit.CoreFileKit` | API 9 | SystemCapability.FileManagement.File.FileIO |
| 3 | ImageKit | `@kit.ImageKit` | API 6+ | SystemCapability.Multimedia.Image |
| 4 | PerformanceAnalysisKit | `@kit.PerformanceAnalysisKit` | API 7 | SystemCapability.HiviewDFX.HiLog |
| 5 | PDFKit | `@kit.PDFKit` | API 12 | SystemCapability.OfficeService.PDFService.Core |
| 6 | CryptoArchitectureKit | `@kit.CryptoArchitectureKit` | API 12 | SystemCapability.Security.CryptoFramework |
| 7 | ArkUI | `@kit.ArkUI` | API 7 | SystemCapability.WindowManager.WindowManager.Core |

---

## 最低 API 版本要求

基于上述分析，**EasyPdfViewerPlugin** 的最低 API 版本要求为 **API version 12**，这是因为：

1. **PDFKit** (`@kit.PDFKit`) 要求 API version 12
2. **CryptoArchitectureKit** (`@kit.CryptoArchitectureKit`) 要求 API version 12

其他模块的最低版本要求：
- CoreFileKit: API 9
- AbilityKit: API 9
- ImageKit: API 6+
- PerformanceAnalysisKit: API 7
- ArkUI (display): API 7

---

## 参考文档导航

根据 `SKILL.md` 的渐进式披露方法，查找本文档涉及的 API 文档路径：

1. **Kit 导航入口**: `references/KITS.md`
2. **API 路径清单**: `references/JsEtsAPIReference/INDEX.md`
3. **具体模块文档**:
   - `references/JsEtsAPIReference/modules/ohos/@ohos.app.ability.common (Ability公共模块).md`
   - `references/JsEtsAPIReference/modules/ohos/@ohos.file.fs (文件管理).md`
   - `references/JsEtsAPIReference/modules/ohos/@ohos.multimedia.image (图片处理).md`
   - `references/JsEtsAPIReference/modules/ohos/@ohos.hilog (HiLog日志打印).md`
   - `references/JsEtsAPIReference/topics/system-services/pdfService（PDF服务）.md`
   - `references/JsEtsAPIReference/topics/components/CryptoArchitectureKit.md`
   - `references/JsEtsAPIReference/modules/ohos/@ohos.display (屏幕属性).md`

---

*文档生成基于 HarmonyOS NEXT 离线参考库 (API 12+)*
