import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:math' as math;
import 'package:flutter/material.dart';

/// 헬퍼 유틸리티 클래스
class SupakiHelpers {
  /// 랜덤 문자열 생성
  static String generateRandomString(int length) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }

  /// UUID v4 생성
  static String generateUuid() {
    final random = Random();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));

    // Version 4 UUID
    bytes[6] = (bytes[6] & 0x0F) | 0x40;
    bytes[8] = (bytes[8] & 0x3F) | 0x80;

    final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20, 32)}';
  }

  /// 파일 크기를 읽기 쉬운 형태로 변환
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '${bytes}B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)}KB';
    if (bytes < 1024 * 1024 * 1024)
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)}GB';
  }

  /// 깊은 복사 (JSON을 통한)
  static T deepCopy<T>(T object) {
    return jsonDecode(jsonEncode(object)) as T;
  }

  /// 디바운스 함수
  static Function debounce(Function function, Duration delay) {
    Timer? timer;
    return () {
      timer?.cancel();
      timer = Timer(delay, () => function());
    };
  }

  /// 쓰로틀 함수
  static Function throttle(Function function, Duration delay) {
    Timer? timer;
    bool isWaiting = false;

    return () {
      if (!isWaiting) {
        function();
        isWaiting = true;
        timer = Timer(delay, () => isWaiting = false);
      }
    };
  }

  /// 리스트를 청크 단위로 나누기
  static List<List<T>> chunk<T>(List<T> list, int chunkSize) {
    final chunks = <List<T>>[];
    for (int i = 0; i < list.length; i += chunkSize) {
      chunks.add(list.sublist(i, math.min(i + chunkSize, list.length)));
    }
    return chunks;
  }

  /// 맵에서 null 값 제거
  static Map<String, dynamic> removeNullValues(Map<String, dynamic> map) {
    final result = <String, dynamic>{};
    for (final entry in map.entries) {
      if (entry.value != null) {
        result[entry.key] = entry.value;
      }
    }
    return result;
  }

  /// 색상 HEX 코드를 Color 객체로 변환
  static Color? hexToColor(String hex) {
    try {
      hex = hex.replaceAll('#', '');
      if (hex.length == 6) {
        hex = 'FF$hex'; // 알파 채널 추가
      }
      return Color(int.parse('0x$hex'));
    } catch (e) {
      return null;
    }
  }

  /// Color 객체를 HEX 코드로 변환
  static String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }

  /// 문자열을 안전하게 정수로 변환
  static int? safeParseInt(String? value, {int? defaultValue}) {
    if (value == null) return defaultValue;
    return int.tryParse(value) ?? defaultValue;
  }

  /// 문자열을 안전하게 더블로 변환
  static double? safeParseDouble(String? value, {double? defaultValue}) {
    if (value == null) return defaultValue;
    return double.tryParse(value) ?? defaultValue;
  }

  /// 현재 시간의 타임스탬프 반환
  static int getCurrentTimestamp() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  /// 타임스탬프를 DateTime으로 변환
  static DateTime timestampToDateTime(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  SupakiHelpers._();
}
