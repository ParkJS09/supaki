import 'dart:convert';
import 'dart:typed_data';

/// String 확장 메서드들
extension StringExtensions on String {
  /// 이메일 형식 검증
  bool get isValidEmail {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(this);
  }

  /// 비밀번호 강도 검증 (최소 8자, 대소문자, 숫자, 특수문자 포함)
  bool get isStrongPassword {
    return RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    ).hasMatch(this);
  }

  /// 공백 제거
  String get trimAll => replaceAll(RegExp(r'\s+'), '');

  /// 첫 글자 대문자로 변환
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// 각 단어의 첫 글자를 대문자로 변환
  String get titleCase {
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  /// Base64 인코딩
  String get toBase64 {
    return base64Encode(utf8.encode(this));
  }

  /// Base64 디코딩
  String get fromBase64 {
    return utf8.decode(base64Decode(this));
  }
}
