import 'dart:developer' as developer;

/// 로깅 레벨
enum LogLevel { debug, info, warning, error }

/// Supaki 로거
class SupakiLogger {
  static bool _enableLogging = false;
  static LogLevel _minLevel = LogLevel.debug;

  /// 로깅 활성화 설정
  static void enableLogging(bool enable, {LogLevel minLevel = LogLevel.debug}) {
    _enableLogging = enable;
    _minLevel = minLevel;
  }

  /// 디버그 로그
  static void debug(
    String message, {
    String? name,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      LogLevel.debug,
      message,
      name: name,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// 정보 로그
  static void info(
    String message, {
    String? name,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      LogLevel.info,
      message,
      name: name,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// 경고 로그
  static void warning(
    String message, {
    String? name,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      LogLevel.warning,
      message,
      name: name,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// 에러 로그
  static void error(
    String message, {
    String? name,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      LogLevel.error,
      message,
      name: name,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// 내부 로깅 메서드
  static void _log(
    LogLevel level,
    String message, {
    String? name,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!_enableLogging || level.index < _minLevel.index) return;

    final prefix = _getLevelPrefix(level);
    final logName = name ?? 'Supaki';
    final timestamp = DateTime.now().toIso8601String();

    final logMessage = '[$timestamp] $prefix [$logName] $message';

    developer.log(
      logMessage,
      name: logName,
      error: error,
      stackTrace: stackTrace,
      level: _getDeveloperLogLevel(level),
    );
  }

  /// 레벨별 프리픽스 반환
  static String _getLevelPrefix(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return '🐛 DEBUG';
      case LogLevel.info:
        return 'ℹ️ INFO';
      case LogLevel.warning:
        return '⚠️ WARNING';
      case LogLevel.error:
        return '❌ ERROR';
    }
  }

  /// 개발자 로그 레벨 변환
  static int _getDeveloperLogLevel(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return 500;
      case LogLevel.info:
        return 800;
      case LogLevel.warning:
        return 900;
      case LogLevel.error:
        return 1000;
    }
  }
}
