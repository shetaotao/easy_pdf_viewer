/*
 * Copyright (C) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import common from '@ohos.app.ability.common';
import {
  FlutterPlugin,
  FlutterPluginBinding,
  MethodCall,
  MethodCallHandler,
  MethodChannel,
  MethodResult,
} from '@ohos/flutter_ohos';
import { fileIo } from '@kit.CoreFileKit';
import { image } from '@kit.ImageKit';
import { pdfService } from '@kit.PDFKit';
import { cryptoFramework } from '@kit.CryptoArchitectureKit';
import { display } from '@kit.ArkUI';

const TAG: string = 'EasyPdfViewerPlugin';
const CHANNEL_NAME: string = 'easy_pdf_viewer_plugin';
const FILE_PREFIX: string = 'FlutterEasyPdfViewerPlugin';

/** EasyPdfViewerPlugin **/
export default class EasyPdfViewerPlugin implements FlutterPlugin, MethodCallHandler {
  private channel: MethodChannel | null = null;
  private applicationContext: common.Context | null = null;

  getUniqueClassName(): string {
    return 'EasyPdfViewerPlugin';
  }

  onAttachedToEngine(binding: FlutterPluginBinding): void {
    this.applicationContext = binding.getApplicationContext();
    this.channel = new MethodChannel(binding.getBinaryMessenger(), CHANNEL_NAME);
    this.channel.setMethodCallHandler(this);
  }

  onDetachedFromEngine(binding: FlutterPluginBinding): void {
    if (this.channel !== null) {
      this.channel.setMethodCallHandler(null);
      this.channel = null;
    }
    this.applicationContext = null;
  }

  onMethodCall(call: MethodCall, result: MethodResult): void {
    if (call.method === 'getNumberOfPages') {
      void this.handleGetNumberOfPages(call, result);
      return;
    }

    if (call.method === 'getPage') {
      void this.handleGetPage(call, result);
      return;
    }

    if (call.method === 'clearCacheDir') {
      try {
        this.clearCacheDirInternal();
        result.success(null);
      } catch (error) {
        result.error('clear_cache_failed', this.toErrorMessage(error), null);
      }
      return;
    }

    result.notImplemented();
  }

  private async handleGetNumberOfPages(call: MethodCall, result: MethodResult): Promise<void> {
    const filePath: string = this.requireStringArgument(call, 'filePath');
    const shouldClearCache: boolean = this.getBooleanArgument(call, 'clearCacheDir', false);

    try {
      if (shouldClearCache) {
        this.clearCacheDirInternal();
      }

      const document: pdfService.PdfDocument = this.loadDocument(filePath);
      try {
        result.success(String(document.getPageCount()));
      } finally {
        document.releaseDocument();
      }
    } catch (error) {
      console.error(TAG, `getNumberOfPages failed: ${this.toErrorMessage(error)}`);
      result.error('pdf_read_failed', this.toErrorMessage(error), null);
    }
  }

  private async handleGetPage(call: MethodCall, result: MethodResult): Promise<void> {
    const filePath: string = this.requireStringArgument(call, 'filePath');
    const requestedPageNumber: number = this.requireNumberArgument(call, 'pageNumber');

    try {
      const document: pdfService.PdfDocument = this.loadDocument(filePath);
      try {
        const pageCount: number = document.getPageCount();
        const pageNumber: number = this.normalizePageNumber(requestedPageNumber, pageCount);
        const page: pdfService.PdfPage = document.getPage(pageNumber - 1);
        const pixelMap: image.PixelMap = this.renderPagePixelMap(page);
        const previewPath: string = await this.writePreviewToCache(pixelMap, filePath, pageNumber);
        result.success(previewPath);
      } finally {
        document.releaseDocument();
      }
    } catch (error) {
      console.error(TAG, `getPage failed: ${this.toErrorMessage(error)}`);
      result.error('pdf_render_failed', this.toErrorMessage(error), null);
    }
  }

  private loadDocument(filePath: string): pdfService.PdfDocument {
    const document: pdfService.PdfDocument = new pdfService.PdfDocument();
    const parseResult: pdfService.ParseResult = document.loadDocument(filePath);
    if (parseResult !== pdfService.ParseResult.PARSE_SUCCESS) {
      document.releaseDocument();
      throw new Error(`Failed to load PDF document, parse result: ${parseResult}`);
    }
    return document;
  }

  private renderPagePixelMap(page: pdfService.PdfPage): image.PixelMap {
    const pageWidthPt: number = page.getWidth();
    const pageHeightPt: number = page.getHeight();
    const displayInfo = display.getDefaultDisplaySync();
    const pageWidthPx: number = displayInfo.width;
    const docRatio: number = pageWidthPt / pageHeightPt;
    const pageHeightPx: number = pageWidthPx / docRatio;
    const matrix: pdfService.PdfMatrix = new pdfService.PdfMatrix();
    matrix.width = Math.ceil(pageWidthPx);
    matrix.height = Math.ceil(pageHeightPx);
    matrix.rotate = 0;
    return page.getCustomPagePixelMap(matrix, false, true);
  }

  private async writePreviewToCache(pixelMap: image.PixelMap, filePath: string, pageNumber: number): Promise<string> {
    const fileHash: string = this.calculateFileHash(filePath);
    const previewPath: string = `${this.getPluginCacheDir()}/${this.getCacheFileName(filePath, pageNumber, fileHash)}`;
    const file = fileIo.openSync(
      previewPath,
      fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.CREATE | fileIo.OpenMode.TRUNC,
    );
    try {
      const packer: image.ImagePacker = image.createImagePacker();
      const options: image.PackingOption = { format: 'image/png', quality: 100 };
      await packer.packToFile(pixelMap, file.fd, options);
      return previewPath;
    } finally {
      fileIo.closeSync(file.fd);
    }
  }

  private calculateFileHash(filePath: string): string {
    try {
      const file = fileIo.openSync(filePath, fileIo.OpenMode.READ_ONLY);
      try {
        const stat = fileIo.statSync(file.fd);
        const buffer = new ArrayBuffer(stat.size);
        fileIo.readSync(file.fd, buffer);
        const md = cryptoFramework.createMd('MD5');
        md.updateSync({ data: new Uint8Array(buffer) });
        const hashResult = md.digestSync();
        return this.bufferToHex(hashResult.data);
      } finally {
        fileIo.closeSync(file.fd);
      }
    } catch (error) {
      console.error(TAG, `Failed to calculate file hash: ${this.toErrorMessage(error)}`);
      // Fallback to using file modification time as hash
      try {
        const stat = fileIo.statSync(filePath);
        return String(stat.mtime);
      } catch {
        return '0';
      }
    }
  }

  private bufferToHex(buffer: Uint8Array): string {
    return Array.from(buffer)
      .map(b => b.toString(16).padStart(2, '0'))
      .join('');
  }

  private clearCacheDirInternal(): void {
    const cacheRoot: string = this.getCacheRootPath();
    if (fileIo.accessSync(cacheRoot)) {
      fileIo.rmdirSync(cacheRoot);
    }
    fileIo.mkdirSync(cacheRoot);
  }

  private getPluginCacheDir(): string {
    const cacheRoot: string = this.getCacheRootPath();
    if (!fileIo.accessSync(cacheRoot)) {
      fileIo.mkdirSync(cacheRoot);
    }
    return cacheRoot;
  }

  private getCacheRootPath(): string {
    return `${this.requireContext().cacheDir}/${FILE_PREFIX}`;
  }

  private getCacheFileName(filePath: string, pageNumber: number, fileHash: string): string {
    const lastSlashIndex: number = filePath.lastIndexOf('/');
    const fileName: string = lastSlashIndex >= 0 ? filePath.substring(lastSlashIndex + 1) : filePath;
    const lastDotIndex: number = fileName.lastIndexOf('.');
    const fileNameWithoutExt: string = lastDotIndex > 0 ? fileName.substring(0, lastDotIndex) : fileName;
    // Include file content hash in cache key to distinguish different PDFs with same filename
    return `${FILE_PREFIX}-${fileNameWithoutExt}-${fileHash.substring(0, 8)}-${pageNumber}.png`;
  }

  private normalizePageNumber(pageNumber: number, pageCount: number): number {
    if (pageCount <= 0) {
      throw new Error('PDF document has no pages');
    }
    if (pageNumber <= 1) {
      return 1;
    }
    if (pageNumber > pageCount) {
      return pageCount;
    }
    return pageNumber;
  }

  private requireContext(): common.Context {
    if (this.applicationContext === null) {
      throw new Error('Application context is not available');
    }
    return this.applicationContext;
  }

  private requireStringArgument(call: MethodCall, key: string): string {
    const value: string | null = call.argument(key) as string | null;
    if (typeof value !== 'string' || value.length === 0) {
      throw new Error(`Missing or invalid string argument: ${key}`);
    }
    return value;
  }

  private requireNumberArgument(call: MethodCall, key: string): number {
    const value: number | null = call.argument(key) as number | null;
    if (typeof value !== 'number') {
      throw new Error(`Missing or invalid numeric argument: ${key}`);
    }
    return value;
  }

  private getBooleanArgument(call: MethodCall, key: string, fallback: boolean): boolean {
    const value: boolean | null = call.argument(key) as boolean | null;
    if (value === null) {
      return fallback;
    }
    if (typeof value !== 'boolean') {
      throw new Error(`Invalid boolean argument: ${key}`);
    }
    return value;
  }

  private toErrorMessage(error: Object): string {
    return `${error}`;
  }
}