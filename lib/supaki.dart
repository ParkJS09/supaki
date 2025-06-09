/// Supaki - Comprehensive Flutter Supabase Toolkit
///
/// Supabase를 Flutter에서 쉽게 사용할 수 있게 해주는 포괄적인 툴킷입니다.
///
/// ## 기능
/// - **Core**: 기본 설정, 에러 처리, 유틸리티
/// - **Auth**: 인증 관리 (이메일, 전화번호, OAuth, 매직링크 등)
/// - **Database**: 데이터베이스 CRUD 작업, 페이지네이션, RPC
/// - **Storage**: 파일 업로드/다운로드, 버킷 관리
///
/// ## 사용법
/// ```dart
/// import 'package:supaki/supaki.dart';
///
/// // 초기화
/// await SupakiClient.initialize(SupakiConfig.development(
///   supabaseUrl: 'your-supabase-url',
///   supabaseAnonKey: 'your-anon-key',
/// ));
///
/// // 인증
/// await SupakiAuth.signInWithEmail(
///   email: 'test@example.com',
///   password: 'password123',
/// );
///
/// // 데이터베이스
/// final users = await SupakiDatabase.getAll('users');
///
/// // 스토리지
/// await SupakiStorage.uploadFile(
///   bucketName: 'avatars',
///   fileName: 'avatar.jpg',
///   fileBytes: fileBytes,
/// );
/// ```
library supaki;

// Core Module
export 'core/supaki_core.dart';

// Auth Module
export 'auth/supaki_auth.dart';

// Database Module
export 'data/supaki_data.dart';

// Storage Module
export 'storage/supaki_storage.dart';
