# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2025-06-10

### 🎉 Initial Release

#### ✨ Added
- **🔧 Core Module** - 기본 설정 및 에러 처리
  - `SupakiConfig`: 개발/운영 환경 설정 관리
  - `SupakiClient`: Supabase 클라이언트 싱글톤 관리  
  - `SupakiException`: 포괄적인 예외 처리 시스템
  - `SupakiLogger`: 개발용 로깅 시스템
  - `SupakiValidators`: 이메일, 비밀번호, 파일 등 검증 유틸리티
  - `SupakiHelpers`: UUID 생성, 파일 크기 포맷팅 등 헬퍼 함수들

- **🔐 Auth Module** - 완전한 인증 시스템
  - 이메일/비밀번호 회원가입 및 로그인
  - 전화번호 인증 지원
  - OAuth 로그인 (Google, Facebook, GitHub 등)
  - 매직링크 인증
  - OTP 인증
  - 비밀번호 재설정 및 업데이트
  - 사용자 정보 관리
  - 세션 관리 및 갱신

- **🗄️ Database Module** - 강력한 데이터베이스 작업
  - CRUD 작업 (Create, Read, Update, Delete)
  - 조건부 쿼리 및 정렬
  - 페이지네이션 지원
  - 개수 조회
  - RPC 함수 실행
  - 트랜잭션 지원

- **📁 Storage Module** - 파일 관리 시스템
  - 버킷 생성, 조회, 업데이트, 삭제
  - 파일 업로드 (Uint8List, File path)
  - 파일 다운로드
  - 공개 URL 생성
  - 서명된 URL 생성 (만료 시간 설정)
  - 파일 목록 조회
  - 파일 이동, 복사, 삭제
  - 파일 정보 조회

- **🔧 Extensions** - 유용한 확장 메서드들
  - `StringExtensions`: 이메일 검증, Base64 인코딩 등
  - `DateTimeExtensions`: 한국어 요일, 상대 시간 표시 등  
  - `MapExtensions`: null 값 제거, 중첩 값 접근 등

#### 📚 Documentation
- 포괄적인 README 문서 (한국어)
- 브랜치 전략 문서 (master/dev/release)
- GitHub 사용법 가이드
- API 문서 및 사용 예제

#### 🔧 Development Tools
- GitHub Actions CI/CD 파이프라인
- 자동 테스트 및 분석
- Pull Request 템플릿
- 코드 포맷팅 및 린팅 규칙

#### 🏗️ Project Structure
```
lib/
├── core/        # 핵심 기능 (설정, 에러, 유틸리티)
├── auth/        # 인증 관리
├── data/        # 데이터베이스 작업
├── storage/     # 파일 스토리지
└── supaki.dart  # 메인 export
```

### 🎯 Usage
```dart
// 초기화
await SupakiClient.initialize(SupakiConfig.development(
  supabaseUrl: 'your-url',
  supabaseAnonKey: 'your-key',
));

// 인증
await SupakiAuth.signInWithEmail(email: 'test@example.com', password: 'pass');

// 데이터베이스
final users = await SupakiDatabase.getAll('users');

// 스토리지
await SupakiStorage.uploadFile(bucketName: 'files', fileName: 'doc.pdf', fileBytes: bytes);
```

### 📦 Installation
```yaml
dependencies:
  supaki:
    git:
      url: https://github.com/parkJS09/supaki.git
      ref: v0.1.0
```

---

[0.1.0]: https://github.com/parkJS09/supaki/releases/tag/v0.1.0
