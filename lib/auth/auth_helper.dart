import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/supaki_core.dart';

/// Supabase 인증을 쉽게 사용할 수 있게 해주는 헬퍼 클래스
class SupakiAuth {
  static SupabaseClient get _client => SupakiClient.instance.supabase;

  /// 현재 로그인된 사용자
  static User? get currentUser => _client.auth.currentUser;

  /// 현재 세션
  static Session? get currentSession => _client.auth.currentSession;

  /// 로그인 상태 확인
  static bool get isLoggedIn => currentUser != null;

  /// 인증 상태 변화 스트림
  static Stream<AuthState> get authStateStream =>
      _client.auth.onAuthStateChange;

  /// 이메일로 회원가입
  static Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
    Map<String, dynamic>? data,
    String? captchaToken,
  }) async {
    try {
      SupakiLogger.info('이메일 회원가입 시도: $email', name: 'SupakiAuth');

      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: data,
        captchaToken: captchaToken,
      );

      SupakiLogger.info('이메일 회원가입 성공: $email', name: 'SupakiAuth');
      return response;
    } catch (e) {
      SupakiLogger.error('이메일 회원가입 실패: $email', error: e, name: 'SupakiAuth');
      throw SupakiAuthException('회원가입에 실패했습니다: ${e.toString()}');
    }
  }

  /// 이메일로 로그인
  static Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
    String? captchaToken,
  }) async {
    try {
      SupakiLogger.info('이메일 로그인 시도: $email', name: 'SupakiAuth');

      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
        captchaToken: captchaToken,
      );

      SupakiLogger.info('이메일 로그인 성공: $email', name: 'SupakiAuth');
      return response;
    } catch (e) {
      SupakiLogger.error('이메일 로그인 실패: $email', error: e, name: 'SupakiAuth');
      throw SupakiAuthException('로그인에 실패했습니다: ${e.toString()}');
    }
  }

  /// 전화번호로 회원가입
  static Future<AuthResponse> signUpWithPhone({
    required String phone,
    required String password,
    Map<String, dynamic>? data,
    String? captchaToken,
  }) async {
    try {
      SupakiLogger.info('전화번호 회원가입 시도: $phone', name: 'SupakiAuth');

      final response = await _client.auth.signUp(
        phone: phone,
        password: password,
        data: data,
        captchaToken: captchaToken,
      );

      SupakiLogger.info('전화번호 회원가입 성공: $phone', name: 'SupakiAuth');
      return response;
    } catch (e) {
      SupakiLogger.error('전화번호 회원가입 실패: $phone', error: e, name: 'SupakiAuth');
      throw SupakiAuthException('회원가입에 실패했습니다: ${e.toString()}');
    }
  }

  /// 전화번호로 로그인
  static Future<AuthResponse> signInWithPhone({
    required String phone,
    required String password,
    String? captchaToken,
  }) async {
    try {
      SupakiLogger.info('전화번호 로그인 시도: $phone', name: 'SupakiAuth');

      final response = await _client.auth.signInWithPassword(
        phone: phone,
        password: password,
        captchaToken: captchaToken,
      );

      SupakiLogger.info('전화번호 로그인 성공: $phone', name: 'SupakiAuth');
      return response;
    } catch (e) {
      SupakiLogger.error('전화번호 로그인 실패: $phone', error: e, name: 'SupakiAuth');
      throw SupakiAuthException('로그인에 실패했습니다: ${e.toString()}');
    }
  }

  /// OAuth 로그인 (구글, 페이스북 등)
  static Future<bool> signInWithOAuth({
    required OAuthProvider provider,
    String? redirectTo,
    String? scopes,
    Map<String, String>? queryParams,
  }) async {
    try {
      SupakiLogger.info('OAuth 로그인 시도: ${provider.name}', name: 'SupakiAuth');

      final result = await _client.auth.signInWithOAuth(
        provider,
        redirectTo: redirectTo,
        scopes: scopes,
        queryParams: queryParams,
      );

      SupakiLogger.info('OAuth 로그인 성공: ${provider.name}', name: 'SupakiAuth');
      return result;
    } catch (e) {
      SupakiLogger.error(
        'OAuth 로그인 실패: ${provider.name}',
        error: e,
        name: 'SupakiAuth',
      );
      throw SupakiAuthException('OAuth 로그인에 실패했습니다: ${e.toString()}');
    }
  }

  /// 매직 링크로 로그인
  static Future<void> signInWithMagicLink({
    required String email,
    Map<String, dynamic>? data,
    String? captchaToken,
  }) async {
    try {
      SupakiLogger.info('매직 링크 전송 시도: $email', name: 'SupakiAuth');

      await _client.auth.signInWithOtp(
        email: email,
        data: data,
        captchaToken: captchaToken,
      );

      SupakiLogger.info('매직 링크 전송 성공: $email', name: 'SupakiAuth');
    } catch (e) {
      SupakiLogger.error('매직 링크 전송 실패: $email', error: e, name: 'SupakiAuth');
      throw SupakiAuthException('매직 링크 전송에 실패했습니다: ${e.toString()}');
    }
  }

  /// OTP 인증
  static Future<AuthResponse> verifyOTP({
    required String token,
    required OtpType type,
    String? email,
    String? phone,
    String? captchaToken,
  }) async {
    try {
      SupakiLogger.info('OTP 인증 시도: $type', name: 'SupakiAuth');

      final response = await _client.auth.verifyOTP(
        token: token,
        type: type,
        email: email,
        phone: phone,
        captchaToken: captchaToken,
      );

      SupakiLogger.info('OTP 인증 성공: $type', name: 'SupakiAuth');
      return response;
    } catch (e) {
      SupakiLogger.error('OTP 인증 실패: $type', error: e, name: 'SupakiAuth');
      throw SupakiAuthException('OTP 인증에 실패했습니다: ${e.toString()}');
    }
  }

  /// 비밀번호 재설정
  static Future<void> resetPassword({
    required String email,
    String? captchaToken,
  }) async {
    try {
      SupakiLogger.info('비밀번호 재설정 요청: $email', name: 'SupakiAuth');

      await _client.auth.resetPasswordForEmail(
        email,
        captchaToken: captchaToken,
      );

      SupakiLogger.info('비밀번호 재설정 이메일 전송 성공: $email', name: 'SupakiAuth');
    } catch (e) {
      SupakiLogger.error('비밀번호 재설정 실패: $email', error: e, name: 'SupakiAuth');
      throw SupakiAuthException('비밀번호 재설정에 실패했습니다: ${e.toString()}');
    }
  }

  /// 비밀번호 업데이트
  static Future<UserResponse> updatePassword({
    required String newPassword,
  }) async {
    try {
      SupakiLogger.info('비밀번호 업데이트 시도', name: 'SupakiAuth');

      final response = await _client.auth.updateUser(
        UserAttributes(password: newPassword),
      );

      SupakiLogger.info('비밀번호 업데이트 성공', name: 'SupakiAuth');
      return response;
    } catch (e) {
      SupakiLogger.error('비밀번호 업데이트 실패', error: e, name: 'SupakiAuth');
      throw SupakiAuthException('비밀번호 업데이트에 실패했습니다: ${e.toString()}');
    }
  }

  /// 사용자 정보 업데이트
  static Future<UserResponse> updateUser({
    String? email,
    String? phone,
    Map<String, dynamic>? data,
  }) async {
    try {
      SupakiLogger.info('사용자 정보 업데이트 시도', name: 'SupakiAuth');

      final response = await _client.auth.updateUser(
        UserAttributes(email: email, phone: phone, data: data),
      );

      SupakiLogger.info('사용자 정보 업데이트 성공', name: 'SupakiAuth');
      return response;
    } catch (e) {
      SupakiLogger.error('사용자 정보 업데이트 실패', error: e, name: 'SupakiAuth');
      throw SupakiAuthException('사용자 정보 업데이트에 실패했습니다: ${e.toString()}');
    }
  }

  /// 로그아웃
  static Future<void> signOut() async {
    try {
      SupakiLogger.info('로그아웃 시도', name: 'SupakiAuth');

      await _client.auth.signOut();

      SupakiLogger.info('로그아웃 성공', name: 'SupakiAuth');
    } catch (e) {
      SupakiLogger.error('로그아웃 실패', error: e, name: 'SupakiAuth');
      throw SupakiAuthException('로그아웃에 실패했습니다: ${e.toString()}');
    }
  }

  /// 세션 갱신
  static Future<AuthResponse> refreshSession() async {
    try {
      SupakiLogger.info('세션 갱신 시도', name: 'SupakiAuth');

      final response = await _client.auth.refreshSession();

      SupakiLogger.info('세션 갱신 성공', name: 'SupakiAuth');
      return response;
    } catch (e) {
      SupakiLogger.error('세션 갱신 실패', error: e, name: 'SupakiAuth');
      throw SupakiAuthException('세션 갱신에 실패했습니다: ${e.toString()}');
    }
  }

  /// 사용자 삭제
  static Future<void> deleteUser() async {
    try {
      SupakiLogger.info('사용자 삭제 시도', name: 'SupakiAuth');

      await _client.rpc('delete_user');

      SupakiLogger.info('사용자 삭제 성공', name: 'SupakiAuth');
    } catch (e) {
      SupakiLogger.error('사용자 삭제 실패', error: e, name: 'SupakiAuth');
      throw SupakiAuthException('사용자 삭제에 실패했습니다: ${e.toString()}');
    }
  }
}
