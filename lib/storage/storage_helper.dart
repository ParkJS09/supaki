import 'dart:io';
import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/supaki_core.dart';

/// Supabase 스토리지를 쉽게 사용할 수 있게 해주는 헬퍼 클래스
class SupakiStorage {
  static SupabaseClient get _client => SupakiClient.instance.supabase;

  /// 버킷 생성
  static Future<String> createBucket({
    required String bucketName,
    bool public = false,
    int? fileSizeLimit,
    List<String>? allowedMimeTypes,
  }) async {
    try {
      SupakiLogger.info('버킷 생성: $bucketName', name: 'SupakiStorage');

      final response = await _client.storage.createBucket(
        bucketName,
        BucketOptions(
          public: public,
          fileSizeLimit: fileSizeLimit,
          allowedMimeTypes: allowedMimeTypes,
        ),
      );

      SupakiLogger.info('버킷 생성 성공: $bucketName', name: 'SupakiStorage');
      return response;
    } catch (e) {
      SupakiLogger.error(
        '버킷 생성 실패: $bucketName',
        error: e,
        name: 'SupakiStorage',
      );
      throw SupakiStorageException('버킷 생성에 실패했습니다: ${e.toString()}');
    }
  }

  /// 버킷 목록 조회
  static Future<List<Bucket>> getBuckets() async {
    try {
      SupakiLogger.info('버킷 목록 조회', name: 'SupakiStorage');

      final response = await _client.storage.listBuckets();

      SupakiLogger.info(
        '버킷 목록 조회 성공: ${response.length}개',
        name: 'SupakiStorage',
      );
      return response;
    } catch (e) {
      SupakiLogger.error('버킷 목록 조회 실패', error: e, name: 'SupakiStorage');
      throw SupakiStorageException('버킷 목록 조회에 실패했습니다: ${e.toString()}');
    }
  }

  /// 버킷 정보 조회
  static Future<Bucket> getBucket(String bucketName) async {
    try {
      SupakiLogger.info('버킷 정보 조회: $bucketName', name: 'SupakiStorage');

      final response = await _client.storage.getBucket(bucketName);

      SupakiLogger.info('버킷 정보 조회 성공: $bucketName', name: 'SupakiStorage');
      return response;
    } catch (e) {
      SupakiLogger.error(
        '버킷 정보 조회 실패: $bucketName',
        error: e,
        name: 'SupakiStorage',
      );
      throw SupakiStorageException('버킷 정보 조회에 실패했습니다: ${e.toString()}');
    }
  }

  /// 버킷 업데이트
  static Future<String> updateBucket({
    required String bucketName,
    bool? public,
    int? fileSizeLimit,
    List<String>? allowedMimeTypes,
  }) async {
    try {
      SupakiLogger.info('버킷 업데이트: $bucketName', name: 'SupakiStorage');

      final response = await _client.storage.updateBucket(
        bucketName,
        BucketOptions(
          public: public,
          fileSizeLimit: fileSizeLimit,
          allowedMimeTypes: allowedMimeTypes,
        ),
      );

      SupakiLogger.info('버킷 업데이트 성공: $bucketName', name: 'SupakiStorage');
      return response;
    } catch (e) {
      SupakiLogger.error(
        '버킷 업데이트 실패: $bucketName',
        error: e,
        name: 'SupakiStorage',
      );
      throw SupakiStorageException('버킷 업데이트에 실패했습니다: ${e.toString()}');
    }
  }

  /// 버킷 비우기
  static Future<List<FileObject>> emptyBucket(String bucketName) async {
    try {
      SupakiLogger.info('버킷 비우기: $bucketName', name: 'SupakiStorage');

      final response = await _client.storage.emptyBucket(bucketName);

      SupakiLogger.info('버킷 비우기 성공: $bucketName', name: 'SupakiStorage');
      return response;
    } catch (e) {
      SupakiLogger.error(
        '버킷 비우기 실패: $bucketName',
        error: e,
        name: 'SupakiStorage',
      );
      throw SupakiStorageException('버킷 비우기에 실패했습니다: ${e.toString()}');
    }
  }

  /// 버킷 삭제
  static Future<String> deleteBucket(String bucketName) async {
    try {
      SupakiLogger.info('버킷 삭제: $bucketName', name: 'SupakiStorage');

      final response = await _client.storage.deleteBucket(bucketName);

      SupakiLogger.info('버킷 삭제 성공: $bucketName', name: 'SupakiStorage');
      return response;
    } catch (e) {
      SupakiLogger.error(
        '버킷 삭제 실패: $bucketName',
        error: e,
        name: 'SupakiStorage',
      );
      throw SupakiStorageException('버킷 삭제에 실패했습니다: ${e.toString()}');
    }
  }

  /// 파일 업로드 (Uint8List)
  static Future<String> uploadFile({
    required String bucketName,
    required String fileName,
    required Uint8List fileBytes,
    String? contentType,
    bool upsert = false,
  }) async {
    try {
      SupakiLogger.info('파일 업로드: $bucketName/$fileName', name: 'SupakiStorage');

      final response = await _client.storage.from(bucketName).uploadBinary(
            fileName,
            fileBytes,
            fileOptions: FileOptions(contentType: contentType, upsert: upsert),
          );

      SupakiLogger.info(
        '파일 업로드 성공: $bucketName/$fileName',
        name: 'SupakiStorage',
      );
      return response;
    } catch (e) {
      SupakiLogger.error(
        '파일 업로드 실패: $bucketName/$fileName',
        error: e,
        name: 'SupakiStorage',
      );
      throw SupakiStorageException('파일 업로드에 실패했습니다: ${e.toString()}');
    }
  }

  /// 파일 업로드 (File)
  static Future<String> uploadFileFromPath({
    required String bucketName,
    required String fileName,
    required String filePath,
    String? contentType,
    bool upsert = false,
  }) async {
    try {
      SupakiLogger.info(
        '파일 업로드 (경로): $bucketName/$fileName',
        name: 'SupakiStorage',
      );

      final file = File(filePath);
      final fileBytes = await file.readAsBytes();

      return await uploadFile(
        bucketName: bucketName,
        fileName: fileName,
        fileBytes: fileBytes,
        contentType: contentType,
        upsert: upsert,
      );
    } catch (e) {
      SupakiLogger.error(
        '파일 업로드 실패 (경로): $bucketName/$fileName',
        error: e,
        name: 'SupakiStorage',
      );
      throw SupakiStorageException('파일 업로드에 실패했습니다: ${e.toString()}');
    }
  }

  /// 파일 다운로드
  static Future<Uint8List> downloadFile({
    required String bucketName,
    required String fileName,
  }) async {
    try {
      SupakiLogger.info(
        '파일 다운로드: $bucketName/$fileName',
        name: 'SupakiStorage',
      );

      final response =
          await _client.storage.from(bucketName).download(fileName);

      SupakiLogger.info(
        '파일 다운로드 성공: $bucketName/$fileName',
        name: 'SupakiStorage',
      );
      return response;
    } catch (e) {
      SupakiLogger.error(
        '파일 다운로드 실패: $bucketName/$fileName',
        error: e,
        name: 'SupakiStorage',
      );
      throw SupakiStorageException('파일 다운로드에 실패했습니다: ${e.toString()}');
    }
  }

  /// 파일 공개 URL 가져오기
  static String getPublicUrl({
    required String bucketName,
    required String fileName,
    Map<String, String>? queryParameters,
  }) {
    try {
      SupakiLogger.info(
        '공개 URL 생성: $bucketName/$fileName',
        name: 'SupakiStorage',
      );

      final url = _client.storage
          .from(bucketName)
          .getPublicUrl(fileName, queryParameters: queryParameters);

      SupakiLogger.info(
        '공개 URL 생성 성공: $bucketName/$fileName',
        name: 'SupakiStorage',
      );
      return url;
    } catch (e) {
      SupakiLogger.error(
        '공개 URL 생성 실패: $bucketName/$fileName',
        error: e,
        name: 'SupakiStorage',
      );
      throw SupakiStorageException('공개 URL 생성에 실패했습니다: ${e.toString()}');
    }
  }

  /// 서명된 URL 생성
  static Future<String> createSignedUrl({
    required String bucketName,
    required String fileName,
    required int expiresInSeconds,
    Map<String, String>? queryParameters,
  }) async {
    try {
      SupakiLogger.info(
        '서명된 URL 생성: $bucketName/$fileName',
        name: 'SupakiStorage',
      );

      final response = await _client.storage.from(bucketName).createSignedUrl(
            fileName,
            expiresInSeconds,
            queryParameters: queryParameters,
          );

      SupakiLogger.info(
        '서명된 URL 생성 성공: $bucketName/$fileName',
        name: 'SupakiStorage',
      );
      return response;
    } catch (e) {
      SupakiLogger.error(
        '서명된 URL 생성 실패: $bucketName/$fileName',
        error: e,
        name: 'SupakiStorage',
      );
      throw SupakiStorageException('서명된 URL 생성에 실패했습니다: ${e.toString()}');
    }
  }

  /// 여러 서명된 URL 생성
  static Future<List<SignedUrl>> createSignedUrls({
    required String bucketName,
    required List<String> fileNames,
    required int expiresInSeconds,
  }) async {
    try {
      SupakiLogger.info(
        '다중 서명된 URL 생성: $bucketName (${fileNames.length}개)',
        name: 'SupakiStorage',
      );

      final response = await _client.storage
          .from(bucketName)
          .createSignedUrls(fileNames, expiresInSeconds);

      SupakiLogger.info('다중 서명된 URL 생성 성공: $bucketName', name: 'SupakiStorage');
      return response;
    } catch (e) {
      SupakiLogger.error(
        '다중 서명된 URL 생성 실패: $bucketName',
        error: e,
        name: 'SupakiStorage',
      );
      throw SupakiStorageException('다중 서명된 URL 생성에 실패했습니다: ${e.toString()}');
    }
  }

  /// 파일 목록 조회
  static Future<List<FileObject>> listFiles({
    required String bucketName,
    String? path,
    String? search,
    int? limit,
    int? offset,
    String? sortBy,
    SortOrder? sortOrder,
  }) async {
    try {
      SupakiLogger.info('파일 목록 조회: $bucketName', name: 'SupakiStorage');

      final response = await _client.storage.from(bucketName).list(
            path: path,
            searchOptions:
                search != null ? SearchOptions(search: search) : null,
            listOptions: ListOptions(
              limit: limit,
              offset: offset,
              sortBy: sortBy != null
                  ? SortBy(column: sortBy, order: sortOrder)
                  : null,
            ),
          );

      SupakiLogger.info(
        '파일 목록 조회 성공: $bucketName (${response.length}개)',
        name: 'SupakiStorage',
      );
      return response;
    } catch (e) {
      SupakiLogger.error(
        '파일 목록 조회 실패: $bucketName',
        error: e,
        name: 'SupakiStorage',
      );
      throw SupakiStorageException('파일 목록 조회에 실패했습니다: ${e.toString()}');
    }
  }

  /// 파일 정보 조회
  static Future<FileObject> getFileInfo({
    required String bucketName,
    required String fileName,
  }) async {
    try {
      SupakiLogger.info(
        '파일 정보 조회: $bucketName/$fileName',
        name: 'SupakiStorage',
      );

      final response = await _client.storage.from(bucketName).info(fileName);

      SupakiLogger.info(
        '파일 정보 조회 성공: $bucketName/$fileName',
        name: 'SupakiStorage',
      );
      return response;
    } catch (e) {
      SupakiLogger.error(
        '파일 정보 조회 실패: $bucketName/$fileName',
        error: e,
        name: 'SupakiStorage',
      );
      throw SupakiStorageException('파일 정보 조회에 실패했습니다: ${e.toString()}');
    }
  }

  /// 파일 이동
  static Future<String> moveFile({
    required String bucketName,
    required String fromPath,
    required String toPath,
  }) async {
    try {
      SupakiLogger.info(
        '파일 이동: $bucketName/$fromPath -> $toPath',
        name: 'SupakiStorage',
      );

      final response =
          await _client.storage.from(bucketName).move(fromPath, toPath);

      SupakiLogger.info(
        '파일 이동 성공: $bucketName/$fromPath -> $toPath',
        name: 'SupakiStorage',
      );
      return response;
    } catch (e) {
      SupakiLogger.error(
        '파일 이동 실패: $bucketName/$fromPath -> $toPath',
        error: e,
        name: 'SupakiStorage',
      );
      throw SupakiStorageException('파일 이동에 실패했습니다: ${e.toString()}');
    }
  }

  /// 파일 복사
  static Future<String> copyFile({
    required String bucketName,
    required String fromPath,
    required String toPath,
  }) async {
    try {
      SupakiLogger.info(
        '파일 복사: $bucketName/$fromPath -> $toPath',
        name: 'SupakiStorage',
      );

      final response =
          await _client.storage.from(bucketName).copy(fromPath, toPath);

      SupakiLogger.info(
        '파일 복사 성공: $bucketName/$fromPath -> $toPath',
        name: 'SupakiStorage',
      );
      return response;
    } catch (e) {
      SupakiLogger.error(
        '파일 복사 실패: $bucketName/$fromPath -> $toPath',
        error: e,
        name: 'SupakiStorage',
      );
      throw SupakiStorageException('파일 복사에 실패했습니다: ${e.toString()}');
    }
  }

  /// 파일 삭제
  static Future<List<FileObject>> deleteFiles({
    required String bucketName,
    required List<String> fileNames,
  }) async {
    try {
      SupakiLogger.info(
        '파일 삭제: $bucketName (${fileNames.length}개)',
        name: 'SupakiStorage',
      );

      final response = await _client.storage.from(bucketName).remove(fileNames);

      SupakiLogger.info(
        '파일 삭제 성공: $bucketName (${fileNames.length}개)',
        name: 'SupakiStorage',
      );
      return response;
    } catch (e) {
      SupakiLogger.error(
        '파일 삭제 실패: $bucketName',
        error: e,
        name: 'SupakiStorage',
      );
      throw SupakiStorageException('파일 삭제에 실패했습니다: ${e.toString()}');
    }
  }

  /// 단일 파일 삭제
  static Future<FileObject> deleteFile({
    required String bucketName,
    required String fileName,
  }) async {
    try {
      final response = await deleteFiles(
        bucketName: bucketName,
        fileNames: [fileName],
      );

      if (response.isEmpty) {
        throw SupakiStorageException('파일을 찾을 수 없습니다: $fileName');
      }

      return response.first;
    } catch (e) {
      if (e is SupakiStorageException) rethrow;
      throw SupakiStorageException('파일 삭제에 실패했습니다: ${e.toString()}');
    }
  }

  /// 파일 크기를 읽기 쉬운 형태로 변환
  static String formatFileSize(int bytes) {
    return SupakiHelpers.formatFileSize(bytes);
  }

  /// 파일 확장자 검증
  static bool isValidFileExtension(
    String fileName,
    List<String> allowedExtensions,
  ) {
    return SupakiValidators.isValidFileExtension(fileName, allowedExtensions);
  }

  /// 이미지 파일인지 확인
  static bool isImageFile(String fileName) {
    return SupakiValidators.isImageFile(fileName);
  }

  /// 비디오 파일인지 확인
  static bool isVideoFile(String fileName) {
    return SupakiValidators.isVideoFile(fileName);
  }

  /// 문서 파일인지 확인
  static bool isDocumentFile(String fileName) {
    return SupakiValidators.isDocumentFile(fileName);
  }
}
