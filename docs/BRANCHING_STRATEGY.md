# Supaki 브랜치 전략 🌿

## 브랜치 구조

```
master (main) ← 안정적인 프로덕션 코드
├── release   ← 릴리즈 준비 브랜치
└── dev       ← 개발 브랜치 (새로운 기능)
```

## 브랜치별 역할

### 🏠 `master` (메인 브랜치)
- **목적**: 안정적이고 배포 가능한 코드
- **보호 수준**: 높음 (직접 푸시 금지)
- **머지 조건**: PR을 통해서만 머지
- **버전 태그**: 릴리즈 시 버전 태그 생성

### 🚀 `release` (릴리즈 브랜치)
- **목적**: 릴리즈 준비 및 최종 검증
- **사용 시기**: 새 버전 배포 전
- **작업 내용**: 
  - 버전 업데이트
  - 문서 최종 검토
  - 버그 수정
  - CHANGELOG 업데이트

### 🔧 `dev` (개발 브랜치)
- **목적**: 새로운 기능 개발 및 통합
- **기본 브랜치**: 모든 feature 브랜치의 베이스
- **머지 대상**: feature 브랜치들이 여기로 머지

## 워크플로우

### 새로운 기능 개발
```bash
# 1. dev 브랜치에서 feature 브랜치 생성
git checkout dev
git pull origin dev
git checkout -b feature/새기능명

# 2. 개발 작업
# ... 코딩 ...

# 3. dev 브랜치로 머지
git checkout dev
git merge feature/새기능명
git push origin dev
```

### 릴리즈 준비
```bash
# 1. dev에서 release 브랜치로 머지
git checkout release
git merge dev

# 2. 릴리즈 준비 작업
# - 버전 업데이트
# - 문서 업데이트
# - 최종 테스트

# 3. master로 머지
git checkout master
git merge release
git tag v1.0.1
git push origin master --tags
```

### 핫픽스
```bash
# 1. master에서 hotfix 브랜치 생성
git checkout master
git checkout -b hotfix/버그수정명

# 2. 버그 수정

# 3. master와 dev 모두에 머지
git checkout master
git merge hotfix/버그수정명
git checkout dev
git merge hotfix/버그수정명
```

## 브랜치 명명 규칙

- `feature/기능명`: 새로운 기능 개발
- `bugfix/버그명`: 버그 수정
- `hotfix/긴급수정명`: 긴급 버그 수정
- `docs/문서명`: 문서 관련 작업
- `refactor/리팩토링명`: 코드 리팩토링

## 커밋 메시지 규칙

```
타입: 간단한 설명

상세 설명 (선택)

관련 이슈: #123
```

### 타입
- `feat`: 새로운 기능
- `fix`: 버그 수정
- `docs`: 문서 변경
- `style`: 코드 포맷팅
- `refactor`: 리팩토링
- `test`: 테스트 추가/수정
- `chore`: 빌드, 설정 변경

### 예시
```
feat: SupakiAuth에 OAuth 로그인 추가

Google, Facebook, GitHub OAuth 로그인 지원
- signInWithOAuth 메서드 구현
- 에러 처리 및 로깅 추가

관련 이슈: #15
```

## 버전 관리

### Semantic Versioning (SemVer)
- `MAJOR.MINOR.PATCH` 형식
- `MAJOR`: 호환성을 깨뜨리는 변경
- `MINOR`: 새로운 기능 추가 (하위 호환)
- `PATCH`: 버그 수정 (하위 호환)

### 예시
- `1.0.0`: 초기 릴리즈
- `1.1.0`: 새로운 기능 추가
- `1.1.1`: 버그 수정
- `2.0.0`: 큰 변경 (호환성 깨짐)

## GitHub 설정

### Branch Protection Rules
1. `master` 브랜치 보호 설정
2. PR 리뷰 필수
3. 상태 체크 통과 필수
4. 관리자도 규칙 적용

### PR 템플릿
```markdown
## 변경 내용
- [ ] 새로운 기능
- [ ] 버그 수정
- [ ] 문서 업데이트
- [ ] 리팩토링

## 테스트
- [ ] 단위 테스트 추가/업데이트
- [ ] 통합 테스트 확인
- [ ] 수동 테스트 완료

## 체크리스트
- [ ] 코드 리뷰 완료
- [ ] 문서 업데이트
- [ ] CHANGELOG 업데이트
``` 