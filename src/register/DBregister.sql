--회원 테이블 삭제

DROP TABLE REGISTER
CASCADE CONSTRAINTS;

--회원 검색

SELECT * FROM REGISTER;

--회원 테이블

CREATE TABLE REGISTER
(
	ID VARCHAR2(20) PRIMARY KEY, --아이디
	PWD VARCHAR2(20) NOT NULL, --패스워드
	NAME VARCHAR2(20) NOT NULL, --이름
	BIRTH VARCHAR2(20) NOT NULL, --생일

	POSTCODE VARCHAR2(20), --우편번호
	ADDRESS VARCHAR2(100) NOT NULL, --주소
	DETAILADDRESS VARCHAR2(50), --상세주소
	EXTRAADDRESS VARCHAR2(50) NOT NULL, --참고항목
	
	EMAIL VARCHAR2(30) UNIQUE, --이메일

	PHONENUM VARCHAR2(20) NOT NULL, --전화번호
	AUTH NUMBER(1) NOT NULL --사용자/관리자
);