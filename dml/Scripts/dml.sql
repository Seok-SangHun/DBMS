CREATE TABLE TBL_STUDENT(
	ID NUMBER CONSTRAINT PK_SUTDENT PRIMARY KEY,
	STUDENT_NAME VARCHAR2(255) NOT NULL
);

/*TBL_STUDENT 테이블에서 ID와 STUDENT_NAME 전체 조회*/
SELECT ID, STUDENT_NAME FROM TBL_STUDENT;

/*ID는 1, NAME은 한동석 값 삽입*/
INSERT INTO TBL_STUDENT (ID, STUDENT_NAME)
VALUES(1, '한동석');

/*ID가 1인 NAME을 홍길동으로 변경*/
UPDATE TBL_STUDENT
SET STUDENT_NAME ='홍길동'
WHERE ID = 1;

/*TBL_SUTUDET에서 ID가 1인 데이터 삭제*/
DELETE FROM TBL_STUDENT
WHERE ID = 1;

/*동물원*/
CREATE TABLE TBL_ZOO(
   ID NUMBER CONSTRAINT PK_ZOO PRIMARY KEY,
   ZOO_NAME VARCHAR2(255),
   ZOO_ADDRESS VARCHAR2(255),
   ZOO_ADDRESS_DETAIL VARCHAR2(255),
   ZOO_MAX_ANIMAL NUMBER DEFAULT 0
);

/*동물*/
CREATE TABLE TBL_ANIMAL(
   ID NUMBER CONSTRAINT PK_ANIMAL PRIMARY KEY,
   ANIMAL_NAME VARCHAR2(255),
   ANIMAL_TYPE VARCHAR2(255),
   ANIMAL_AGE NUMBER DEFAULT 0,
   ANIMAL_HEIGHT NUMBER(16, 5),
   ANIMAL_WEIGHT NUMBER(16, 5),
   ZOO_ID NUMBER,
   CONSTRAINT FK_ANIMAL_ZOO FOREIGN KEY(ZOO_ID)
   REFERENCES TBL_ZOO(ID)
);
ALTER TABLE TBL_ANIMAL MODIFY(ANIMAL_HEIGHT NUMBER(16,5));
ALTER TABLE TBL_ANIMAL MODIFY(ANIMAL_WEIGHT NUMBER(16,5));

/*알아서 매번 다음 SEQUENCE를 가져와준다. */
/*시퀀스를 직접 만들어서 사용해야 한다.*/
CREATE SEQUENCE SEQ_ZOO;


SELECT * FROM TBL_ZOO;
INSERT INTO TBL_ZOO
VALUES(SEQ_ZOO.NEXTVAL, '서울랜드', '서울', '랜드', 100);

INSERT INTO TBL_ZOO
VALUES(SEQ_ZOO.NEXTVAL, '에버랜드', '경기', '용인', 500);

UPDATE TBL_ZOO 
SET ZOO_MAX_ANIMAL  = 5000
WHERE ZOO_NAME = '에버랜드';

DELETE FROM TBL_ZOO
WHERE ID = 1;

CREATE SEQUENCE SEQ_ANIMAL;
SELECT * FROM TBL_ANIMAL;
INSERT INTO TBL_ANIMAL 
VALUES(SEQ_ANIMAL.NEXTVAL, '사자', '맹수',3,87.5,120.242,2);

INSERT INTO TBL_ANIMAL 
VALUES(SEQ_ANIMAL.NEXTVAL, '악어', '도마뱀',12,300.5,180.242,2);

/*에버랜드(2) 동물원의 동물만 조회*/
SELECT ID ,ANIMAL_NAME ,ANIMAL_TYPE ,ANIMAL_AGE ,ANIMAL_HEIGHT ,ANIMAL_WEIGHT ,ZOO_ID 
FROM TBL_ANIMAL
WHERE ZOO_ID =2;

/****************************************************************************************************************************/
/****************************************************************************************************************************/
/****************************************************************************************************************************/
/*<구현>*/
CREATE TABLE TBL_USER(
	ID NUMBER CONSTRAINT PK_USER PRIMARY KEY,
	USER_ID VARCHAR2(1000) CONSTRAINT UK_USER UNIQUE NOT NULL,
	USER_PASSWORD VARCHAR2(1000) NOT NULL,
	USER_NAME VARCHAR2(1000) NOT NULL,
	USER_ADDRESS VARCHAR2(1000) NOT NULL,
	USER_EMAIL VARCHAR2(1000) NOT NULL,
	USER_BIRTHDAY DATE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE TBL_ORDER(
	ID NUMBER CONSTRAINT PK_ORDER PRIMARY KEY,
	ORDER_DATE DATE DEFAULT CURRENT_TIMESTAMP,
	USER_ID NUMBER,
	CONSTRAINT FK_ORDER_USER FOREIGN KEY(USER_ID)
    REFERENCES TBL_USER(ID),
    PRODUCT_ID NUMBER,
    CONSTRAINT FK_ORDER_PRODUCT FOREIGN KEY(PRODUCT_ID)
    REFERENCES TBL_PRODUCT(ID)
);

CREATE TABLE TBL_PRODUCT(
	ID NUMBER CONSTRAINT PK_PRODUCT PRIMARY KEY,
	PRODUCT_NAME VARCHAR(2000) NOT NULL,
	PRODUCT_PRICE NUMBER DEFAULT 0,
	PRODUCT_INVENTORY NUMBER DEFAULT 0
);


/*각 테이블에 3개 이상씩 정보를 추가하고, 조회한다*/
/*수정 2회*/
/*삭제 2회*/
CREATE SEQUENCE SEQ_USER;
SELECT * FROM TBL_USER;
INSERT INTO TBL_USER
VALUES(SEQ_USER.NEXTVAL, 'DDDDD', '1111', '상훈', '서울 강남', 'SEKKF@GMAIL.COM', '2001-11-11');
INSERT INTO TBL_USER
VALUES(SEQ_USER.NEXTVAL, 'AEFEF', '2222', '길동', '강원도', 'QGEQRF@GMAIL.COM', '2010-01-03');
INSERT INTO TBL_USER
VALUES(SEQ_USER.NEXTVAL, 'ADFASDF', '3333', '야호', '충청북도', 'CNDQNR@GMAIL.COM', '3000-11-23');

UPDATE TBL_USER 
SET USER_ID ='AAAAA'
WHERE ID = 1;
UPDATE TBL_USER 
SET USER_ADDRESS ='하와이'
WHERE ID = 2;

DELETE FROM TBL_USER
WHERE ID = 3;

/*사용하고 있는 PRODUCT가 있어서 삭제 불가*/
DELETE FROM TBL_USER
WHERE ID = 1;


CREATE SEQUENCE SEQ_PRODUCT;
SELECT * FROM TBL_PRODUCT;
INSERT INTO TBL_PRODUCT
VALUES(SEQ_PRODUCT.NEXTVAL,'상품1', 20000, 300);
INSERT INTO TBL_PRODUCT
VALUES(SEQ_PRODUCT.NEXTVAL,'상품2', 50500, 100);
INSERT INTO TBL_PRODUCT
VALUES(SEQ_PRODUCT.NEXTVAL,'상품3', 13100, 200);


CREATE SEQUENCE SEQ_ORDER;
SELECT * FROM TBL_ORDER;
INSERT INTO TBL_ORDER
VALUES(SEQ_ORDER.NEXTVAL, '2000-10-16', '1','2');
INSERT INTO TBL_ORDER
VALUES(SEQ_ORDER.NEXTVAL, '2000-10-18', '1','3');
INSERT INTO TBL_ORDER
VALUES(SEQ_ORDER.NEXTVAL, '2000-11-18', '2','2');

/****************************************************************************************************************************/
/****************************************************************************************************************************/
/****************************************************************************************************************************/
/****************************************************************************************************************************/
/****************************************************************************************************************************/
/****************************************************************************************************************************/
/**********************************************************************/
CREATE SEQUENCE SEQ_OWNER;
CREATE SEQUENCE SEQ_PET;

CREATE TABLE TBL_OWNER(
   ID NUMBER CONSTRAINT PK_OWNER PRIMARY KEY,
   OWNER_NAME VARCHAR2(255) NOT NULL,
   OWNER_AGE NUMBER,
   OWNER_PHONE VARCHAR2(255) NOT NULL,
   OWNER_ADDRESS VARCHAR2(255)
);

CREATE TABLE TBL_PET(
   ID NUMBER CONSTRAINT PK_PET PRIMARY KEY,
   PET_ILL_NAME VARCHAR2(255),
   PET_NAME VARCHAR2(255),
   PET_AGE NUMBER,
   WEIGHT NUMBER(4, 2),
   OWNER_ID NUMBER,
   CONSTRAINT FK_PET_OWNER FOREIGN KEY(OWNER_ID)
   REFERENCES TBL_OWNER(ID)
);

INSERT INTO TBL_OWNER
(ID, OWNER_NAME, OWNER_AGE, OWNER_PHONE, OWNER_ADDRESS)
VALUES(SEQ_OWNER.NEXTVAL, '한동석', 20, '01012341234', '경기도');
INSERT INTO TBL_OWNER
(ID, OWNER_NAME, OWNER_AGE, OWNER_PHONE, OWNER_ADDRESS)
VALUES(SEQ_OWNER.NEXTVAL, '홍길동', 37, '01087879898', '서울');
INSERT INTO TBL_OWNER
(ID, OWNER_NAME, OWNER_AGE, OWNER_PHONE, OWNER_ADDRESS)
VALUES(SEQ_OWNER.NEXTVAL, '이순신', 50, '01044445555', '대구');

SELECT ID, OWNER_NAME, OWNER_AGE, OWNER_PHONE, OWNER_ADDRESS 
FROM TBL_OWNER;

INSERT INTO TBL_PET
(ID, PET_ILL_NAME, PET_NAME, PET_AGE, WEIGHT, OWNER_ID)
VALUES(SEQ_PET.NEXTVAL, '장염', '뽀삐', 4, 10.45, 1);
INSERT INTO TBL_PET
(ID, PET_ILL_NAME, PET_NAME, PET_AGE, WEIGHT, OWNER_ID)
VALUES(SEQ_PET.NEXTVAL, '감기', '달구', 12, 14.25, 1);
INSERT INTO TBL_PET
(ID, PET_ILL_NAME, PET_NAME, PET_AGE, WEIGHT, OWNER_ID)
VALUES(SEQ_PET.NEXTVAL, '탈골', '댕댕', 7, 8.46, 1);
INSERT INTO TBL_PET
(ID, PET_ILL_NAME, PET_NAME, PET_AGE, WEIGHT, OWNER_ID)
VALUES(SEQ_PET.NEXTVAL, '염좌', '쿠키', 11, 5.81, 1);
INSERT INTO TBL_PET
(ID, PET_ILL_NAME, PET_NAME, PET_AGE, WEIGHT, OWNER_ID)
VALUES(SEQ_PET.NEXTVAL, '충치', '바둑', 1, 3.47, 1);

SELECT ID, PET_ILL_NAME, PET_NAME, PET_AGE, WEIGHT, OWNER_ID
FROM TBL_PET;

/*몸무게가 8kg 미만인 반려동물들의 주인에게 모두 전화를 해야한다*/
SELECT PET_ILL_NAME, PET_NAME, WEIGHT, OWNER_ID, O.OWNER_NAME, O.OWNER_PHONE
FROM TBL_OWNER O JOIN TBL_PET P
ON O.ID = P.OWNER_ID AND WEIGHT < 8;

/*이순신이 키우는 반려동물의 병명을 조회한다. */
SELECT PET_ILL_NAME,PET_NAME
FROM TBL_OWNER O JOIN TBL_PET P
ON O.ID = P.OWNER_ID AND O.OWNER_NAME = '이순신';

/*나이가 5살보다 많은 반려동물의 주인 전체 정보를 조회한다.*/
SELECT DISTINCT OWNER_NAME, OWNER_AGE, OWNER_PHONE, OWNER_ADDRESS 
FROM TBL_OWNER O JOIN TBL_PET P
ON O.ID = P.OWNER_ID AND P.PET_AGE > 5;


/*나이가 5살보다 많은 반려동물의 주인 전체 정보를 조회한다.*/
SELECT 
   TBL_OWNER.ID, TBL_OWNER.OWNER_NAME, TBL_OWNER.OWNER_AGE, 
   TBL_OWNER.OWNER_PHONE, TBL_OWNER.OWNER_ADDRESS,
   TBL_PET.PET_NAME, TBL_PET.PET_AGE
FROM TBL_OWNER JOIN TBL_PET
ON TBL_OWNER.ID = TBL_PET.OWNER_ID AND TBL_PET.PET_AGE > 5;

/*AS: 알리아스(별칭)
 * 
 * 테이블명 혹은 컬럼명 뒤에 AS를 붙여서 원하는 이름을 설정할 수 있다.
 * 이후부터는 설정한 이름으로 사용하면 된다.
 * SELECT절에는 AS를 작성해도 괜찮지만, FROM절에서는 AS를 작성하면 안된다.
 * 이럴 때에는 AS자리에 띄어쓰기 후 작성하도록 한다.
 * 
 * */
SELECT 
   O.ID "주인 번호", O.OWNER_NAME "SELECT", O.OWNER_AGE, 
   O.OWNER_PHONE, O.OWNER_ADDRESS,
   P.PET_NAME, P.PET_AGE
FROM TBL_OWNER O JOIN TBL_PET P 
ON O.ID = P.OWNER_ID AND P.PET_AGE > 5;

/*CONCATENATION: 연결
 * 
 * "안" + "녕": JAVA
 * '안' || '녕': ORACLE
 * 
 * */

SELECT O.OWNER_NAME || '님의 반려동물은 ' || P.PET_NAME || '입니다.' AS 자기소개
FROM TBL_OWNER O JOIN TBL_PET P
ON O.ID = P.OWNER_ID;

/*
 * LIKE: 포함된 문자열 값을 찾고, 문자의 개수도 제한을 줄 수 있다.
 *
 * %: 모든 것
 * _: 글자 수
 * 
 * 예시
 * '%A'   : A로 끝나는 모든 값
 * 'A%'   : A로 시작하는 모든 값
 * 'A__': A로 시작하면서 3글자인 값
 * '_A'   : A로 끝나면서 2글자인 값
 * '%A%': A가 포함된 값 
 * 
 * */

SELECT * FROM TBL_PET;
/*반려동물 이름에서 '뽀'가 포함된 반려동물의 주인 정보 조회*/
SELECT O.OWNER_NAME ,O.OWNER_AGE ,O.OWNER_PHONE ,O.OWNER_ADDRESS 
FROM TBL_OWNER O JOIN TBL_PET P
ON O.ID = P.OWNER_ID AND P.PET_NAME LIKE '%댕%';

/*핸드폰 번호에 '0101234'로 시작하는 주인의 반려동물 전체 조회*/
SELECT P.PET_NAME,P.PET_ILL_NAME ,P.PET_AGE ,P.WEIGHT 
FROM TBL_OWNER O JOIN TBL_PET P
ON O.ID = P.OWNER_ID AND O.OWNER_PHONE LIKE '0101234%';

/*반려동물 병명에 '염'이 들어가있지 않는 반려동물 전체 정보 조회*/
SELECT P.PET_NAME,P.PET_ILL_NAME ,P.PET_AGE ,P.WEIGHT 
FROM TBL_OWNER O JOIN TBL_PET P
ON O.ID = P.OWNER_ID AND NOT P.PET_ILL_NAME LIKE '%염%';

/*****************************************************************************************/
/*****************************************************************************************/
/*****************************************************************************************/
/**********************************************************************/
CREATE SEQUENCE SEQ_KINDERGARTEN;
CREATE SEQUENCE SEQ_PARENT;
CREATE SEQUENCE SEQ_CHILD;
CREATE SEQUENCE SEQ_FIELD_TRIP;
CREATE SEQUENCE SEQ_FILE;
CREATE SEQUENCE SEQ_FIELD_TRIP_FILE;
CREATE SEQUENCE SEQ_MEMBER;
CREATE SEQUENCE SEQ_APPLY;

CREATE TABLE TBL_KINDERGARTEN(
   ID NUMBER CONSTRAINT PK_KINDERGARTEN PRIMARY KEY,
   KINDERGARTEN_NAME VARCHAR2(255),
   KINDERGARTEN_ADDRESS VARCHAR2(255)
);

CREATE TABLE TBL_PARENT(
   ID NUMBER CONSTRAINT PK_PARENT PRIMARY KEY,
   PARENT_NAME VARCHAR2(255) NOT NULL,
   PARENT_ADDRESS VARCHAR2(255) NOT NULL,
   PARENT_PHONE VARCHAR2(255) NOT NULL,
   PARENT_GENDER NUMBER DEFAULT 3
);

/*1: 여자, 2: 남자, 3: 선택안함*/
CREATE TABLE TBL_CHILD(
   ID NUMBER CONSTRAINT PK_CHILD PRIMARY KEY,
   CHILD_NAME VARCHAR2(255) NOT NULL,
   CHILD_AGE NUMBER NOT NULL,
   CHILD_GENDER NUMBER DEFAULT 3,
   PARENT_ID NUMBER,
   CONSTRAINT FK_CHILD_PARENT FOREIGN KEY(PARENT_ID)
   REFERENCES TBL_PARENT(ID)
);

CREATE TABLE TBL_FIELD_TRIP(
   ID NUMBER CONSTRAINT PK_FIELD_TRIP PRIMARY KEY,
   FIELD_TRIP_TITLE VARCHAR2(255),
   FIELD_TRIP_CONTENT VARCHAR2(255),
   KINDERGARTEN_ID NUMBER,
   CONSTRAINT FK_FIELD_TRIP_KINDERGARTEN FOREIGN KEY(KINDERGARTEN_ID)
   REFERENCES TBL_KINDERGARTEN(ID)
);

CREATE TABLE TBL_FILE(
   ID NUMBER CONSTRAINT PK_FILE PRIMARY KEY,
   FILE_NAME VARCHAR2(255),
   FILE_PATH VARCHAR2(255),
   FILE_SIZE NUMBER
);

CREATE TABLE TBL_FIELD_TRIP_FILE(
   ID NUMBER CONSTRAINT PK_FIELD_DRIP_FILE PRIMARY KEY,
   FIELD_TRIP_ID NUMBER NOT NULL,
   CONSTRAINT FK_FIELD_TRIP_FILE_FIELD_TRIP FOREIGN KEY(FIELD_TRIP_ID)
   REFERENCES TBL_FIELD_TRIP(ID),
   CONSTRAINT FK_FIELD_TRIP_FILE_FILE FOREIGN KEY(ID)
   REFERENCES TBL_FILE(ID)
);

CREATE TABLE TBL_MEMBER(
   ID NUMBER CONSTRAINT PK_MEMBER PRIMARY KEY,
   MEMBER_ID VARCHAR2(255) CONSTRAINT UK_MEMBER UNIQUE NOT NULL,
   MEMBER_PASSWORD VARCHAR2(255) NOT NULL,
   MEMBER_NAME VARCHAR2(255) NOT NULL,
   MEMBER_ADDRESS VARCHAR2(255) NOT NULL,
   MEMBER_EMAIL VARCHAR2(255),
   MEMBER_BIRTH DATE,
   KINDERGARTEN_ID NUMBER,
   CONSTRAINT FK_MEMBER_KINDERGARTEN FOREIGN KEY(KINDERGARTEN_ID)
   REFERENCES TBL_KINDERGARTEN(ID)
);

CREATE TABLE TBL_APPLY(
   ID NUMBER CONSTRAINT PK_APPLY PRIMARY KEY,
   PARENT_ID NUMBER NOT NULL,
   FIELD_TRIP_ID NUMBER NOT NULL,
   CONSTRAINT FK_APPLY_PARENT FOREIGN KEY(PARENT_ID)
   REFERENCES TBL_PARENT(ID),
   CONSTRAINT FK_APPLY_FIELD_TRIP FOREIGN KEY(FIELD_TRIP_ID)
   REFERENCES TBL_FIELD_TRIP(ID)
);

INSERT INTO TBL_PARENT
	(ID, PARENT_NAME, PARENT_ADDRESS, PARENT_PHONE)
	VALUES(SEQ_PARENT.NEXTVAL, '한동석', '경기도', '01012341234');
INSERT INTO TBL_PARENT
	(ID, PARENT_NAME, PARENT_ADDRESS, PARENT_PHONE)
	VALUES(SEQ_PARENT.NEXTVAL, '홍길동', '서울', '01012341235');
INSERT INTO TBL_PARENT
	(ID, PARENT_NAME, PARENT_ADDRESS, PARENT_PHONE)
	VALUES(SEQ_PARENT.NEXTVAL, '이순신', '대구', '01012345654');
INSERT INTO TBL_PARENT
	(ID, PARENT_NAME, PARENT_ADDRESS, PARENT_PHONE)
	VALUES(SEQ_PARENT.NEXTVAL, '장보고', '광주', '01012845234');

SELECT * FROM TBL_PARENT;

INSERT INTO TBL_CHILD
	(ID, CHILD_NAME, CHILD_AGE, CHILD_GENDER, PARENT_ID)
	VALUES(SEQ_CHILD.NEXTVAL, '또치', 5, 1, 2);
INSERT INTO TBL_CHILD
	(ID, CHILD_NAME, CHILD_AGE, CHILD_GENDER, PARENT_ID)
	VALUES(SEQ_CHILD.NEXTVAL, '둘리', 7, 2, 2);
INSERT INTO TBL_CHILD
	(ID, CHILD_NAME, CHILD_AGE, CHILD_GENDER, PARENT_ID)
	VALUES(SEQ_CHILD.NEXTVAL, '도너', 4, 1, 1);
INSERT INTO TBL_CHILD
	(ID, CHILD_NAME, CHILD_AGE, CHILD_GENDER, PARENT_ID)
	VALUES(SEQ_CHILD.NEXTVAL, '마이콜', 4, 2, 3);
INSERT INTO TBL_CHILD
	(ID, CHILD_NAME, CHILD_AGE, CHILD_GENDER, PARENT_ID)
	VALUES(SEQ_CHILD.NEXTVAL, '짱구', 5, 2, 4);
INSERT INTO TBL_CHILD
	(ID, CHILD_NAME, CHILD_AGE, CHILD_GENDER, PARENT_ID)
	VALUES(SEQ_CHILD.NEXTVAL, '짱아', 5, 1, 4);
INSERT INTO TBL_CHILD
	(ID, CHILD_NAME, CHILD_AGE, CHILD_GENDER, PARENT_ID)
	VALUES(SEQ_CHILD.NEXTVAL, '신형만', 12, 1, 2);

SELECT * FROM TBL_CHILD;

INSERT INTO TBL_APPLY
	(ID, PARENT_ID, FIELD_TRIP_ID)
	VALUES(SEQ_APPLY.NEXTVAL, 2, 1);
INSERT INTO TBL_APPLY
	(ID, PARENT_ID, FIELD_TRIP_ID)
	VALUES(SEQ_APPLY.NEXTVAL, 2, 2);
INSERT INTO TBL_APPLY
	(ID, PARENT_ID, FIELD_TRIP_ID)
	VALUES(SEQ_APPLY.NEXTVAL, 3, 6);
INSERT INTO TBL_APPLY
	(ID, PARENT_ID, FIELD_TRIP_ID)
	VALUES(SEQ_APPLY.NEXTVAL, 4, 7);
INSERT INTO TBL_APPLY
	(ID, PARENT_ID, FIELD_TRIP_ID)
	VALUES(SEQ_APPLY.NEXTVAL, 1, 5);
INSERT INTO TBL_APPLY
	(ID, PARENT_ID, FIELD_TRIP_ID)
	VALUES(SEQ_APPLY.NEXTVAL, 2, 3);
INSERT INTO TBL_APPLY
	(ID, PARENT_ID, FIELD_TRIP_ID)
	VALUES(SEQ_APPLY.NEXTVAL, 1, 7);
INSERT INTO TBL_APPLY
	(ID, PARENT_ID, FIELD_TRIP_ID)
	VALUES(SEQ_APPLY.NEXTVAL, 1, 6);
INSERT INTO TBL_APPLY
	(ID, PARENT_ID, FIELD_TRIP_ID)
	VALUES(SEQ_APPLY.NEXTVAL, 4, 1);
INSERT INTO TBL_APPLY
	(ID, PARENT_ID, FIELD_TRIP_ID)
	VALUES(SEQ_APPLY.NEXTVAL, 4, 5);
INSERT INTO TBL_APPLY
	(ID, PARENT_ID, FIELD_TRIP_ID)
	VALUES(SEQ_APPLY.NEXTVAL, 3, 3);

SELECT * FROM TBL_APPLY;
SELECT * FROM TBL_FIELD_TRIP;

INSERT INTO TBL_KINDERGARTEN
	(ID, KINDERGARTEN_NAME, KINDERGARTEN_ADDRESS)
	VALUES(SEQ_KINDERGARTEN.NEXTVAL, '병설유치원', '경기도 고양시');
INSERT INTO TBL_KINDERGARTEN
	(ID, KINDERGARTEN_NAME, KINDERGARTEN_ADDRESS)
	VALUES(SEQ_KINDERGARTEN.NEXTVAL, '파랑새유치원', '서울시 강남구');
INSERT INTO TBL_KINDERGARTEN
	(ID, KINDERGARTEN_NAME, KINDERGARTEN_ADDRESS)
	VALUES(SEQ_KINDERGARTEN.NEXTVAL, '불교유치원', '경기도 고양시');
INSERT INTO TBL_KINDERGARTEN
	(ID, KINDERGARTEN_NAME, KINDERGARTEN_ADDRESS)
	VALUES(SEQ_KINDERGARTEN.NEXTVAL, '세화유치원', '경기도 고양시');
INSERT INTO TBL_KINDERGARTEN
	(ID, KINDERGARTEN_NAME, KINDERGARTEN_ADDRESS)
	VALUES(SEQ_KINDERGARTEN.NEXTVAL, '대명유치원', '경기도 고양시');

SELECT * FROM TBL_KINDERGARTEN;

INSERT INTO TBL_FIELD_TRIP(ID, FIELD_TRIP_TITLE, FIELD_TRIP_CONTENT, KINDERGARTEN_ID)
	VALUES(SEQ_FIELD_TRIP.NEXTVAL, '어서와 매미농장', '매미 잡자 어서와', 1);
INSERT INTO TBL_FIELD_TRIP(ID, FIELD_TRIP_TITLE, FIELD_TRIP_CONTENT, KINDERGARTEN_ID)
	VALUES(SEQ_FIELD_TRIP.NEXTVAL, '아이스크림 빨리 먹기 대회', '아이스크림 누가 더 잘먹나', 3);
INSERT INTO TBL_FIELD_TRIP(ID, FIELD_TRIP_TITLE, FIELD_TRIP_CONTENT, KINDERGARTEN_ID)
	VALUES(SEQ_FIELD_TRIP.NEXTVAL, '고구마 심기', '고구마가 왕 커요', 2);
INSERT INTO TBL_FIELD_TRIP(ID, FIELD_TRIP_TITLE, FIELD_TRIP_CONTENT, KINDERGARTEN_ID)
	VALUES(SEQ_FIELD_TRIP.NEXTVAL, '숭어 얼음 낚시', '숭어 잡자 추워도 참아', 4);
INSERT INTO TBL_FIELD_TRIP(ID, FIELD_TRIP_TITLE, FIELD_TRIP_CONTENT, KINDERGARTEN_ID)
	VALUES(SEQ_FIELD_TRIP.NEXTVAL, '커피 체험 공장', '커비 빈 객체화', 4);
INSERT INTO TBL_FIELD_TRIP(ID, FIELD_TRIP_TITLE, FIELD_TRIP_CONTENT, KINDERGARTEN_ID)
	VALUES(SEQ_FIELD_TRIP.NEXTVAL, '치즈 제작하기', '여기 치즈 저기 치즈 전부 다 치즈', 4);
INSERT INTO TBL_FIELD_TRIP(ID, FIELD_TRIP_TITLE, FIELD_TRIP_CONTENT, KINDERGARTEN_ID)
	VALUES(SEQ_FIELD_TRIP.NEXTVAL, '동물 타보기', '이리야!', 2);

SELECT * FROM TBL_FIELD_TRIP;

/*집계 함수
 * 
 * 평균 AVG()
 * 최대값 MAX()
 * 최소값 MIN()
 * 총 합 SUM()
 * 개수 COUNT()
 * 
 * */

/*체험학습의 총 개수*/
SELECT COUNT(ID) FROM TBL_FIELD_TRIP;
SELECT MAX(ID) FROM TBL_FIELD_TRIP;
SELECT MIN(ID) FROM TBL_FIELD_TRIP;
SELECT AVG(ID) FROM TBL_FIELD_TRIP;
SELECT ROUND(AVG(KINDERGARTEN_ID), 2) AS "AVG" FROM TBL_FIELD_TRIP;
SELECT SUM(ID) FROM TBL_FIELD_TRIP;

/*GROUP BY: ~별
 * 
 * 
 * */

/*가장 인기있는 체험학습의 지원자 수를 조회한다.*/
SELECT MAX(COUNT(ID)) FROM TBL_APPLY
GROUP BY FIELD_TRIP_ID;

/*각 체험학습 별 지원자들의 평균 나이를 조회한다.*/
ALTER TABLE TBL_PARENT ADD (PARENT_AGE NUMBER DEFAULT 0);
SELECT * FROM TBL_PARENT;
/*부모 나이*/
SELECT FIELD_TRIP_ID, AVG(P.PARENT_AGE)
FROM TBL_PARENT P JOIN TBL_APPLY A
ON P.ID = A.PARENT_ID
GROUP BY FIELD_TRIP_ID;

/*아이들의 나이*/
SELECT FIELD_TRIP_ID, AVG(C.CHILD_AGE)
FROM TBL_PARENT P JOIN TBL_APPLY A
ON P.ID = A.PARENT_ID
JOIN TBL_CHILD C 
ON P.ID = C.PARENT_ID
GROUP BY FIELD_TRIP_ID;

/*부모들의 자녀의 수*/
SELECT * FROM TBL_PARENT;

SELECT P.ID, COUNT(C.ID) AS "COUNT"
FROM TBL_PARENT P JOIN TBL_CHILD C
ON P.ID = C.PARENT_ID 
GROUP BY P.ID;

/*부모들의 평균 자녀의 수*/
SELECT ROUND(AVG(COUNT(C.ID)),2) AS "AVG CHILD"
FROM TBL_PARENT P JOIN TBL_CHILD C
ON P.ID = C.PARENT_ID 
GROUP BY P.ID;

/*각 유치원들의 체험학습 진행 건수 */
SELECT * FROM TBL_FIELD_TRIP;

SELECT FT.KINDERGARTEN_ID, COUNT(FT.ID) 
FROM TBL_KINDERGARTEN K JOIN TBL_FIELD_TRIP FT
ON K.ID = FT.KINDERGARTEN_ID
GROUP BY FT.KINDERGARTEN_ID; 

/*각 유치원들의 체험학습 지원 건수 */
SELECT FT.KINDERGARTEN_ID, COUNT(A.FIELD_TRIP_ID) 
FROM TBL_FIELD_TRIP FT JOIN TBL_APPLY A
ON FT.ID = A.FIELD_TRIP_ID
GROUP BY FT.KINDERGARTEN_ID;

/*유치원들의 평균 체험학습 진행 건수 */
SELECT ROUND(AVG(COUNT(FT.ID)), 0) "평균 진행 건수"
FROM TBL_KINDERGARTEN K JOIN TBL_FIELD_TRIP FT
ON K.ID = FT.KINDERGARTEN_ID
GROUP BY FT.KINDERGARTEN_ID;



/**********************************************************************/

/*1. 시퀀스 제작*/
CREATE SEQUENCE SEQ_MEMBER;
CREATE SEQUENCE SEQ_LIKE;

CREATE TABLE TBL_MEMBER(
   ID NUMBER CONSTRAINT PK_MEMBER PRIMARY KEY,
   MEMBER_ID VARCHAR2(255) CONSTRAINT UK_MEMBER UNIQUE NOT NULL,
   MEMBER_PASSWORD VARCHAR2(255) NOT NULL,
   MEMBER_NAME VARCHAR2(255) NOT NULL,
   MEMBER_ADDRESS VARCHAR2(255) NOT NULL,
   MEMBER_EMAIL VARCHAR2(255),
   MEMBER_BIRTH DATE
);

CREATE TABLE TBL_LIKE(
   ID NUMBER CONSTRAINT PK_LIKE PRIMARY KEY,
   LIKE_RECEIVER NUMBER NOT NULL,
   LIKE_SENDER NUMBER NOT NULL,
   CONSTRAINT FK_LIKE_MEMBER_RECEIVER FOREIGN KEY(LIKE_RECEIVER)
   REFERENCES TBL_MEMBER(ID),
   CONSTRAINT FK_LIKE_MEMBER_SENDER FOREIGN KEY(LIKE_SENDER)
   REFERENCES TBL_MEMBER(ID)
);

/*2. 정보 추가*/
INSERT INTO TBL_MEMBER
(ID, MEMBER_ID, MEMBER_PASSWORD, MEMBER_NAME, MEMBER_ADDRESS, MEMBER_EMAIL, MEMBER_BIRTH)
VALUES(SEQ_MEMBER.NEXTVAL, 'AAAA', '1111', '상훈', '서울', '123@3123', '2000-11-11');
INSERT INTO TBL_MEMBER
(ID, MEMBER_ID, MEMBER_PASSWORD, MEMBER_NAME, MEMBER_ADDRESS, MEMBER_EMAIL, MEMBER_BIRTH)
VALUES(SEQ_MEMBER.NEXTVAL, 'BBBB', '2222', '철수', '경기', 'AASD@3E', '2010-03-13');
INSERT INTO TBL_MEMBER
(ID, MEMBER_ID, MEMBER_PASSWORD, MEMBER_NAME, MEMBER_ADDRESS, MEMBER_EMAIL, MEMBER_BIRTH)
VALUES(SEQ_MEMBER.NEXTVAL, 'CCCC', '3333', '길동', '강원', 'AEFE@3123', '2000-12-23');
INSERT INTO TBL_MEMBER
(ID, MEMBER_ID, MEMBER_PASSWORD, MEMBER_NAME, MEMBER_ADDRESS, MEMBER_EMAIL, MEMBER_BIRTH)
VALUES(SEQ_MEMBER.NEXTVAL, 'DDDD', '4444', '강동', '대전', 'ZVFEF3@3123', '2000-07-14');
INSERT INTO TBL_MEMBER
(ID, MEMBER_ID, MEMBER_PASSWORD, MEMBER_NAME, MEMBER_ADDRESS, MEMBER_EMAIL, MEMBER_BIRTH)
VALUES(SEQ_MEMBER.NEXTVAL, 'FFFF', '5555', '굽은다리', '부산', 'ITRTSG3@3123', '2000-01-27');

INSERT INTO TBL_LIKE
(ID, LIKE_RECEIVER, LIKE_SENDER)
VALUES(SEQ_LIKE.NEXTVAL, 1, 2);
INSERT INTO TBL_LIKE
(ID, LIKE_RECEIVER, LIKE_SENDER)
VALUES(SEQ_LIKE.NEXTVAL, 3, 2);
INSERT INTO TBL_LIKE
(ID, LIKE_RECEIVER, LIKE_SENDER)
VALUES(SEQ_LIKE.NEXTVAL, 4, 2);
INSERT INTO TBL_LIKE
(ID, LIKE_RECEIVER, LIKE_SENDER)
VALUES(SEQ_LIKE.NEXTVAL, 2, 1);
INSERT INTO TBL_LIKE
(ID, LIKE_RECEIVER, LIKE_SENDER)
VALUES(SEQ_LIKE.NEXTVAL, 3, 1);
INSERT INTO TBL_LIKE
(ID, LIKE_RECEIVER, LIKE_SENDER)
VALUES(SEQ_LIKE.NEXTVAL, 4, 1);
INSERT INTO TBL_LIKE
(ID, LIKE_RECEIVER, LIKE_SENDER)
VALUES(SEQ_LIKE.NEXTVAL, 1, 3);
INSERT INTO TBL_LIKE
(ID, LIKE_RECEIVER, LIKE_SENDER)
VALUES(SEQ_LIKE.NEXTVAL, 1, 3);



/*3. 회원 별 좋아요 수 조회하기*/
SELECT M.MEMBER_NAME, COUNT(L.LIKE_SENDER) 
FROM TBL_MEMBER M JOIN TBL_LIKE L
ON M.ID = L.LIKE_RECEIVER
GROUP BY LIKE_RECEIVER, M.MEMBER_NAME;

/*4. 회원 별 좋아요 수가 3보다 작은 것만 조회하기*/
SELECT M.MEMBER_NAME, COUNT(L.LIKE_SENDER) 
FROM TBL_MEMBER M JOIN TBL_LIKE L
ON M.ID = L.LIKE_RECEIVER
GROUP BY LIKE_RECEIVER, M.MEMBER_NAME
HAVING COUNT(L.LIKE_SENDER) < 3;

/*SQL 실행순서
 * 
 * FROM > JOIN > ON > WHERE > GROUP BY > HAVING > SELECT > ORDER BY
 * 
 * */

/*ORDER BY: 정렬
 * 
 * ASC: 오름차순(생략 가능)
 * DESC: 내림차순
 * 
 * */

/*나이 순 정렬*/
SELECT 
   MEMBER_ID, MEMBER_NAME, MEMBER_ADDRESS, 
   ROUND((SYSDATE - MEMBER_BIRTH) / 365, 0) AS AGE
FROM TBL_MEMBER
ORDER BY AGE DESC;

/*서브 쿼리
 * 
 * 메인 쿼리 안에 또 다른 쿼리를 작성하는 문법.
 * FROM절: 인라인뷰
 * WHERE절: 서브쿼리
 * SELECT절: 스칼라 서브쿼리
 * 
 * */
SELECT MEMBER_EMAIL FROM
(
   SELECT * FROM TBL_MEMBER
   WHERE MEMBER_ADDRESS = '서울'
);

/*좋아요가 가장 많은 회원 정보 조회*/
SELECT * FROM TBL_MEMBER
WHERE ID = 
(
   SELECT LIKE_RECEIVER
   FROM
   (
      SELECT LIKE_RECEIVER, COUNT(LIKE_SENDER) AS S
      FROM TBL_LIKE
      GROUP BY LIKE_RECEIVER
   )WHERE S = 
   (
      SELECT MAX(COUNT(LIKE_SENDER)) 
      FROM TBL_LIKE
      GROUP BY LIKE_RECEIVER
   )
);


SELECT M1.ID, M1.MEMBER_NAME 
FROM TBL_MEMBER M1 JOIN 
(
   SELECT LIKE_RECEIVER
   FROM
   (
      SELECT LIKE_RECEIVER, COUNT(LIKE_SENDER) AS S
      FROM TBL_LIKE
      GROUP BY LIKE_RECEIVER
   )WHERE S = 
   (
      SELECT MAX(COUNT(LIKE_SENDER)) 
      FROM TBL_LIKE
      GROUP BY LIKE_RECEIVER
   )
) M2
ON M1.ID = M2.LIKE_RECEIVER;

/*지역별 평균 나이와 전체 평균 나이 조회하기*/
SELECT 
	MEMBER_ADDRESS, 
	AVG(ROUND((SYSDATE - MEMBER_BIRTH) / 365, 0)) AS AGE,
	(SELECT AVG(ROUND((SYSDATE - MEMBER_BIRTH) / 365, 0)) FROM TBL_MEMBER) AS AVERAGE
FROM TBL_MEMBER
GROUP BY MEMBER_ADDRESS;
/**********************************************************************/
CREATE TABLE TBL_ORDER(
	ID NUMBER CONSTRAINT PK_ORDER PRIMARY KEY,
	PRODUCT_NAME VARCHAR2(1000) NOT NULL,
	PRODUCT_PRICE NUMBER DEFAULT 0,
	MEMBER_AGE NUMBER
);

INSERT INTO TBL_ORDER
VALUES (1, '지우개', 1000, 20);
INSERT INTO TBL_ORDER
VALUES (2, '지우개', 3000, 30);
INSERT INTO TBL_ORDER
VALUES (3, '지우개', 4000, 40);
INSERT INTO TBL_ORDER
VALUES (4, '지우개', 1000, 40);
INSERT INTO TBL_ORDER
VALUES (5, '지우개', 5000, 20);
INSERT INTO TBL_ORDER
VALUES (6, '지우개', 2000, 20);
INSERT INTO TBL_ORDER
VALUES (7, '지우개', 5000, 30);
INSERT INTO TBL_ORDER
VALUES (8, '지우개', 9000, 30);
INSERT INTO TBL_ORDER
VALUES (9, '지우개', 2000, 50);
INSERT INTO TBL_ORDER
VALUES (10, '지우개', 1000, 10);

SELECT * FROM TBL_ORDER;

/*20대 중에서 구매 가격이 2000원을 넘는 주문 번호 조회*/
SELECT ID, PRODUCT_PRICE, MEMBER_AGE FROM
(
	SELECT * FROM TBL_ORDER
	WHERE MEMBER_AGE = 20
)
WHERE PRODUCT_PRICE > 2000;

/*A = B AND A = D
A BETWEEN B AND D*/

/*A = B OR A = D
A IN(B, D)*/

/*상품 가격이 2000원이 넘는 상품의 나이대 조회후 결과로 ID 조회*/
SELECT ID, MEMBER_AGE, PRODUCT_PRICE FROM TBL_ORDER
WHERE ID IN 
(
	SELECT ID FROM TBL_ORDER
	WHERE PRODUCT_PRICE > 2000
);
/**********************************************************************/
CREATE SEQUENCE SEQ_USER;

CREATE TABLE TBL_USER(
	ID NUMBER CONSTRAINT PK_USER PRIMARY KEY,
	USER_ID VARCHAR2(1000) UNIQUE NOT NULL,
	USER_PW VARCHAR2(1000) NOT NULL,
	USER_ADDRESS VARCHAR2(1000),
	USER_EMAIL VARCHAR2(1000) UNIQUE NOT NULL,
	USER_BIRTH DATE
);

CREATE SEQUENCE SEQ_POST;

CREATE TABLE TBL_POST(
	ID NUMBER CONSTRAINT PK_POST PRIMARY KEY,
	POST_TITLE VARCHAR2(1000) NOT NULL,
	POST_CONTENT VARCHAR2(1000) NOT NULL,
	POST_CREATED_DATE DATE DEFAULT CURRENT_TIMESTAMP,
	USER_ID NUMBER,
	CONSTRAINT FK_POST_USER FOREIGN KEY(USER_ID)
	REFERENCES TBL_USER(ID)
);

CREATE SEQUENCE SEQ_REPLY;

CREATE TABLE TBL_REPLY(
	ID NUMBER CONSTRAINT PK_REPLY PRIMARY KEY,
	REPLY_CONTENT VARCHAR2(1000) NOT NULL,
	USER_ID NUMBER,
	POST_ID NUMBER,
	CONSTRAINT FK_REPLY_USER FOREIGN KEY(USER_ID)
	REFERENCES TBL_USER(ID),
	CONSTRAINT FK_REPLY_POST FOREIGN KEY(POST_ID)
	REFERENCES TBL_POST(ID)
);


INSERT INTO TBL_USER
VALUES(SEQ_USER.NEXTVAL, 'hds1234', '1234', '서울시 강남구', 'tedhan1204@gmail.com', '2000-12-04');
INSERT INTO TBL_USER
VALUES(SEQ_USER.NEXTVAL, 'lss9999', '9999', '경기도 남양주시', 'lss1234@gmail.com', '1999-01-04');
INSERT INTO TBL_USER
VALUES(SEQ_USER.NEXTVAL, 'hgd1222', '9999', '경기도 남양주시', 'hgd1222@gmail.com', '1999-01-04');

SELECT * FROM TBL_USER;

INSERT INTO TBL_POST(ID, POST_TITLE, POST_CONTENT, USER_ID)
VALUES(SEQ_POST.NEXTVAL, '테스트 제목1', '테스트 내용1', 1);
INSERT INTO TBL_POST(ID, POST_TITLE, POST_CONTENT, USER_ID)
VALUES(SEQ_POST.NEXTVAL, '테스트 제목2', '테스트 내용2', 1);
INSERT INTO TBL_POST(ID, POST_TITLE, POST_CONTENT, USER_ID)
VALUES(SEQ_POST.NEXTVAL, '테스트 제목3', '테스트 내용3', 2);

DELETE FROM TBL_POST
WHERE ID IN(1, 2, 4, 5);

SELECT * FROM TBL_POST;

INSERT INTO TBL_REPLY
VALUES(SEQ_REPLY.NEXTVAL, '댓글 테스트1', 1, 7);
INSERT INTO TBL_REPLY
VALUES(SEQ_REPLY.NEXTVAL, '댓글 테스트2', 2, 8);
INSERT INTO TBL_REPLY
VALUES(SEQ_REPLY.NEXTVAL, '댓글 테스트1', 2, 9);
INSERT INTO TBL_REPLY
VALUES(SEQ_REPLY.NEXTVAL, '댓글 테스트1', 1, 9);
INSERT INTO TBL_REPLY
VALUES(SEQ_REPLY.NEXTVAL, '댓글 테스트1', 3, 9);

SELECT * FROM TBL_REPLY;

/*댓글 작성자 중 게시글을 등록한 회원 조회*/
SELECT U.*
FROM TBL_USER U JOIN
(
	SELECT USER_ID FROM TBL_POST
	GROUP BY USER_ID
) P
ON U.ID = P.USER_ID
AND P.USER_ID IN
(
	SELECT USER_ID FROM TBL_REPLY
	GROUP BY USER_ID
);


























