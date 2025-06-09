import 'dart:convert';

/// Map 확장 메서드들
extension MapExtensions on Map<String, dynamic> {
  /// null 값 제거
  Map<String, dynamic> get removeNulls {
    final result = <String, dynamic>{};
    for (final entry in entries) {
      if (entry.value != null) {
        result[entry.key] = entry.value;
      }
    }
    return result;
  }

  /// 빈 값 제거 (null, 빈 문자열, 빈 리스트, 빈 맵)
  Map<String, dynamic> get removeEmpty {
    final result = <String, dynamic>{};
    for (final entry in entries) {
      final value = entry.value;
      if (value != null &&
          value != '' &&
          (value is! List || value.isNotEmpty) &&
          (value is! Map || value.isNotEmpty)) {
        result[entry.key] = value;
      }
    }
    return result;
  }

  /// JSON 문자열로 변환
  String get toJsonString {
    return jsonEncode(this);
  }

  /// 안전한 값 가져오기
  T? safeGet<T>(String key) {
    final value = this[key];
    return value is T ? value : null;
  }

  /// 깊은 복사
  Map<String, dynamic> get deepCopy {
    return jsonDecode(jsonEncode(this)) as Map<String, dynamic>;
  }

  /// 중첩된 값 가져오기 (예: "user.profile.name")
  dynamic getNestedValue(String path) {
    final keys = path.split('.');
    dynamic current = this;

    for (final key in keys) {
      if (current is Map<String, dynamic> && current.containsKey(key)) {
        current = current[key];
      } else {
        return null;
      }
    }

    return current;
  }

  /// 중첩된 값 설정하기 (예: "user.profile.name")
  void setNestedValue(String path, dynamic value) {
    final keys = path.split('.');
    Map<String, dynamic> current = this;

    for (int i = 0; i < keys.length - 1; i++) {
      final key = keys[i];
      if (!current.containsKey(key) || current[key] is! Map<String, dynamic>) {
        current[key] = <String, dynamic>{};
      }
      current = current[key] as Map<String, dynamic>;
    }

    current[keys.last] = value;
  }
}
