<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Supaki 🚀

**Comprehensive Flutter Supabase Toolkit**

Supabase를 Flutter에서 쉽게 사용할 수 있게 해주는 포괄적인 툴킷입니다.

[![pub package](https://img.shields.io/pub/v/supaki.svg)](https://pub.dev/packages/supaki)
[![popularity](https://img.shields.io/pub/popularity/supaki.svg)](https://pub.dev/packages/supaki)
[![likes](https://img.shields.io/pub/likes/supaki.svg)](https://pub.dev/packages/supaki)
[![pub points](https://img.shields.io/pub/points/supaki.svg)](https://pub.dev/packages/supaki)

## ✨ 주요 기능

- 🔐 **인증 관리**: 이메일, 전화번호, OAuth, 매직링크 등
- 🗄️ **데이터베이스**: CRUD 작업, 페이지네이션, RPC 함수 실행
- 📁 **스토리지**: 파일 업로드/다운로드, 버킷 관리
- 🔧 **유틸리티**: 로깅, 검증, 헬퍼 함수들
- ⚡ **간편한 사용법**: 복잡한 Supabase API를 간단한 메서드로 래핑

## 📦 설치

```yaml
dependencies:
  supaki: ^1.0.0
```

## 🚀 빠른 시작

### 1. 초기화

```dart
import 'package:supaki/supaki.dart';

await SupakiClient.initialize(SupakiConfig.development(
  supabaseUrl: 'your-supabase-url',
  supabaseAnonKey: 'your-anon-key',
));
```

### 2. 인증

```dart
// 이메일 회원가입
await SupakiAuth.signUpWithEmail(
  email: 'test@example.com',
  password: 'password123',
);

// 이메일 로그인
await SupakiAuth.signInWithEmail(
  email: 'test@example.com',
  password: 'password123',
);

// OAuth 로그인
await SupakiAuth.signInWithOAuth(
  provider: OAuthProvider.google,
);

// 현재 사용자 확인
final user = SupakiAuth.currentUser;
final isLoggedIn = SupakiAuth.isLoggedIn;

// 로그아웃
await SupakiAuth.signOut();
```

### 3. 데이터베이스

```dart
// 모든 데이터 조회
final users = await SupakiDatabase.getAll('users');

// ID로 조회
final user = await SupakiDatabase.getById('users', 'user-id');

// 조건 조회
final activeUsers = await SupakiDatabase.getWhere(
  'users',
  column: 'status',
  value: 'active',
  orderBy: 'created_at',
  limit: 10,
);

// 페이지네이션
final users = await SupakiDatabase.getPaginated(
  'users',
  page: 1,
  pageSize: 20,
  orderBy: 'created_at',
);

// 데이터 삽입
final newUser = await SupakiDatabase.insert('users', {
  'name': 'John Doe',
  'email': 'john@example.com',
});

// 데이터 업데이트
final updatedUser = await SupakiDatabase.update(
  'users',
  {'name': 'Jane Doe'},
  idColumn: 'id',
  idValue: 'user-id',
);

// 데이터 삭제
await SupakiDatabase.delete(
  'users',
  idColumn: 'id',
  idValue: 'user-id',
);

// 개수 조회
final count = await SupakiDatabase.count('users');

// RPC 함수 실행
final result = await SupakiDatabase.rpc('get_user_stats', params: {
  'user_id': 'user-id',
});
```

### 4. 스토리지

```dart
// 파일 업로드
await SupakiStorage.uploadFile(
  bucketName: 'avatars',
  fileName: 'avatar.jpg',
  fileBytes: fileBytes,
  contentType: 'image/jpeg',
);

// 경로로 파일 업로드
await SupakiStorage.uploadFileFromPath(
  bucketName: 'documents',
  fileName: 'document.pdf',
  filePath: '/path/to/document.pdf',
);

// 파일 다운로드
final fileBytes = await SupakiStorage.downloadFile(
  bucketName: 'avatars',
  fileName: 'avatar.jpg',
);

// 공개 URL 생성
final publicUrl = SupakiStorage.getPublicUrl(
  bucketName: 'avatars',
  fileName: 'avatar.jpg',
);

// 서명된 URL 생성 (만료 시간 설정 가능)
final signedUrl = await SupakiStorage.createSignedUrl(
  bucketName: 'private-files',
  fileName: 'document.pdf',
  expiresInSeconds: 3600, // 1시간
);

// 파일 목록 조회
final files = await SupakiStorage.listFiles(
  bucketName: 'avatars',
  limit: 10,
);

// 파일 삭제
await SupakiStorage.deleteFile(
  bucketName: 'avatars',
  fileName: 'old-avatar.jpg',
);

// 버킷 생성
await SupakiStorage.createBucket(
  bucketName: 'new-bucket',
  public: false,
  fileSizeLimit: 50 * 1024 * 1024, // 50MB
);
```

## 🔧 유틸리티

### 로깅

```dart
// 로깅 활성화
SupakiLogger.enableLogging(true, minLevel: LogLevel.info);

// 로그 출력
SupakiLogger.info('사용자 로그인 성공');
SupakiLogger.error('오류 발생', error: exception);
```

### 검증

```dart
// 이메일 검증
final isValidEmail = SupakiValidators.isValidEmail('test@example.com');

// 비밀번호 강도 검증
final isStrongPassword = SupakiValidators.isStrongPassword('MyPassword123!');

// 파일 확장자 검증
final isValidImage = SupakiValidators.isImageFile('photo.jpg');
```

### 헬퍼 함수

```dart
// UUID 생성
final uuid = SupakiHelpers.generateUuid();

// 파일 크기 포맷팅
final formattedSize = SupakiHelpers.formatFileSize(1024 * 1024); // "1.0MB"

// 안전한 타입 변환
final intValue = SupakiHelpers.safeParseInt('123', defaultValue: 0);
```

## 🔧 설정

### 개발 환경

```dart
final config = SupakiConfig.development(
  supabaseUrl: 'your-dev-url',
  supabaseAnonKey: 'your-dev-key',
);
```

### 운영 환경

```dart
final config = SupakiConfig.production(
  supabaseUrl: 'your-prod-url',
  supabaseAnonKey: 'your-prod-key',
);
```

### 커스텀 설정

```dart
final config = SupakiConfig(
  supabaseUrl: 'your-url',
  supabaseAnonKey: 'your-key',
  enableLogging: true,
  defaultTimeout: Duration(seconds: 30),
);
```

## 📖 API 문서

자세한 API 문서는 [pub.dev](https://pub.dev/documentation/supaki)에서 확인할 수 있습니다.

## 🤝 기여하기

기여를 환영합니다! [CONTRIBUTING.md](CONTRIBUTING.md)를 참고해주세요.

## 📝 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다. 자세한 내용은 [LICENSE](LICENSE) 파일을 참고해주세요.

## 🐛 버그 리포트

버그를 발견하셨다면 [이슈](https://github.com/your-org/supaki/issues)를 생성해주세요.

## ⭐ 지원하기

이 프로젝트가 도움이 되셨다면 ⭐을 눌러주세요!
