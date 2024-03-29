![첫번째 이미지](https://user-images.githubusercontent.com/86656269/201342274-329e1049-1d21-414d-b484-14865024053b.png)

# 그누맵(GNU MAP)
경상국립대학교 길 찾기 및 편의시설과 건물 정보 제공 어플리케이션 입니다.

## 개발환경
- Flutter @3.5.0-12.0.pre.137 
- Android Studio Dolphin 2021.3.1 patch1

## 라이브러리
- fluttertoast ^8.0.9
- location: ^4.3.0
- flutter_inappwebview: ^5.4.3+7
- http: ^0.13.4
- app_settings: ^4.1.6
- get: ^4.6.5
- hive: ^2.2.3
- hive_flutter: ^1.1.0

## 리팩토링 변경점
- GetX 러아브러리를 통한 상태관리 및 편리한 라우트
- SQLite에서 NoSQL인 Hive를 사용하여 더 빠른 Database 접근 및 값 가져오기 가능
- Provider - Repository - Controller 구조를 통해서, Coupling 수준을 낮춤
- 한 스크린.dart 파일안에 모든 위젯이 있는게 아니라, 위젯을 단위별로 쪼개서 더 손쉬운 위젯 관리 가능
- GetX TransLation 사용

## 배포
#### AppStore
https://apps.apple.com/us/app/%EA%B7%B8%EB%88%84%EB%A7%B5-gnu-map/id6444317161
#### PlayStore
https://play.google.com/store/apps/details?id=com.eighteenclass.gnumap

## 버전 변경점
### 1.1.1
- 업데이트 후 기존의 즐겨찾기와 히스토리 목록이 뜨지 않는 버그를 수정하였습니다.

### 1.1.0
- 칠암, 의간, 통영 캠퍼스 건물 정보를 추가하였습니다.
- 학교 순환버스 정보 조회 기능 추가하였습니다.
- 사용자의 화면 설정이 지누맵에 제대로 반영되지 않는 오류를 수정하였습니다.
- 어플 용량 최적화를 하였습니다.

### 1.0.10
- 메인페이지에서 키보드가 닫히지 않는 오류를 수정하였습니다.

### v1.0.9
- 메인 페이지에서 한글이 나타나지 않는 오류를 수정하였습니다.

#### v1.0.8
- 어플 용량을 획기적으로 줄였습니다. 더욱 가볍게 지누맵을 이용해보세요!

#### v1.0.7
- 저작권 문제로 어플 이름을 지누맵으로 변경하였습니다

#### v1.0.6
- 한국어 모드에서 편의시설 페이지 접속 시 타이틀명이 변수 이름으로 뜨는 버그 수정

#### v1.0.5
학교 저작권 문제로 어플리케이션 로고 변경

#### v1.0.4
건물 검색할 때 빈 검색어 예외처리 및, 글자수 10글자 제한

#### v.1.0.3
한국어 모드에서 편의시설 타이틀이 이상하게 나타나는 오류 수정

## 레퍼런스
https://github.com/kauemurakami/getx_pattern
