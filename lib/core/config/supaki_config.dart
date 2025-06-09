/// Supaki 설정 관리
class SupakiConfig {
  final String supabaseUrl;
  final String supabaseAnonKey;
  final String? supabaseServiceKey;
  final bool enableLogging;
  final Duration defaultTimeout;

  const SupakiConfig({
    required this.supabaseUrl,
    required this.supabaseAnonKey,
    this.supabaseServiceKey,
    this.enableLogging = false,
    this.defaultTimeout = const Duration(seconds: 30),
  });

  /// 개발 환경용 설정
  factory SupakiConfig.development({
    required String supabaseUrl,
    required String supabaseAnonKey,
    String? supabaseServiceKey,
  }) {
    return SupakiConfig(
      supabaseUrl: supabaseUrl,
      supabaseAnonKey: supabaseAnonKey,
      supabaseServiceKey: supabaseServiceKey,
      enableLogging: true,
    );
  }

  /// 운영 환경용 설정
  factory SupakiConfig.production({
    required String supabaseUrl,
    required String supabaseAnonKey,
    String? supabaseServiceKey,
  }) {
    return SupakiConfig(
      supabaseUrl: supabaseUrl,
      supabaseAnonKey: supabaseAnonKey,
      supabaseServiceKey: supabaseServiceKey,
      enableLogging: false,
    );
  }

  SupakiConfig copyWith({
    String? supabaseUrl,
    String? supabaseAnonKey,
    String? supabaseServiceKey,
    bool? enableLogging,
    Duration? defaultTimeout,
  }) {
    return SupakiConfig(
      supabaseUrl: supabaseUrl ?? this.supabaseUrl,
      supabaseAnonKey: supabaseAnonKey ?? this.supabaseAnonKey,
      supabaseServiceKey: supabaseServiceKey ?? this.supabaseServiceKey,
      enableLogging: enableLogging ?? this.enableLogging,
      defaultTimeout: defaultTimeout ?? this.defaultTimeout,
    );
  }
}
