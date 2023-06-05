# simple_board

## 📘목차
- [개요](#1-프로젝트-개요)
- [기술 및 도구](#2-기술-및-도구)
- [기능 구현](#3-기능-구현)

## 1. 프로젝트 개요
![image](https://github.com/Muggle-1133/simple_board/assets/97649633/268468ac-0a58-486c-92a5-e13c79faad84)
> <b>프로젝트</b>: 게시판 사이트<br />
> <b>기획 및 제작</b>: 양수연<br />
> <b>분류</b>: 개인 프로젝트<br />
> <b>제작 기간</b>: 2022년 07월 ~ 08월<br />
> <b>주요 기능</b>: 게시판 글쓰기/읽기/조회하기/수정하기/삭제하기, 회원가입/로그인/로그아웃<br />
> <b>사용 기술</b>: JSP, HTML, CSS, javascript, jquery<br />
> <b>문의</b>: flyyangsy@gmail.com

## 2. 기술 및 도구
<img src="https://img.shields.io/badge/java-007396?style=for-the-badge&logo=java&logoColor=white"> <img src="https://img.shields.io/badge/html5-E34F26?style=for-the-badge&logo=html5&logoColor=white"> <img src="https://img.shields.io/badge/css-1572B6?style=for-the-badge&logo=css3&logoColor=white"> <img src="https://img.shields.io/badge/javascript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black"> <img src="https://img.shields.io/badge/jquery-0769AD?style=for-the-badge&logo=jquery&logoColor=white">

## 3. 기능 구현
### 1. 회원가입/로그인
![ezgif com-video-to-gif](https://github.com/Muggle-1133/simple_board/assets/97649633/9c018309-a5bf-4fd7-bad0-03211a9f92f1)
- 회원가입 시 ajax로 아이디 중복 검사
- 비밀번호, 비밀번호 확인 일치 검사
- 로그인 시 아이디 저장을 체크하면 쿠키 저장, 체크 해제 시 쿠키 삭제

### 2. 게시판 글쓰기/조회하기/읽기
![ezgif com-video-to-gif (1)](https://github.com/Muggle-1133/simple_board/assets/97649633/cbc5582c-ca5d-4eb5-9a8b-6914b128996b)
- 로그인하지 않은 사용자는 글 작성/읽기/수정/삭제 제한
- 검색란에 제목 or 글쓴이로 작성한 글 조회

### 3. 게시판 글 수정하기/삭제하기
![ezgif com-video-to-gif (2)](https://github.com/Muggle-1133/simple_board/assets/97649633/ef5b3670-3bf2-432b-bc4d-67b914dc6dec)
- 게시판 글을 작성한 사용자 본인만 글을 수정 및 삭제하도록 제한
