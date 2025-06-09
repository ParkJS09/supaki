/// Supaki 관련 상수들
class SupakiConstants {
  static const String packageName = 'supaki';
  static const String version = '0.1.0';

  // 기본 테이블 이름
  static const String defaultUsersTable = 'users';
  static const String defaultProfilesTable = 'profiles';

  // 기본 버킷 이름
  static const String defaultAvatarsBucket = 'avatars';
  static const String defaultFilesBucket = 'files';

  // 기본 정책 이름
  static const String defaultRlsPolicy = 'Users can view their own data';

  // 에러 메시지
  static const String errorConfigNotInitialized =
      'Supaki configuration not initialized';
  static const String errorSupabaseNotInitialized = 'Supabase not initialized';
  static const String errorNetworkConnection = 'Network connection error';
  static const String errorUnauthorized = 'Unauthorized access';
  static const String errorServerError = 'Server error occurred';

  // 기본 설정값
  static const int defaultPageSize = 20;
  static const int maxFileSize = 50 * 1024 * 1024; // 50MB
  static const Duration defaultCacheDuration = Duration(minutes: 5);

  SupakiConstants._();
}
