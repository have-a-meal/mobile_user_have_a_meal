# 프로젝트 정보

<a><img src="https://img.shields.io/badge/-Flutter-387ADF?style=flat-plastic&logo=Flutter&logoColor=white"/>
<img src="https://img.shields.io/badge/-Provider-FBA834?style=flat-plastic&logo=Provider&logoColor=white"/>
<img src="https://img.shields.io/badge/-Github-black?style=flat-plastic&logo=Github&logoColor=white"/></a>

개발자 : 이재현


프로젝트 한줄소개 : 학교에서 키오스크에서 구매하는 학식권을 모바일에서 구매하고 이를 인증할 수 있는 프로그램


프로젝트 화면 구조
- 로그인 / 회원가입
- 날짜별 식단표 출력
- 식권 구매
- 구매한 식권을 QR로 표시
- 결제 내역 표시

## 폴더 구조

- lib : 코드 파일이 위치해 있는곳
- assets : 이미지나 비디오 파일을 넣는곳
- features : 기능 별로 파일/폴더 생성
- constants : 정적으로 생성한 클래스들이 위치한 곳
- models : 앱 내부에서 쓰는 모델들을 모아놓은곳
- storages : 클라이언트에 저장되는 스토리지(암호화)
- utils : 라이브러리를 간단하게 사용하기 위한 파일을 모아놓은곳

## 라이브러리

- cupertino_icons: ^1.0.6 (애플 스타일 아이콘)
- font_awesome_flutter: ^10.7.0 (아이콘)
- http: ^1.2.1 (통신)
- flutter_secure_storage: ^9.0.0 (AES 스토리지)
- provider: ^6.1.2 (상태 관리)
- go_router: ^13.2.2 (라우터 페이지 관리)
- intl: ^0.19.0 (날짜, 단위 포맷)
- flutter_localization: ^0.2.0 (한국어 적용)
- gap: ^3.0.1 (Gap)
- iamport_flutter: ^0.10.18 (아임포트 결제 관리)


# 프로토타입 화면
## 로그인 / 회원가입
<img src="https://github.com/have-a-meal/front_have_a_meal/assets/77985708/a6123e66-0430-48dd-a572-1f149c99a7e0.png"  width="175" height="400"/>
<img src="https://github.com/have-a-meal/front_have_a_meal/assets/77985708/76c4a8fd-1231-4d06-a323-208f5d09ffe3.png"  width="175" height="400"/>
<img src="https://github.com/have-a-meal/front_have_a_meal/assets/77985708/14ff9498-2ad6-4ede-b8e1-3d381c846f86.png"  width="175" height="400"/>
<img src="https://github.com/have-a-meal/front_have_a_meal/assets/77985708/c1fd0b95-c2f3-42fd-aafb-e8a0509dcad1.png"  width="175" height="400"/>
<img src="https://github.com/have-a-meal/front_have_a_meal/assets/77985708/60aeecd8-73be-413f-a8db-5cf855e6c549.png"  width="175" height="400"/>
<img src="https://github.com/have-a-meal/front_have_a_meal/assets/77985708/7cb61774-c777-42ba-82da-717ad1562acd.png"  width="175" height="400"/>

## 비밀번호 재설정
<img src="https://github.com/have-a-meal/mobile_user_have_a_meal/assets/77985708/f6c17e5e-e737-4801-9067-8c8e8b1c2ab0.png"  width="175" height="400"/>
<img src="https://github.com/have-a-meal/mobile_user_have_a_meal/assets/77985708/767e9fff-0b7f-42f5-a3c6-f6df69f08fb7.png"  width="175" height="400"/>
<img src="https://github.com/have-a-meal/mobile_user_have_a_meal/assets/77985708/8e105c43-a39f-4057-835f-bdca7d934c58.png"  width="175" height="400"/>

## 학식 조회 및 식권 사용
<img src="https://github.com/have-a-meal/mobile_user_have_a_meal/assets/77985708/32325bc9-d3ac-4758-81b3-15d9d2207a97.png"  width="175" height="400"/>

## 내 식권 조회
<img src="https://github.com/have-a-meal/mobile_user_have_a_meal/assets/77985708/b63a12f6-2f3e-440e-81ea-a9bd9b92e12c.png"  width="175" height="400"/>
<img src="https://github.com/have-a-meal/mobile_user_have_a_meal/assets/77985708/94a40cdb-9de2-4fba-a863-38e44381fc8e.png"  width="175" height="400"/>

## 식권 결제
<img src="https://github.com/have-a-meal/mobile_user_have_a_meal/assets/77985708/61f94e98-99a1-4351-badd-68fffa556b95.png"  width="175" height="400"/>
<img src="https://github.com/have-a-meal/front_have_a_meal/assets/77985708/41328f1c-a6f4-4992-a6c3-8d80042b4899.png"  width="175" height="400"/>
<img src="https://github.com/have-a-meal/front_have_a_meal/assets/77985708/13858905-cf1b-46bb-b15f-4f1363fa9cb3.png"  width="175" height="400"/>
<img src="https://github.com/have-a-meal/front_have_a_meal/assets/77985708/11978207-7295-496d-b5a5-2e450845f986.png"  width="175" height="400"/>

## 마이페이지 / 설정
<img src="https://github.com/have-a-meal/mobile_user_have_a_meal/assets/77985708/21710b5e-f805-4d1b-9237-ad1f0e1ccff9.png"  width="175" height="400"/>
<img src="https://github.com/have-a-meal/front_have_a_meal/assets/77985708/a1c46807-c16d-4292-a806-f2e7f0bbc043.png"  width="175" height="400"/>
<img src="https://github.com/have-a-meal/front_have_a_meal/assets/77985708/32c0bec4-994c-4af2-a005-1b9d0b9ef02f.png"  width="175" height="400"/>
<img src="https://github.com/have-a-meal/mobile_user_have_a_meal/assets/77985708/49dfa27f-dbd1-4643-9ad0-3668dc2054c0.png"  width="175" height="400"/>
<img src="https://github.com/have-a-meal/mobile_user_have_a_meal/assets/77985708/300da49a-209d-44b1-90ca-ae410326448b.png"  width="175" height="400"/>
<img src="https://github.com/have-a-meal/front_have_a_meal/assets/77985708/af6505b0-82a9-484f-886d-36ce462c1990.png"  width="175" height="400"/>

## 결제 내역 / 식권 환불
<img src="https://github.com/have-a-meal/mobile_user_have_a_meal/assets/77985708/c4df67e6-422b-43b6-9ff2-6549524f721c.png"  width="175" height="400"/>
<img src="https://github.com/have-a-meal/mobile_user_have_a_meal/assets/77985708/352e1b4e-75a3-46e9-aade-a54a919d2a94.png"  width="175" height="400"/>
<img src="https://github.com/have-a-meal/mobile_user_have_a_meal/assets/77985708/f43e5289-fc95-4426-a75c-ae1d8cb83c42.png"  width="175" height="400"/>
<img src="https://github.com/have-a-meal/front_have_a_meal/assets/77985708/62a2b510-f410-4259-960a-90ff6b11ed3a.png"  width="175" height="400"/>
<img src="https://github.com/have-a-meal/mobile_user_have_a_meal/assets/77985708/481a2053-d671-49c6-bbab-736d0af280f6.png"  width="175" height="400"/>
