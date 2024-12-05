# Frontend 개발 명세서

## 현재 파일 구조

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   └── app_constants.dart
│   └── utils/
│       └── url_launcher.dart
├── models/
│   ├── song.dart
│   └── playlist.dart
├── services/
│   └── youtube_service.dart
├── view_models/
│   ├── player_view_model.dart
│   ├── home_view_model.dart
│   └── library_view_model.dart
├── views/
│   ├── home/
│   │   ├── home_view.dart
│   │   └── widgets/
│   │       ├── playlist_card.dart
│   │       └── genre_section.dart
│   ├── player/
│   │   ├── player_view.dart
│   │   └── widgets/
│   │       ├── player_controls.dart
│   │       └── mini_player.dart
│   └── library/
│       └── library_view.dart
└── widgets/
    ├── bottom_nav_bar.dart
    └── common/
        └── loading_indicator.dart
```

## 작업 계획

### Phase 1: 프로젝트 셋업 및 기본 구조 (2일)

1. Flutter 프로젝트 생성 및 Cupertino 디자인 시스템 적용
2. 기본 파일 구조 셋업
3. 필요한 패키지 추가 (youtube_player_flutter, provider 등)
4. 테마 및 색상 상수 정의

### Phase 2: 기본 네비게이션 구현 🚧 (진행 중)

1. CupertinoTabBar를 활용한 하단 네비게이션 바 구현
2. 각 탭에 해당하는 기본 뷰 생성
3. 네비게이션 로직 구현
4. 미니 플레이어 기본 구조 구현

### Phase 3: 홈 화면 개발 🚧 (진행 중)

1. 홈 화면 기본 레이아웃 구현
2. 플레이리스트 카드 위젯 개발
3. 장르별 섹션 구현
4. 데이터 바인딩 및 상태 관리 설정

### Phase 4: 플레이어 기능 구현 ✅

1. YouTube 서비스 통합
2. 플레이어 뷰 UI 구현
3. 재생 컨트롤 기능 구현
4. 미니 플레이어 개발
5. 재생 상태 관리 로직 구현

### Phase 5: 라이브러리 및 둘러보기 화면 🚧 (진행 중)

1. 라이브러리 화면 기본 레이아웃 구현
2. 둘러보기 화면 기본 구조 설정
3. 샘플 데이터 통합

### Phase 6: 마무리 및 최적화 🚧 (시작)

- [x] 성능 최적화
- [x] 버그 수정
- [x] 코드 정리 및 문서화

## 기술 스택

- Flutter & Dart
- Provider (상태 관리)
- youtube_player_flutter (YouTube 재생)
- Cupertino 위젯

## 주요 구현 사항

### ViewModel 구조

1. PlayerViewModel

   - 현재 재생 중인 곡 상태 관리
   - 재생/일시정지/다음/이전 트랙 로직
   - 재생 진행률 관리

2. HomeViewModel

   - 플레이리스트 데이터 관리
   - 장르별 콘텐츠 관리
   - 추천 시스템 로직

3. LibraryViewModel
   - 저장된 곡 관리
   - 플레이리스트 관리

### 데이터 모델

1. Song

   - title: String
   - artist: String
   - coverUrl: String
   - youtubeUrl: String
   - duration: Duration

2. Playlist
   - name: String
   - description: String
   - songs: List<Song>
   - coverUrl: String

## UI/UX 가이드라인

- iOS 디자인 가이드라인 준수
- Cupertino 위젯 우선 사용
- 부드러운 애니메이션과 전환 효과
- 직관적인 제스처 지원

## 진행 상황

### Phase 1: 프로젝트 셋업 및 기본 구조 ✅

- [x] Flutter 프로젝트 생성 및 Cupertino 디자인 시스템 적용
- [x] 기본 파일 구조 셋업
- [x] 필요한 패키지 추가
- [x] 테마 및 색상 상수 정의
- [x] 기본 모델 및 뷰모델 구현

### Phase 2: 기본 네비게이션 구현 🚧 (진행 중)

- [x] CupertinoTabBar를 활용한 하단 네비게이션 바 구현
- [x] 각 탭에 해당하는 기본 뷰 생성
- [x] 네비게이션 로직 구현
- [x] 미니 플레이어 기본 구조 구현

### Phase 3: 홈 화면 개발 🚧 (진행 중)

- [x] 홈 화면 기본 레이아웃 구현
- [x] 플레이리스트 카드 위젯 개발
- [x] 장르별 섹션 구현
- [x] 데이터 바인딩 및 상태 관리 설정

### Phase 4: 플레이어 기능 구현 ✅

1. YouTube 서비스 통합
2. 플레이어 뷰 UI 구현
3. 재생 컨트롤 기능 구현
4. 미니 플레이어 개발
5. 재생 상태 관리 로직 구현

### Phase 5: 라이브러리 및 둘러보기 화면 🚧 (진행 중)

1. 라이브러리 화면 기본 레이아웃 구현
2. 둘러보기 화면 기본 구조 설정
3. 샘플 데이터 통합

### Phase 6: 마무리 및 최적화 🚧 (시작)

- [x] 성능 최적화
- [x] 버그 수정
- [x] 코드 정리 및 문서화

✨ 프로젝트 완료 ✨
