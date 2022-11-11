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

## 스크린샷
- 추후 추가 예정

## 레퍼런스
https://github.com/kauemurakami/getx_pattern
