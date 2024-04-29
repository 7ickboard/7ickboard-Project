# 7ickboard Project

## GitHub Repository, Video

- Git Repository: https://github.com/7ickboard/7ickboard-Project
- Video:

[https://youtu.be/h7zU1XFNZMc](https://youtu.be/h7zU1XFNZMc)

## 7ickboard Project

- Teams
    - 조장: 서수영 - 코드 조언 및 Map 관련 구현
    - 팀원: 박충건 - 발표 및 TableView 관련 구현
    - 팀원: 방기남 - 발표자료 준비 및 UserDefaults 관련 구현

- 기획 의도
    - 가지고 있는 기술과 시간 내에서 쉽고 깔끔한 앱으로 킥보드를 빌려 탈수 있게 만들어 보자는 취지로 기획

## Wireframe

![Untitled](7ickboard%20Project%200061fecea35a473a9bc9e7c957308dd2/Untitled.png)

## 개발 기능 정리

### **파일 세부 정보 및 아키텍처 구성**

[제목 없는 데이터베이스](7ickboard%20Project%200061fecea35a473a9bc9e7c957308dd2/%E1%84%8C%E1%85%A6%E1%84%86%E1%85%A9%E1%86%A8%20%E1%84%8B%E1%85%A5%E1%86%B9%E1%84%82%E1%85%B3%E1%86%AB%20%E1%84%83%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%90%E1%85%A5%E1%84%87%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%89%E1%85%B3%20bd4db1662f964948aed7862aac467f92.csv)

### 페이지별 기능 소개

- UI Flow

![Untitled](7ickboard%20Project%200061fecea35a473a9bc9e7c957308dd2/Untitled%201.png)

| Page | Person in Charge | Function and logic |
| --- | --- | --- |
| Sign in | 방기남 | * 앱의 첫 화면, 로그인을 위한 id, password TextField구현
* id, password 조건에 맞춰 입력되어야하만 아래 sign in 버튼으로 로그인 가능 ( 그 외 alert처리 )
* 로그인 성공 시 id, password를 UserDefaults에 저장하여 다음 앱 실행 시 자동으로 입력되도록 구현, 다음 mapPage로 이동 |
| Sign up | 방기남 | * Sign in을 위한 회원가입 화면
* 각 TextField의 조건을 설정, 조건에 모두 합당할 경우 아래 Sign up 버튼으로 User 타입의 데이터를 반환
* ScorllView로 View를 구현하여 키보드가 올라옴에 따라 화면이 가려짐 방지 |
| Map | 서수영 | * Mapkit과 kakao api를 사용해 구현, CoreLocation을 사용해 현재 위치 정보 로드
* 통신 로직: WebView로 패킹된 GitHub page를 사용해 주소 검색페이지 로딩, String타입의 주소를 가지고 Task로 Kakao 주소 검색의 restful api를 이용해 위도와 경도를 반환, mapView를 해당 위도와 경도로 이동
* Register에서 등록된 킥보드를 이용,반납 시 Kickboard타입의 데이터 생성 |
| Register | 서수영 | * 현재 위치에만 등록가능하도록 구현, 현재 위치로 지도를 고정TabbarController 이동시 sceneDelegate에 window의 rootViewController를 변경하면서 화면 전환 |
| Mypage | 박충건 | * 앞선 페이지에서 저장된 User 타입과 Kickboard 타입의 데이터를 받아와 각 항목에 맞는 Label과 TableView에 출력
* 로그아웃 버튼으로 로그인 화면으로 화면 전환 |

## Troubleshooting

### 기술 구현에 대한 고민

- KickBoard 등록시 MapView의 Annotation데이터와 등록된 kickboard 데이터가 바인딩되어야 했음 -> Annotaion과 kickboard 인스턴스를 동일시하게 생각하기 위해 Custom MKAnnotaion을 정의해 Annotaion이 해당하는 Kickboard 객체를 소유하고 있도록 구현
- User의 데이터는 간단한 정보만의 저장을 위해 UserDefaults를 사용하려 했으나 Custom Type의 사용이 불가피하였음 → 사용하려는 구조체에 Codable 프로토콜을 채택하여 UserDefaluts에 저장될 내용을 decode, encode하여 해결
- 데이터를 받아올 때 데이터를 받아오는 코드와 화면이동 구현에 어려움 → 팀원모두가 Develop 브랜치로 병합 후 데이터와 화면의 이동과정을 같이 확인 및 필요 시 코드 수정

## UI/UX 개선을 위한 고민

- 로그인 후 navigationController를 사용해 Stack에 담게 될 경우 TabBarController의 navigationController와 중첩되며 naviagtionBar가 중복되어 보여지는 현상 -> 하나의 navigationBar를 hidden하지 않고 안전한 구조를 위해 window의 rootViewController를 변경해주는 방식으로 해결
- TextField 입력 시 빈 화면을 눌러 키보드를 자유롭게 내려갈 수 있게 하여 UX개선 도모 → AppDelegate 내 UIViewContorller에 UITapGestureRecognizer 클래스를 이용하여 싱글 탭, 더블탭등 탭시 키보드를 dismiss시키는 방식으로 해결

## 소감

- MapKit과 kakao api의 사용법을 익히고 구현하는데에 생각보다 시간이 많이 소요되었지만  많은 걸 배울 수 있는 시간이었고 협업을 통해 git을 사용하여 매끄럽게 프로젝트가 잘 진행될 수 있게함을 익히고 복습하는 시간이 되었다.
- 알고있던 내용들도 정확히 구현을 못하거나 한번 사용해 봤다고 자만하는 등, 아직 개발자로서 배워야 할 산이 많다고 느꼈다. 새로운 구현과 기술을 배우는데 겁먹지 말고 모르는 부분은 서로 물어보고 내가 아는 내용은 알려주며 동료와 같이 해내어 나갈 수 있다는 믿음이 중요했던 프로젝트였다.
- 팀프로젝트때마다 항상 가슴졸이고 작아지는걸 느낍니다 아직 많이 부족하고 배울게 많다는걸 느꼈고 많은 도움주고 같이 마무리한 팀원분들 정말 감사합니다.