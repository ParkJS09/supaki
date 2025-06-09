# GitHub에서 Supaki 사용하기 🚀

## 1. GitHub에 저장소 생성 및 업로드

### GitHub 저장소 생성
1. [GitHub](https://github.com)에 로그인
2. 우측 상단 `+` 버튼 클릭 → `New repository`
3. Repository name: `supaki`
4. Description: `Comprehensive Flutter Supabase Toolkit`
5. Public 또는 Private 선택
6. `Create repository` 클릭

### 로컬에서 GitHub에 푸시
```bash
# 원격 저장소 추가
git remote add origin https://github.com/parkJS09/supaki.git

# 모든 브랜치 푸시
git push -u origin master
git push -u origin dev
git push -u origin release

# 브랜치 확인
git branch -a
```

## 2. 다른 프로젝트에서 Supaki 사용하기

### 방법 1: GitHub Dependency 사용 (추천 ⭐)

`pubspec.yaml`에 다음과 같이 추가:

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # Supaki from GitHub
  supaki:
    git:
      url: https://github.com/parkJS09/supaki.git
      ref: master  # 브랜치 또는 태그 지정
```

### 방법 2: 특정 브랜치 사용

```yaml
dependencies:
  supaki:
    git:
      url: https://github.com/parkJS09/supaki.git
      ref: dev  # 개발 브랜치 사용
```

### 방법 3: 특정 태그/버전 사용

```yaml
dependencies:
  supaki:
    git:
      url: https://github.com/parkJS09/supaki.git
      ref: v1.0.0  # 특정 버전 사용
```

### 방법 4: Path 사용 (로컬 개발)

```yaml
dependencies:
  supaki:
    path: ../supaki  # 로컬 경로
```

## 3. 사용 예제

### 새 프로젝트에서 Supaki 사용

1. 새 Flutter 프로젝트 생성:
```bash
flutter create my_app
cd my_app
```

2. `pubspec.yaml` 수정:
```yaml
dependencies:
  flutter:
    sdk: flutter
  
  supaki:
    git:
      url: https://github.com/parkJS09/supaki.git
      ref: master
  
  # Supabase 의존성도 함께 추가
  supabase_flutter: ^2.5.6
```

3. 패키지 설치:
```bash
flutter pub get
```

4. 사용 예제 (`lib/main.dart`):
```dart
import 'package:flutter/material.dart';
import 'package:supaki/supaki.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Supaki 초기화
  await SupakiClient.initialize(SupakiConfig.development(
    supabaseUrl: 'your-supabase-url',
    supabaseAnonKey: 'your-anon-key',
  ));
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supaki Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    _testSupaki();
  }
  
  void _testSupaki() async {
    try {
      // 인증 테스트
      final isLoggedIn = SupakiAuth.isLoggedIn;
      print('로그인 상태: $isLoggedIn');
      
      // 데이터베이스 테스트 (선택적)
      // final users = await SupakiDatabase.getAll('users');
      // print('사용자 수: ${users.length}');
      
    } catch (e) {
      print('Supaki 테스트 실패: $e');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Supaki Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Supaki가 성공적으로 로드되었습니다!'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // 로그인 예제
                try {
                  await SupakiAuth.signInWithEmail(
                    email: 'test@example.com',
                    password: 'password123',
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('로그인 성공!')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('로그인 실패: $e')),
                  );
                }
              },
              child: Text('로그인 테스트'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 4. 버전 관리 및 업데이트

### Supaki 업데이트하기

```bash
# 최신 버전으로 업데이트
flutter pub upgrade supaki

# 또는 캐시 클리어 후 재설치
flutter pub deps clean
flutter pub get
```

### 특정 버전으로 고정

```yaml
dependencies:
  supaki:
    git:
      url: https://github.com/parkJS09/supaki.git
      ref: v1.0.0  # 특정 버전 고정
```

## 5. 개발 워크플로우

### 새 기능 추가하고 싶을 때

1. Fork 또는 Contributor로 추가 요청
2. `dev` 브랜치에서 새 feature 브랜치 생성
3. 기능 개발 후 PR 생성
4. 리뷰 후 머지

### 버그 발견 시

1. [Issues](https://github.com/parkJS09/supaki/issues)에 버그 리포트
2. 가능하면 재현 가능한 예제 코드 포함
3. 긴급한 경우 hotfix 브랜치에서 수정

## 6. 트러블슈팅

### 의존성 충돌

```bash
# 의존성 충돌 해결
flutter pub deps clean
flutter pub get

# 버전 확인
flutter pub deps
```

### 캐시 문제

```bash
# Flutter 캐시 클리어
flutter clean
flutter pub get

# Dart 캐시 클리어
dart pub cache clean
```

### GitHub 접근 오류

```bash
# SSH 키 설정 확인
ssh -T git@github.com

# HTTPS 사용 시 토큰 설정
git config --global credential.helper store
```

## 7. Private Repository 사용

Private repository를 사용하는 경우:

```yaml
dependencies:
  supaki:
    git:
      url: https://github.com/parkJS09/supaki.git
      ref: master
```

그리고 GitHub Personal Access Token을 설정해야 합니다:

```bash
# Git credentials 설정
git config --global credential.helper store
```

## 8. 배포 및 버전 관리

### 새 버전 릴리즈

1. `dev` → `release` 브랜치로 머지
2. 버전 업데이트 (`pubspec.yaml`)
3. `CHANGELOG.md` 업데이트
4. `release` → `master` 브랜치로 머지
5. GitHub에서 새 Release 생성

### 자동화된 릴리즈

GitHub Actions를 통해 자동으로 릴리즈가 생성됩니다:
- `master` 브랜치에 푸시될 때마다 자동 릴리즈
- 태그 자동 생성
- 릴리즈 노트 자동 생성

이제 언제든지 GitHub에서 Supaki를 가져와서 사용할 수 있습니다! 🎉 