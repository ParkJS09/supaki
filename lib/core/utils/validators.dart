import 'dart:convert';

/// 검증 유틸리티 클래스
class SupakiValidators {
  /// 이메일 검증
  static bool isValidEmail(String email) {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(email);
  }

  /// 비밀번호 강도 검증
  static bool isStrongPassword(String password) {
    return RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    ).hasMatch(password);
  }

  /// 한국 휴대폰 번호 검증
  static bool isValidPhoneNumber(String phoneNumber) {
    return RegExp(r'^010-?[0-9]{4}-?[0-9]{4}$').hasMatch(phoneNumber);
  }

  /// URL 검증
  static bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }

  /// 파일 확장자 검증
  static bool isValidFileExtension(
    String fileName,
    List<String> allowedExtensions,
  ) {
    final extension = fileName.split('.').last.toLowerCase();
    return allowedExtensions.contains(extension);
  }

  /// 이미지 파일 검증
  static bool isImageFile(String fileName) {
    return isValidFileExtension(fileName, [
      'jpg',
      'jpeg',
      'png',
      'gif',
      'webp',
      'bmp',
    ]);
  }

  /// 비디오 파일 검증
  static bool isVideoFile(String fileName) {
    return isValidFileExtension(fileName, [
      'mp4',
      'avi',
      'mov',
      'wmv',
      'flv',
      'webm',
    ]);
  }

  /// 문서 파일 검증
  static bool isDocumentFile(String fileName) {
    return isValidFileExtension(fileName, [
      'pdf',
      'doc',
      'docx',
      'xls',
      'xlsx',
      'ppt',
      'pptx',
      'txt',
    ]);
  }

  /// 파일 크기 검증 (바이트 단위)
  static bool isValidFileSize(int fileSize, int maxSizeInBytes) {
    return fileSize <= maxSizeInBytes;
  }

  /// JSON 문자열 검증
  static bool isValidJson(String jsonString) {
    try {
      jsonDecode(jsonString);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 숫자 범위 검증
  static bool isInRange(num value, num min, num max) {
    return value >= min && value <= max;
  }

  /// 문자열 길이 검증
  static bool isValidLength(String value, int minLength, [int? maxLength]) {
    if (value.length < minLength) return false;
    if (maxLength != null && value.length > maxLength) return false;
    return true;
  }

  /// UUID 검증
  static bool isValidUuid(String uuid) {
    return RegExp(
      r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
    ).hasMatch(uuid);
  }

  /// 색상 코드 검증 (HEX)
  static bool isValidHexColor(String color) {
    return RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$').hasMatch(color);
  }

  SupakiValidators._();
}
