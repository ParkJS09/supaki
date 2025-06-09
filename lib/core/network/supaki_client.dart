import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supaki_config.dart';
import '../errors/supaki_exceptions.dart';
import '../constants/supaki_constants.dart';

/// Supaki 핵심 클라이언트 관리 클래스
class SupakiClient {
  static SupakiClient? _instance;
  static SupakiConfig? _config;

  SupabaseClient? _supabaseClient;

  SupakiClient._();

  /// 싱글톤 인스턴스 반환
  static SupakiClient get instance {
    _instance ??= SupakiClient._();
    return _instance!;
  }

  /// Supaki 초기화
  static Future<void> initialize(SupakiConfig config) async {
    _config = config;

    try {
      await Supabase.initialize(
        url: config.supabaseUrl,
        anonKey: config.supabaseAnonKey,
        debug: config.enableLogging,
      );

      instance._supabaseClient = Supabase.instance.client;

      if (config.enableLogging) {
        print('✅ Supaki initialized successfully');
      }
    } catch (e) {
      throw SupakiConfigException(
        'Failed to initialize Supaki: ${e.toString()}',
        code: 'INIT_ERROR',
        details: e,
      );
    }
  }

  /// 설정 반환
  static SupakiConfig get config {
    if (_config == null) {
      throw const SupakiConfigException(
        SupakiConstants.errorConfigNotInitialized,
      );
    }
    return _config!;
  }

  /// Supabase 클라이언트 반환
  SupabaseClient get supabase {
    if (_supabaseClient == null) {
      throw const SupakiNetworkException(
        SupakiConstants.errorSupabaseNotInitialized,
      );
    }
    return _supabaseClient!;
  }

  /// 현재 사용자 반환
  User? get currentUser => _supabaseClient?.auth.currentUser;

  /// 인증 상태 스트림
  Stream<AuthState> get authStateStream => supabase.auth.onAuthStateChange;

  /// 초기화 여부 확인
  bool get isInitialized => _supabaseClient != null;

  /// 로그아웃
  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      throw SupakiAuthException(
        'Failed to sign out: ${e.toString()}',
        code: 'SIGNOUT_ERROR',
        details: e,
      );
    }
  }

  /// 현재 세션 반환
  Session? get currentSession => supabase.auth.currentSession;

  /// 연결 상태 확인
  Future<bool> checkConnection() async {
    try {
      await supabase.from('_health_check').select().limit(1);
      return true;
    } catch (e) {
      return false;
    }
  }
}
