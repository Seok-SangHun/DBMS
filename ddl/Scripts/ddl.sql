/*항상 범위 주석을 사용한다.*/
/*
CREATE TABLE TBL_MEMBER(
   ID NUMBER CONSTRAINT PK_MEMBER PRIMARY KEY,
   MEMBER_ID VARCHAR2(255) CONSTRAINT UK_MEMBER UNIQUE,
   MEMBER_PASSWORD VARCHAR2(255),
   MEMBER_AGE NUMBER(3) CONSTRAINT CHECK_AGE CHECK(MEMBER_AGE > 0)
);

CREATE TABLE TBL_ORDER(
   ID NUMBER CONSTRAINT PK_ORDER PRIMARY KEY,
   MEMBER_ID NUMBER,
   ORDER_DATE DATE DEFAULT CURRENT_TIMESTAMP,
   ORDER_COUNT NUMBER DEFAULT 1,
   CONSTRAINT FK_ORDER_MEMBER FOREIGN KEY(MEMBER_ID)
   REFERENCES TBL_MEMBER(ID)
);
*/
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
   ANIMAL_HEIGHT NUMBER(3, 5),
   ANIMAL_WEIGHT NUMBER(3, 5),
   ZOO_ID NUMBER,
   CONSTRAINT FK_ANIMAL_ZOO FOREIGN KEY(ZOO_ID)
   REFERENCES TBL_ZOO(ID)
);

/*
   논리적 설계
   회원          주문              상품
   ----------------------------------------
   번호PK      	번호PK            번호PK
   ----------------------------------------
   아이디U, NN   	날짜NN          	 이름NN
   비밀번호NN    	회원번호FK, NN      가격D=0
   이름NN      	상품번호FK, NN      재고D=0
   주소NN
   이메일
   생일
*/

/*
 * <물리적 설계>
 * user
 * -----
 * ID: NUMBER : PK
 * USER_ID : VARCHAR2(1000) : UNIQUE
 * USER_PASSWORD: VARCHAR2(1000) : NN
 * USER_NAME : VARCHAR2(1000) : NN
 * USER_ADDRESS : VARCHAR2(1000) : NN
 * USER_EMAIL : VARCHAR2(1000) : NN
 * USER_BIRTHDAY : DATE
 * 
 * order
 * ID: NUMBER : PK 
 * ORDER_DATE : DATE
 * USER_ID: NUMBER : FK : NN
 * PRODUCT_ID : NUMBER : FK : NN
 * 
 * product
 * ID: NUMBER : PK
 * PRODUCT_NAME : VARCHAR(2000) : NN
 * PRODUCT_PRICE : NUMBER : DEFAULT 0
 * PRODUCT_INVENTORY : NUMBER : DEFAULT 0
 * 
 * */

 
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

/***************************************************************************************************************************/
/***************************************************************************************************************************/
/***************************************************************************************************************************/
/*숙제*/
/*1. 요구사항 분석
    꽃 테이블과 화분 테이블 2개가 필요하고,
    꽃을 구매할 때 화분도 같이 구매합니다.
    꽃은 이름과 색상, 가격이 있고,
    화분은 제품번호, 색상, 모양이 있습니다.
    화분은 모든 꽃을 담을 수 없고 정해진 꽃을 담아야 합니다.

	2. 개념 모델링

		꽃		화분
	    -----------
		이름		제품번호	
		색상		색상
		가격		모양
		제품번호	
	
	3. 논리 모델링
		꽃		화분
		--------------------
		아이디P		제품번호P
		---------------------
		이름 NN		색상 NN
		색상 NN		모양 NN
		가격D0
		제품번호F

	4. 물리 모델링
		FLOWER
		-----------------
		ID : NUMBER :PK
		FLOWER_NAME : VARCHAR2(1000) : NN
		FLOWER_COLOR: VARCHAR2(1000) : NN
		FLOWER_PRICE : NUMBER : D0
		POT_ID: NUMBER : FK : NN

		POT
		ID: NUMBER : PK
		POT_COLOR : VARCHAR2(1000) : NN
		POT_SHAPE : VARCHAR2(1000) : NN

5. 구현*/

/*구현된 테이블 구조 해석
 * 
 * 하나의 꽃은 여러 화분에 담길 수 있으나,
 * 하나의 화분에는 하나의 꽃만 담을 수 있는
 * 전형적인 1:N 구조이다.
 * 
 * */

CREATE TABLE TBL_FLOWER(
	ID NUMBER CONSTRAINT PK_FLOWER PRIMARY KEY,
	FLOWER_NAME VARCHAR2(1000) NOT NULL,
	FLOWER_COLOR VARCHAR2(1000) NOT NULL,
	FLOWER_PRICE NUMBER DEFAULT 0,
);

CREATE TABLE TBL_POT(
	ID NUMBER CONSTRAINT PK_POT PRIMARY KEY,
	POT_COLOR VARCHAR2(1000) NOT NULL,
	POT_SHAPE VARCHAR2(1000) NOT NULL,
	FLOWER_ID NUMBER NOT NULL,
	CONSTRAINT FK_POT_FLOWER FOREIGN KEY(FLOWER_ID)
	REFERENCES TBL_FLOWER(ID)
);
/*복합키(조합키)
 * 
 * PK를 설정할 때 컬럼을 2개 이상 설정하는 문법.
 * 여러 개의 컬럼 조합으로 중복이 없는 경우 하나의 PK처럼 사용할 수 있게 된다.
 * 
 * */

/*구현된 테이블 구조 해석
 * 
 * 하나의 꽃은 여러 화분에 담길 수 있으나,
 * 하나의 화분에는 하나의 꽃만 담을 수 있는
 * 전형적인 1:N 구조이다.
 * 
 * */
DROP TABLE TBL_FLOWER_POT;
DROP TABLE TBL_FLOWER;

CREATE TABLE TBL_FLOWER(
   NAME VARCHAR2(255) NOT NULL,
   COLOR VARCHAR2(255) NOT NULL,
   PRICE NUMBER DEFAULT 0,
   CONSTRAINT PK_FLOWER PRIMARY KEY(NAME, COLOR)
);

CREATE TABLE TBL_FLOWER_POT(
   ID NUMBER CONSTRAINT PK_FLOWER_POT PRIMARY KEY,
   COLOR VARCHAR2(255) NOT NULL,
   SHAPE VARCHAR2(255) NOT NULL,
   FLOWER_NAME VARCHAR2(255) NOT NULL,
   FLOWER_COLOR VARCHAR2(255) NOT NULL,
   CONSTRAINT FK_POT_FLOWER FOREIGN KEY(FLOWER_NAME, FLOWER_COLOR)
   REFERENCES TBL_FLOWER(NAME, COLOR)
);

/*슈퍼키, 서브키
 * 
 * FK를 PK로 설정한다.
 * 
 * */

/*구현된 테이블 구조 해석
 * 
 * 하나의 꽃은 하나의 화분에 담길 수 있고,
 * 하나의 화분에는 하나의 꽃만 담을 수 있는
 * 전형적인 1:1 구조이다.
 * 
 * */
CREATE TABLE TBL_FLOWER(
   ID NUMBER CONSTRAINT PK_FLOWER PRIMARY KEY,
   NAME VARCHAR2(255) NOT NULL CONSTRAINT UK_FLOWER UNIQUE,
   COLOR VARCHAR2(255) NOT NULL,
   PRICE NUMBER DEFAULT 0
);

CREATE TABLE TBL_FLOWER_POT(
   ID NUMBER CONSTRAINT PK_FLOWER_POT PRIMARY KEY,
   COLOR VARCHAR2(255) NOT NULL,
   SHAPE VARCHAR2(255) NOT NULL,
   CONSTRAINT FK_POT_FLOWER FOREIGN KEY(ID)
   REFERENCES TBL_FLOWER(ID)
);
/***************************************************************************************************************************/
/***************************************************************************************************************************/
/***************************************************************************************************************************/
/*
1. 요구사항 분석
    안녕하세요, 동물병원을 곧 개원합니다.
    동물은 보호자랑 항상 같이 옵니다. 가끔 보호소에서 오는 동물도 있습니다.
    보호자가 여러 마리의 동물을 데리고 올 수 있습니다.
    보호자는 이름, 나이, 전화번호, 주소가 필요하고
    동물은 병명, 이름, 나이, 몸무게가 필요합니다.

2. 개념 모델링
	보호자 	동물		보호소	
	--------------------
	아이디	아이디	아이디
	이름		병명		이름
	나이		이름		주소
	전화번호	나이		전화번호
	주소		몸무게
			보호자 ID
			보호소 ID
	
3. 논리 모델링
	보호자 		동물			보호소
	-------------------------------
	아이디 PK		아이디 PK		아이디 PK
	이름 NN		병명 NN		이름 	NN
	나이 NN		이름 NN		주소 NN
	전화번호 NN	나이 NN		전화번호 NN
	주소 NN		몸무게 NN
				보호자 ID FK
				보호소 ID FK
	
4. 물리 모델링
	TBL_OWNER
	ID : NUMBER : PK
	OWNER_NAME : VARCHAR2(1000) : NN
	OWNER_AGE : NUMBER : NN
	OWNER_PHONE : VARCHAR2(15) : NN
	OWNER_ADDRESS : VARCHAR2(2000) : NN
	
	TBL_ANIMAL
	ID : NUMBER : PK
	ANIMAL_DISEASE : VARCHAR2(2000) : NN
	ANIMAL_NAME : VARCHAR2(1000) : NN
	ANIMAL_AGE : NUMBER : NN
	ANIMAL_WEIGHT : NUMBER : NN
	OWNER_ID : NUMBER : FK : NN
	SHELTER_ID : NUMBER : FK : NN
	
	TBL_SHELTER
	ID : NUMBER : PK
	SHELTER_NAME : VARCHAR2(1000) : NN
	SHELTER_ADDRESS : VARCHAR2(2000) : NN
	SHELTER_PHONE : VARCHAR2(15) : NN
	
5. 구현
*/
CREATE TABLE TBL_OWNER(
    ID NUMBER CONSTRAINT PK_OWNER PRIMARY KEY,
    OWNER_NAME VARCHAR2(1000) NOT NULL,
    OWNER_AGE NUMBER NOT NULL,
    OWNER_PHONE VARCHAR2(15) NOT NULL,
    OWNER_ADDRESS VARCHAR2(2000) NOT NULL
);

CREATE TABLE TBL_SHELTER(
    ID NUMBER CONSTRAINT PK_SHELTER PRIMARY KEY,
    SHELTER_NAME VARCHAR2(1000) NOT NULL,
    SHELTER_ADDRESS VARCHAR2(2000) NOT NULL,
    SHELTER_PHONE VARCHAR2(15) NOT NULL
);

CREATE TABLE TBL_ANIMALS(
    ID NUMBER CONSTRAINT PK_ANIMALS PRIMARY KEY,
    ANIMAL_DISEASE VARCHAR2(2000), /*보호소에서 올 수도 있어서 NN 사용 안함*/
    ANIMAL_NAME VARCHAR2(1000) NOT NULL,
    ANIMAL_AGE NUMBER NOT NULL,
    ANIMAL_WEIGHT NUMBER NOT NULL,
    OWNER_ID NUMBER,
    SHELTER_ID NUMBER,
    CONSTRAINT FK_ANIMALS_OWNER FOREIGN KEY(OWNER_ID)
    REFERENCES TBL_OWNER(ID),
    CONSTRAINT FK_ANIMALS_SHELTER FOREIGN KEY(SHELTER_ID)
    REFERENCES TBL_SHELTER(ID)
);
/***************************************************************************************************************************/
/***************************************************************************************************************************/
/***************************************************************************************************************************/
/*
1. 요구 사항
    커뮤니티 게시판을 만들고 싶어요.
    게시판에는 게시글 제목과 게시글 내용, 작성한 시간, 작성자가 있고,
    게시글에는 댓글이 있어서 댓글 내용들이 나와야 해요.
    작성자는 회원(TBL_MEMBER)정보를 그대로 사용해요.
    댓글에도 작성자가 필요해요.

2. 개념 모델링
	게시판 		게시글		회원
	----------------------------
	제목			댓글			아이디
	내용			작성자		비밀번호
	작성한 시간		회원			이름
	회원						주소
							이메일
							생일
	
3. 논리 모델링
	게시판 		게시글		회원
	----------------------------
	아이디PK		아이디PK 		아이디PK
	----------------------------
	제목NN		댓글NN		아이디 U, NN
	내용NN		작성자FK		비밀번호 NN
	작성한 시간		회원FK		이름 NN
	회원 FK					주소 NN
							이메일 
							생일 
4. 물리 모델링

	TBL_POST
	ID : NUMBER : PK
	POST_TITLE : VARCHAR2(255) : NN
	POST_CONTENT : VARCHAR2(255) : NN
	CREATED_DATE : DATE : DEFAULT
	MEMBER_ID : NUMBER :FK

	TBL_REPLY
	ID : NUMBER : PK
	REPLY_CONTENT : VARCHAR2(255) NN
   	POST_ID : NUMBER : NN :FK
   	MEMBER_ID : NUMBER : NN :FK
	
	TBL_MEMBER
	ID : NUMBER : PK
	MEMBER_ID : VARCHAR2(255) : NN 
	MEMBER_PASSWORD : VARCHAR2(255) : NN
	MEMBER_NAME : VARCHAR2(255) : NN
	MEMBER_ADDRESS : VARCHAR2(255) : NN
	MEMBER_EMAIL : VARCHAR2(255)
	MEMBER_BIRTH : DATE
	
5. 구현
*/
CREATE TABLE TBL_MEMBER(
   ID NUMBER CONSTRAINT PK_MEMBER PRIMARY KEY,
   MEMBER_ID VARCHAR2(255) CONSTRAINT UK_MEMBER UNIQUE NOT NULL,
   MEMBER_PASSWORD VARCHAR2(255) NOT NULL,
   MEMBER_NAME VARCHAR2(255) NOT NULL,
   MEMBER_ADDRESS VARCHAR2(255) NOT NULL,
   MEMBER_EMAIL VARCHAR2(255),
   MEMBER_BIRTH DATE
);

CREATE TABLE TBL_POST(
   ID NUMBER CONSTRAINT PK_POST PRIMARY KEY,
   POST_TITLE VARCHAR2(255) NOT NULL,
   POST_CONTENT VARCHAR2(255) NOT NULL,
   CREATED_DATE DATE DEFAULT CURRENT_TIMESTAMP,
   MEMBER_ID NUMBER,
   CONSTRAINTS FK_POST_MEMBER FOREIGN KEY(MEMBER_ID)
   REFERENCES TBL_MEMBER(ID)
);

ALTER TABLE TBL_POST MODIFY(MEMBER_ID NULL);
ALTER TABLE TBL_POST MODIFY(MEMBER_ID NOT NULL);

CREATE TABLE TBL_REPLY(
   ID NUMBER CONSTRAINT PK_REPLY PRIMARY KEY,
   REPLY_CONTENT VARCHAR2(255) NOT NULL,
   POST_ID NUMBER NOT NULL,
   MEMBER_ID NUMBER NOT NULL,
   CONSTRAINTS FK_REPLY_POST FOREIGN KEY(POST_ID)
   REFERENCES TBL_POST(ID),
   CONSTRAINTS FK_REPLY_MEMBER FOREIGN KEY(MEMBER_ID)
   REFERENCES TBL_MEMBER(ID)
);
/***************************************************************************************************************************/
/***************************************************************************************************************************/
/***************************************************************************************************************************/
/*
 1. 요구 사항
    마이페이지에서 회원 프로필을 구현하고 싶습니다.
    회원당 프로필을 여러 개 설정할 수 있고,
    대표 이미지로 선택된 프로필만 화면에 보여주고 싶습니다.

2. 개념 모델링
	회원				프로필
	-----------------------
	회원ID			경로
	비밀번호			크기
	이름				대표사진	
	주소				회원ID	
	이메일
	생일
	
3. 논리 모델링
	회원				프로필
	----------------------------
	아이디PK			아이디PK
	-------------------------
	아이디 U, NN		경로 NN
	비밀번호 NN		크기	NN, D0
	이름 NN			대표사진 STATUS, D0
	주소 NN			회원 ID : FK
	이메일 
	생일 	
					
	
4. 물리 모델링
	TBL_MEMBER
	ID : NUMBER : PK
	MEMBER_ID : VARCHAR2(255) : NN 
	MEMBER_PASSWORD : VARCHAR2(255) : NN
	MEMBER_NAME : VARCHAR2(255) : NN
	MEMBER_ADDRESS : VARCHAR2(255) : NN
	MEMBER_EMAIL : VARCHAR2(255)
	MEMBER_BIRTH : DATE
	
	TBL_PROFILE
	ID : NUMBER : PK
   	PROFILE_PATH : VARCHAR2(255) : NN
   	PROFILE_SIZE : NUMBER : D0
   	STATUS : NUMBER : D0
   	MEMBER_ID : NUMBER : NN
	
	
5. 구현
*/
CREATE TABLE TBL_MEMBER(
   ID NUMBER CONSTRAINT PK_MEMBER PRIMARY KEY,
   MEMBER_ID VARCHAR2(255) CONSTRAINT UK_MEMBER UNIQUE NOT NULL,
   MEMBER_PASSWORD VARCHAR2(255) NOT NULL,
   MEMBER_NAME VARCHAR2(255) NOT NULL,
   MEMBER_ADDRESS VARCHAR2(255) NOT NULL,
   MEMBER_EMAIL VARCHAR2(255),
   MEMBER_BIRTH DATE
);

CREATE TABLE TBL_PROFILE(
   ID NUMBER CONSTRAINT PK_PROFILE PRIMARY KEY,
   PROFILE_PATH VARCHAR2(255) NOT NULL,
   PROFILE_SIZE NUMBER DEFAULT 0,
   STATUS NUMBER DEFAULT 0,
   MEMBER_ID NUMBER NOT NULL,
   CONSTRAINT FK_PROFILE_MEMBER FOREIGN KEY(MEMBER_ID)
   REFERENCES TBL_MEMBER(ID)
);
/***************************************************************************************************************************/
/***************************************************************************************************************************/
/***************************************************************************************************************************/

/*
1. 요구 사항
    회원들끼리 좋아요를 누를 수 있습니다.

2. 개념 모델링
	회원				좋아요
	-----------------------
	회원ID			회원(누가)ID
	비밀번호			회원(누구를)ID
	이름					
	주소					
	이메일
	생일
	
3. 논리 모델링
	회원				좋아요
	----------------------------
	아이디PK			아이디PK
	-------------------------
	아이디 U, NN		회원(누가) ID : FK
	비밀번호 NN		회원(누구를) ID : FK
	이름 NN			
	주소 NN			
	이메일 
	생일 	
					
	
4. 물리 모델링
	TBL_MEMBER
	ID : NUMBER : PK
	MEMBER_ID : VARCHAR2(255) : NN 
	MEMBER_PASSWORD : VARCHAR2(255) : NN
	MEMBER_NAME : VARCHAR2(255) : NN
	MEMBER_ADDRESS : VARCHAR2(255) : NN
	MEMBER_EMAIL : VARCHAR2(255)
	MEMBER_BIRTH : DATE
	
	TBL_LIKE
	ID : NUMBER : PK
	PUSH_ID : VARCHAR2(255) : NN
	PULL_ID : VARCHAR2(255) : NN
	
5. 구현
*/
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
	PUSH_ID NUMBER,
	PULL_ID NUMBER,
	CONSTRAINT FK_LIKE_PUSH_ID FOREIGN KEY(PUSH_ID)
	REFERENCES TBL_MEMBER(ID),
	CONSTRAINT FK_LIKE_PULL_ID FOREIGN KEY(PULL_ID)
	REFERENCES TBL_MEMBER(ID)
);
/***************************************************************************************************************************/
/***************************************************************************************************************************/
/***************************************************************************************************************************/

/*
    1. 요구사항 분석
        안녕하세요 중고차 딜러입니다.
        이번에 자동차와 차주를 관리하고자 방문했습니다.
        자동차는 여러 명의 차주로 히스토리에 남아야 하고,
        차주는 여러 대의 자동차를 소유할 수 있습니다.
        그래서 우리는 항상 등록증(Registration)을 작성합니다.
        자동차는 브랜드, 모델명, 가격, 출시날짜가 필요하고
        차주는 이름, 전화번호, 주소가 필요합니다.

    2. 개념 모델링
    	자동차 			차주			등록증
    	------------------------------------			
    	브랜드			이름			차주ID
    	모델명			전화번호		자동차ID
    	가격				주소
    	출시날짜
    	차주 ID
    	
    3. 논리 모델링
    	자동차 			차주			등록증
    	------------------------------------
    	ID: PK			ID: PK		ID: PK
    	브랜드NN			이름NN		차주ID: FK
    	모델명NN			전화번호NN		자동차ID: FK
    	가격NN D0			주소NN
    	출시날짜 	
    
    4. 물리 모델링
    	TBL_CAR
    	ID: NUMBER: PK
    	CAR_BRAND: VARCHAR2(255) : NN
    	CAR_NAME: VARCHAR2(255): NN
    	CAR_PRICE: NUMBER : D0
    	CAR_DATE: DATE: DEFAULT
    	    	
    	TBL_OWNER
    	ID: NUMBER: PK
    	OWNER_NAME: VARCHAR2(255): NN
    	OWNER_PHONE: VARCHAR2(255): NN
    	OWNER_ADDRESS: VARCHAR2(255): NN
    	
    	TBL_REGISTRATION
    	ID: NUMBER: PK
    	OWNER_ID: FK
    	CAR_ID: FK
    	
    5. 구현
*/


CREATE TABLE TBL_CAR(
	ID NUMBER CONSTRAINT PK_CAR PRIMARY KEY,
	CAR_BRAND VARCHAR2(255) NOT NULL,
	CAR_NAME VARCHAR2(255) NOT NULL,
	CAR_PRICE NUMBER DEFAULT 0,
	CAR_DATE DATE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE TBL_OWNER(
	ID NUMBER CONSTRAINT PK_OWNER PRIMARY KEY,
	OWNER_NAME VARCHAR2(255) NOT NULL,
	OWNER_PHONE VARCHAR2(255) NOT NULL,
	OWNER_ADDRESS VARCHAR2(255) NOT NULL
);

CREATE TABLE TBL_REGISTRATION(
	ID NUMBER CONSTRAINT PK_REGISTRATION PRIMARY KEY,
	OWNER_ID NUMBER,
	CAR_ID NUMBER,
	CONSTRAINT FK_REGISTRATION_OWNER_ID FOREIGN KEY(OWNER_ID)
	REFERENCES TBL_OWNER(ID),
	CONSTRAINT FK_REGISTRATION_CAR_ID FOREIGN KEY(CAR_ID)
	REFERENCES TBL_CAR(ID)
);

/***************************************************************************************************************************/
/***************************************************************************************************************************/
/***************************************************************************************************************************/
/*
1. 요구사항

    학사 관리 시스템에 학생과 교수, 과목을 관리합니다.
    학생은 학번, 이름, 전공, 학년이 필요하고
    교수는 교수 번호, 이름, 전공, 직위가 필요합니다.
    과목은 고유한 과목 번호와 과목명, 학점이 필요합니다.
    
    학생은 여러 과목을 수강할 수 있으며,
    교수는 여러 과목을 강의할 수 있습니다.
    학생이 수강한 과목은 성적(점수)이 모두 기록됩니다.
    
2. 개념 모델링
	학생 			교수			과목			학생 성적			교수 강의
	--------------------------------------------------------------
	학번			교수번호		과목번호		학생ID			교수ID
	이름			이름			과목명		과목ID			과목ID
	전공			전공			학점
	학년			직위			
	
3. 논리 모델링
	학생 			교수			과목			학생 성적			교수 강의
	---------------------------------------------------------------
	ID: PK		ID:PK 		ID: PK		ID: PK			ID: PK
	---------------------------------------------------------------
	학번NN		교수번호NN		과목번호 NN	학생ID, FK		교수ID, FK
	이름NN		이름NN		과목명 NN		과목ID, FK		과목ID, FK
	전공NN,U		전공NN,U		성적 NN
	학년NN		직위NN		
	
4. 물리 모델링
	TBL_STUDENT
	ID: PK
	STUDENT_NUMBER : VARCHAR2(255) : NN
	STUDENT_NAME : VARCHAR2(255) : NN
	STUDENT_MAJOR : VARCHAR2(255) : NN, U
	STUDENT_GRADE : NUMBER(1) : NN
	
	TBL_PRO
	ID: PK
	PRO_NUMBER: NUMBER(5) : NN
	PRO_NAME: VARCHAR2(255) : NN
	PRO_MAJOR: VARCHAR2(255) : NN, U
	PRO_SPOT: VARCHAR2(255) : NN
	
	TBL_SUBJECT
	ID: PK
	SUBJECT_NUMBER: NUMBER(5): NN
	SUBJECT_NAME: VARCHAR2(255): NN
	SUBECT_GRADES: NUMBER(3): NN
	
	TBL_STUDENT_SUBJECT
	ID : NUMBER : PK
	STUDENT_ID:  NUMBER, FK
	SUBJECT_ID:  NUMBER, FK
	

	TBL_LECTURE
	ID: NUMBER : PK
	PRO_ID : NUMBER, FK
	SUBJECT_ID : NUMBER, FK
	
	
5. 구현
*/

CREATE TABLE TBL_STUDENT(
	ID NUMBER CONSTRAINT PK_STUDENT PRIMARY KEY,
	STUDENT_NAME VARCHAR2(255) NOT NULL,
	STUDENT_MAJOR VARCHAR2(255) NOT NULL CONSTRAINT UK_STUDENT UNIQUE,
	STUDENT_GRADE NUMBER(1) NOT NULL	
);

CREATE TABLE TBL_PRO(
	ID NUMBER CONSTRAINT PK_PRO PRIMARY KEY,
	PRO_NAME VARCHAR2(255) NOT NULL,
	PRO_MAJOR VARCHAR2(255) NOT NULL CONSTRAINT UK_PRO UNIQUE,
	PRO_SPOT VARCHAR2(255) NOT NULL
);

CREATE TABLE TBL_SUBJECT(
	ID NUMBER CONSTRAINT PK_SUBJECT PRIMARY KEY,
	SUBJECT_NAME VARCHAR2(255) NOT NULL,
	SUBECT_GRADES NUMBER(3) NOT NULL 
);

CREATE TABLE TBL_STUDENT_SUBJECT(
	ID NUMBER CONSTRAINT PK_GRADES PRIMARY KEY,
	STUDENT_ID NUMBER,
	SUBJECT_ID NUMBER,
	CONSTRAINT FK_GRADES_STUDENT FOREIGN KEY(STUDENT_ID)
	REFERENCES TBL_STUDENT(ID),
	CONSTRAINT FK_GRADES_SUBJECT FOREIGN KEY(SUBJECT_ID)
	REFERENCES TBL_SUBJECT(ID)
);

CREATE TABLE TBL_LECTURE(
	ID NUMBER CONSTRAINT PK_LECTURE PRIMARY KEY,
	PRO_ID NUMBER,
	SUBJECT_ID NUMBER,
	CONSTRAINT FK_LECTURE_PRO FOREIGN KEY(PRO_ID)
	REFERENCES TBL_PRO(ID),
	CONSTRAINT FK_LECTURE_SUBJECT FOREIGN KEY(SUBJECT_ID)
	REFERENCES TBL_SUBJECT(ID)
);

/***************************************************************************************************************************/
/***************************************************************************************************************************/
/***************************************************************************************************************************/

/*
1. 요구사항
    대카테고리, 소카테고리가 필요해요.
    
2. 개념 모델링

3. 논리 모델링
	
4. 물리 모델링
	
5. 구현
*/
CREATE TABLE TBL_BIG(
	ID NUMBER CONSTRAINT PK_BIG PRIMARY KEY,
	BIG_NAME VARCHAR2(255) NOT NULL
);

CREATE TABLE TBL_SMALL(
	ID NUMBER CONSTRAINT PK_SMALL PRIMARY KEY,
	SMALL_NAME VARCHAR2(255) NOT NULL,
	BIG_ID NUMBER,
	CONSTRAINT FK_SMALL_BIG FOREIGN KEY(BIG_ID)
	REFERENCES BIG(ID)
);

/***************************************************************************************************************************/
/***************************************************************************************************************************/
/***************************************************************************************************************************/
/*
1. 요구 사항
 
	회의실 예약 서비스를 제작하고 싶습니다.
 	회원별로 등급이 존재하고 사무실마다 회의실이 여러 개 있습니다.
 	회의실 이용 가능 시간은 파트 타임으로서 여러 시간대가 존재합니다.

2. 개념 모델링
	회원			사무실			회의실				시간				예약
	---------------------------------------------------------------------
	이름			이름				이름					이름(파트타임)		회원ID
	나이			회원ID			사무실ID				회의실 ID			회의실ID
	등급																시간ID
	
3. 논리 모델링
	회원			사무실			회의실				시간				예약
	----------------------------------------------------------------------
	ID:PK		ID:PK			ID:PK				ID:PK			ID:PK
	----------------------------------------------------------------------
	이름NN		이름				이름NN				이름(파트타임)NN	회원ID:FK
	나이NN		회원ID:FK			사무실ID:FK			회의실ID:FK		회의실ID:FK
	등급NN															시간ID:FK
	
4. 물리 모델링
	TBL_USER
	ID:PK
	USER_NAME : VARCHAR2(255) : NN
	USER_AGE : NUMBER : NN
	USER_GRADE : VARCHAR2(255) : NN
	
	TBL_OFFICE
	ID:PK
	OFFICE_NAME : VARCHAR2(255) : NN
	USER_ID: FK
		
	TBL_ROOM
	ID:PK
	ROOM_NAME : VARCHAR2(255) : NN
	OFFICE_ID : FK
	
	TBL_ROOM_TIME
	ID:PK
	TIME_NAME : VARCHAR2(255) : NN
	ROOM_ID : FK
	
	TBL_RESERVATION
	ID: PK
	USER_ID : FK
	ROOM_ID : FK
	TIME_ID : FK
	
5. 구현

 * */

CREATE TABLE TBL_USER(
	ID NUMBER CONSTRAINT PK_USER PRIMARY KEY,
	USER_NAME VARCHAR2(255) NOT NULL,
	USER_AGE NUMBER NOT NULL,
	USER_GRADE VARCHAR2(255) NOT NULL
);

CREATE TABLE TBL_OFFICE(
	ID NUMBER CONSTRAINT PK_OFFICE PRIMARY KEY,
	OFFICE_NAME VARCHAR2(255) NOT NULL
);

CREATE TABLE TBL_ROOM(
	ID NUMBER CONSTRAINT PK_ROOM PRIMARY KEY,
	ROOM_NAME VARCHAR2(255) NOT NULL,
	OFFICE_ID NUMBER,
	CONSTRAINT FK_ROOM_OFFICE FOREIGN KEY(OFFICE_ID)
	REFERENCES TBL_OFFICE(ID)
);

CREATE TABLE TBL_TIME(
	ID NUMBER CONSTRAINT PK_TIME PRIMARY KEY,
	TIME_NAME VARCHAR2(255) NOT NULL
	ROOM_ID NUMBER,
	CONSTRAINT FK_TIME_ROOM FOREIGN KEY(ROOM_ID)
	REFERENCES TBL_ROOM(ID)
);

CREATE TABLE TBL_RESERVATION (
    ID NUMBER CONSTRAINT PK_RESERVATION PRIMARY KEY,
    USER_ID NUMBER,
    TIME_ID NUMBER,
    RESERVATION_DATE DATE NOT NULL,
    CONSTRAINT FK_RESERVATION_USER FOREIGN KEY (USER_ID)
    REFERENCES TBL_USER (ID),
    CONSTRAINT FK_RESERVATION_TIME FOREIGN KEY (TIME_ID)
    REFERENCES TBL_TIME (ID)
);

/*숙제*/

/*
1. 요구사항 분석

	도서관에서 책을 대출해주는 시스템을 만듭니다.
	책은 여러 명의 회원에게 대출될 수 있습니다.
	회원은 여러 권의 책을 대출할 수 있습니다.
	회원은 이름, 나이, 전화번호, 주소가 필요하고
	책은 제목, 저자, 출판사, 출판일, 가격이 필요합니다.
	
2. 개념 모델링
	회원				책 				대출
	-------------------------------------
	이름				제목				회원ID
	나이				저자				책ID
	전화번호			출판사			대출일
	주소				출판일			반납일
					가격
					
3. 논리 모델링
	회원				책 				대출
	-------------------------------------
	ID:PK			ID:PK			ID:PK
	-------------------------------------
	이름NN			제목NN			회원ID, FK,NN
	나이NN			저자NN			책ID, FK, NN
	전화번호NN			출판사NN			대출일NN
	주소NN			출판일NN			반납일NN
					가격NN

4. 물리 모델링
	TBL_MEMBER
	ID : NUMBER : PK
	MEMBER_NAME : VARCHAR2(1000) : NN
	MEMBER_AGE : NUMBER : NN
	MEMBER_PHONE : VARCHAR2(15) : NN
	MEMBER_ADDRESS : VARCHAR2(2000) : NN
	
	TBL_BOOK
	ID : NUMBER : PK
	BOOK_TITLE : VARCHAR2(1000) : NN
	BOOK_AUTHOR : VARCHAR2(1000) : NN
	BOOK_PUBLISHER : VARCHAR2(1000) : NN
	BOOK_PUBDATE : DATE : NN
	BOOK_PRICE : NUMBER : NN
	
	TBL_LOAN
	MEMBER_ID : NUMBER : FK : NN
	BOOK_ID : NUMBER : FK : NN
	LOAN_DATE : DATE : NN
	RETURN_DATE : DATE : NN

5. 구현
*/
CREATE TABLE TBL_MEMBER(
    ID NUMBER CONSTRAINT PK_MEMBER PRIMARY KEY,
    MEMBER_NAME VARCHAR2(1000) NOT NULL,
    MEMBER_AGE NUMBER NOT NULL,
    MEMBER_PHONE VARCHAR2(15) NOT NULL,
    MEMBER_ADDRESS VARCHAR2(2000) NOT NULL
);

CREATE TABLE TBL_BOOK(
    ID NUMBER CONSTRAINT PK_BOOK PRIMARY KEY,
    BOOK_TITLE VARCHAR2(1000) NOT NULL,
    BOOK_AUTHOR VARCHAR2(1000) NOT NULL,
    BOOK_PUBLISHER VARCHAR2(1000) NOT NULL,
    BOOK_PUBDATE DATE NOT NULL,
    BOOK_PRICE NUMBER NOT NULL
);

CREATE TABLE TBL_LOAN(
    MEMBER_ID NUMBER NOT NULL,
    BOOK_ID NUMBER NOT NULL,
    LOAN_DATE DATE NOT NULL,
    RETURN_DATE DATE NOT NULL,
    CONSTRAINT FK_LOAN_MEMBER FOREIGN KEY(MEMBER_ID)
    REFERENCES TBL_MEMBER(ID),
    CONSTRAINT FK_LOAN_BOOK FOREIGN KEY(BOOK_ID)
    REFERENCES TBL_BOOK(ID)
);
/***************************************************************************************************************************/
/***************************************************************************************************************************/
/***************************************************************************************************************************/
/* 
1. 요구사항 분석

    고객은 여러 번의 주문을 할 수 있습니다.
	각 주문에는 여러 개의 상품이 포함될 수 있습니다.
	고객은 이름, 이메일, 전화번호, 주소가 필요하고
	상품은 이름, 설명, 가격, 재고 수량이 필요합니다.
	주문은 주문 날짜와 배송 주소가 필요합니다.

2. 개념 모델링
	고객				상품				주문				주문상세
	------------------------------------------------------
	이름				이름				고객ID			주문ID
	이메일			설명				주문날짜			상품ID
	전화번호			가격				배송주소			수량
	주소				재고 수량
	
3. 논리 모델링
	고객				상품				주문				주문상세
	------------------------------------------------------
	ID:PK			ID:PK			ID:PK			ID:PK
	------------------------------------------------------
	이름NN			이름NN			고객ID,FK,NN		주문ID, FK, NN
	이메일NN			설명NN			주문날짜NN			상품ID, FK, NN
	전화번호NN			가격NN			배송주소NN			수량NN
	주소NN			재고 수량NN
	
4. 물리 모델링
	TBL_CUSTOMER)
	ID : NUMBER : PK
	CUSTOMER_NAME : VARCHAR2(1000) : NN
	CUSTOMER_EMAIL : VARCHAR2(1000) : NN
	CUSTOMER_PHONE : VARCHAR2(15) : NN
	CUSTOMER_ADDRESS : VARCHAR2(2000) : NN
	
	TBL_PRODUCT
	ID : NUMBER : PK
	PRODUCT_NAME : VARCHAR2(1000) : NN
	PRODUCT_DESCRIPTION : VARCHAR2(2000) : NN
	PRODUCT_PRICE : NUMBER : NN
	PRODUCT_STOCK : NUMBER : NN
	
	TBL_ORDER
	ID : NUMBER : PK
	CUSTOMER_ID : NUMBER : FK : NN
	ORDER_DATE : DATE : NN
	SHIPPING_ADDRESS : VARCHAR2(2000) : NN
	
	TBL_ORDER_DETAIL
	ORDER_ID : NUMBER : FK : NN
	PRODUCT_ID : NUMBER : FK : NN
	QUANTITY : NUMBER : NN
	
5. 구현	*/
CREATE TABLE TBL_CUSTOMER(
    ID NUMBER CONSTRAINT PK_CUSTOMER PRIMARY KEY,
    CUSTOMER_NAME VARCHAR2(1000) NOT NULL,
    CUSTOMER_EMAIL VARCHAR2(1000) NOT NULL,
    CUSTOMER_PHONE VARCHAR2(15) NOT NULL,
    CUSTOMER_ADDRESS VARCHAR2(2000) NOT NULL
);

CREATE TABLE TBL_PRODUCT(
    ID NUMBER CONSTRAINT PK_PRODUCT PRIMARY KEY,
    PRODUCT_NAME VARCHAR2(1000) NOT NULL,
    PRODUCT_DESCRIPTION VARCHAR2(2000) NOT NULL,
    PRODUCT_PRICE NUMBER NOT NULL,
    PRODUCT_STOCK NUMBER NOT NULL
);

CREATE TABLE TBL_ORDER(
    ID NUMBER CONSTRAINT PK_ORDER PRIMARY KEY,
    CUSTOMER_ID NUMBER NOT NULL,
    ORDER_DATE DATE NOT NULL,
    SHIPPING_ADDRESS VARCHAR2(2000) NOT NULL,
    CONSTRAINT FK_ORDER_CUSTOMER FOREIGN KEY(CUSTOMER_ID)
    REFERENCES TBL_CUSTOMER(ID)
);

CREATE TABLE TBL_ORDER_DETAIL(
    ORDER_ID NUMBER NOT NULL,
    PRODUCT_ID NUMBER NOT NULL,
    QUANTITY NUMBER NOT NULL,
    CONSTRAINT FK_ORDER_DETAIL_ORDER FOREIGN KEY(ORDER_ID)
    REFERENCES TBL_ORDER(ID),
    CONSTRAINT FK_ORDER_DETAIL_PRODUCT FOREIGN KEY(PRODUCT_ID)
    REFERENCES TBL_PRODUCT(ID)
);
/***************************************************************************************************************************/
/***************************************************************************************************************************/
/***************************************************************************************************************************/


/*
1. 요구사항 분석

	고객은 호텔에서 방을 예약할 수 있습니다.
	호텔은 여러 개의 방을 가지고 있습니다.
	고객은 여러 번의 예약을 할 수 있습니다.
	고객은 이름, 이메일, 전화번호가 필요하고
	방은 번호, 타입, 가격이 필요합니다.
	예약은 예약 날짜, 체크인 날짜, 체크아웃 날짜가 필요합니다.
    
    
2. 개념 모델링
	고객			방			예약
	-----------------------------
	이름			번호			고객ID
	이메일		타입			방ID
	전화번호		가격			예약 날짜
							체크인 날짜
							체크아웃 날짜
							
3. 논리 모델링
	고객			방			예약
	-----------------------------
	ID:PK		ID:PK		ID:PK
	-----------------------------
	이름NN		번호NN		고객ID, FK, NN
	이메일NN		타입NN		방ID, FK, NN
	전화번호NN		가격NN		예약 날짜 NN
							체크인 날짜NN
							체크아웃 날짜NN
	
4. 물리 모델링
	TBL_CUSTOMER
	ID : NUMBER : PK
	CUSTOMER_NAME : VARCHAR2(1000) : NN
	CUSTOMER_EMAIL : VARCHAR2(1000) : NN
	CUSTOMER_PHONE : VARCHAR2(15) : NN 
	
	TBL_ROOM
	ID : NUMBER : PK
	ROOM_NUMBER : VARCHAR2(100) : NN
	ROOM_TYPE : VARCHAR2(1000) : NN
	ROOM_PRICE : NUMBER : NN
	
	TBL_RESERVATION
	ID : NUMBER : PK
	CUSTOMER_ID : NUMBER : FK : NN
	ROOM_ID : NUMBER : FK : NN
	RESERVATION_DATE : DATE : NN
	CHECKIN_DATE : DATE : NN
	CHECKOUT_DATE : DATE : NN
	
5. 구현     
 * */
CREATE TABLE TBL_CUSTOMER(
    ID NUMBER CONSTRAINT PK_CUSTOMER PRIMARY KEY,
    CUSTOMER_NAME VARCHAR2(1000) NOT NULL,
    CUSTOMER_EMAIL VARCHAR2(1000) NOT NULL,
    CUSTOMER_PHONE VARCHAR2(15) NOT NULL
);

CREATE TABLE TBL_ROOM(
    ID NUMBER CONSTRAINT PK_ROOM PRIMARY KEY,
    ROOM_NUMBER VARCHAR2(100) NOT NULL,
    ROOM_TYPE VARCHAR2(1000) NOT NULL,
    ROOM_PRICE NUMBER NOT NULL
);

CREATE TABLE TBL_RESERVATION(
    ID NUMBER CONSTRAINT PK_RESERVATION PRIMARY KEY,
    CUSTOMER_ID NUMBER NOT NULL,
    ROOM_ID NUMBER NOT NULL,
    RESERVATION_DATE DATE NOT NULL,
    CHECKIN_DATE DATE NOT NULL,
    CHECKOUT_DATE DATE NOT NULL,
    CONSTRAINT FK_RESERVATION_CUSTOMER FOREIGN KEY(CUSTOMER_ID)
    REFERENCES TBL_CUSTOMER(ID),
    CONSTRAINT FK_RESERVATION_ROOM FOREIGN KEY(ROOM_ID)
    REFERENCES TBL_ROOM(ID)
);

/***************************************************************************************************************************/
/***************************************************************************************************************************/
/***************************************************************************************************************************/
/*
1. 요구사항
   유치원을 하려고 하는데, 아이들이 체험학습 프로그램을 신청해야 합니다.
   아이들 정보는 이름, 나이, 성별이 필요하고 학부모는 이름, 나이, 주소, 전화번호, 성별이 필요해요
   체험학습은 체험학습 제목, 체험학습 내용, 이벤트 이미지 여러 장이 필요합니다.
   아이들은 여러 번 체험학습에 등록할 수 있어요.
    
2. 개념 모델링
	아이			부모			 체험학습			
	-----------------------------------
	이름			이름			제목
	나이			나이			내용
	성별			주소			이벤트이미지
	부모ID		전화번호		아이ID
				성별
				
	
3. 논리 모델링
	아이			부모			 체험학습			
	-----------------------------------
	ID:PK		ID:PK		ID:PK
	-----------------------------------
	이름NN		이름NN		제목NN
	나이NN		나이NN		내용NN
	성별D3		주소NN		이벤트이미지NN
	부모ID: FK	전화번호NN		아이ID: FK
				성별 D3
				
4. 물리 모델링
	TBL_PARENTS
	ID: PK
	PARENTS_NAME : VARCHAR2(255) : NN
	PARENTS_AGE : NUMBER(3) : NN
	PARENTS_ADDRESS : VARCHAR2(255) : NN
	PARENTS_PHONE : VARCHAR2(255) : NN
	PARENTS_GENDER : NUMBER : D3
	
	TBL_KID
	ID: PK
	KID_NAME : VARCHAR2(255) : NN
	KID_AGE : NUMBER(1) : NN
	KID_GENDER : NUMBER : D3
	PARENTS_ID : FK
		
	TBL_FIELD
	ID: PK
	FIELD_TITLE : VARCHAR2(255) : NN
	FIELD_CONTENTS : VARCHAR2(1000) : NN
	FIELD_IMAGE : VARCHAR2(255) : NN
	KID_ID : FK
	
5. 구현
*/
/*구현된 테이블 구조 해석
 * 
 * - 부모와 아이 관계
 * 하나의 학부모에 여러 자식을 담을 수 있으나,
 * 하나의 자식에는 하나의 부모만 담을 수 있는
 * 전형적이 1:N 구조이다.
 * 
 * - 아이와 체험학습 관계
 * 하나의 아이는 여러 체험학습을 담을 수 있고,
 * 하나의 체험학습은 여러 아이를 담을 수 있는
 * 전형적이 N:N구조이다.
 * */

CREATE TABLE TBL_PARENTS(
	ID NUMBER CONSTRAINT PK_PARENTS PRIMARY KEY,
	PARENTS_NAME VARCHAR2(255) NOT NULL,
	PARENTS_AGE NUMBER(3) NOT NULL,
	PARENTS_ADDRESS VARCHAR2(255) NOT NULL,
	PARENTS_PHONE VARCHAR2(255) NOT NULL,
	PARENTS_GENDER NUMBER DEFAULT 3
);

CREATE TABLE TBL_KID(
	ID NUMBER CONSTRAINT PK_KID PRIMARY KEY,
	KID_NAME VARCHAR2(255) NOT NULL,
	KID_AGE NUMBER(1) NOT NULL,
	KID_GENDER NUMBER DEFAULT 3,
	PARENTS_ID NUMBER,
	CONSTRAINT FK_KID_PARENTS FOREIGN KEY(PARENTS_ID)
	REFERENCES TBL_PARENTS(ID)
);

CREATE TABLE TBL_FIELD(
	ID NUMBER CONSTRAINT PK_FIELD PRIMARY KEY,
	FIELD_TITLE VARCHAR2(255) NOT NULL,
	FIELD_CONTENTS VARCHAR2(1000) NOT NULL,
	FIELD_IMAGE VARCHAR2(255) NOT NULL
);

CREATE TABLE TBL_REGISTRATION(
	ID NUMBER CONSTRAINT PK_REGISTRATION PRIMARY KEY,
	KID_ID NUMBER,
	FIELD_ID NUMBER,
	CONSTRAINT FK_REGISTRATION_KID FOREIGN KEY(KID_ID)
	REFERENCES TBL_KID(ID),
	CONSTRAINT FK_REGISTRATION_FIELD FOREIGN KEY(FIELD_ID)
	REFERENCES TBL_FIELD(ID)
);

/*
 * CREATE TABLE TBL_KINDERGARTEN(
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

CREATE TABLE TBL_CHILD(
   ID NUMBER CONSTRAINT PK_CHILD PRIMARY KEY,
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
 * 
 * */

/***************************************************************************************************************************/
/***************************************************************************************************************************/
/***************************************************************************************************************************/
/*
1. 요구사항
   안녕하세요, 광고 회사를 운영하려고 준비중인 사업가입니다.
   광고주는 기업이고 기업 정보는 이름, 주소, 대표번호, 기업종류(스타트업, 중소기업, 중견기업, 대기업)입니다.
   광고는 제목, 내용이 있고 기업은 여러 광고를 신청할 수 있습니다.
   기업이 광고를 선택할 때에는 카테고리로 선택하며, 대카테고리, 중카테고리, 소카테고리가 있습니다.

2. 개념 모델링
	광고회사			기업 				기업종류				광고
					이름				스타트업				제목
					주소				중소기업				내용
					대표번호			중견기업				대카테고리 -> 중카테고리 -> 소카테고리
									대기업
					
3. 논리 모델링
	
4. 물리 모델링
	
5. 구현
*/

CREATE TABLE TBL_COMPANY(
   ID NUMBER CONSTRAINT PK_COMPANY PRIMARY KEY,
   COMAPNY_NAME VARCHAR2(255) NOT NULL,
   COMAPNY_ADDRESS VARCHAR2(255) NOT NULL,
   COMAPNY_TEL VARCHAR2(255) NOT NULL,
   COMAPNY_TYPE NUMBER
);

CREATE TABLE TBL_CATEGORY_A(
   ID NUMBER CONSTRAINT PK_CATEGORY_A PRIMARY KEY,
   CATEGORY_A_NAME VARCHAR2(255)
);

CREATE TABLE TBL_CATEGORY_B(
   ID NUMBER CONSTRAINT PK_CATEGORY_B PRIMARY KEY,
   CATEGORY_B_NAME VARCHAR2(255),
   CATEGORY_A_ID NUMBER,
   CONSTRAINT FK_CATEGORY_B_CATEGORY_A FOREIGN KEY(CATEGORY_A_ID)
   REFERENCES TBL_CATEGORY_A(ID)
);

CREATE TABLE TBL_CATEGORY_C(
   ID NUMBER CONSTRAINT PK_CATEGORY_C PRIMARY KEY,
   CATEGORY_C_NAME VARCHAR2(255),
   CATEGORY_B_ID NUMBER,
   CONSTRAINT FK_CATEGORY_C_CATEGORY_B FOREIGN KEY(CATEGORY_B_ID)
   REFERENCES TBL_CATEGORY_B(ID)
);

CREATE TABLE TBL_ADVERTISEMENT(
   ID NUMBER CONSTRAINT PK_ADVERTISEMENT PRIMARY KEY,
   ADVERTISEMENT_TITLE VARCHAR2(255) NOT NULL,
   ADVERTISEMENT_CONTENT VARCHAR2(255) NOT NULL,
   COMPANY_ID NUMBER,
   CONSTRAINT FK_ADVERTISEMENT_COMPANY FOREIGN KEY(COMPANY_ID)
   REFERENCES TBL_COMPANY(ID)
);

ALTER TABLE TBL_ADVERTISEMENT ADD (CATEGORY_C_ID NUMBER);
ALTER TABLE TBL_ADVERTISEMENT ADD 
CONSTRAINT FK_ADVERTISEMENT_CATEGORY_C FOREIGN KEY(CATEGORY_C_ID)
REFERENCES TBL_CATEGORY_C(ID);

/*한 번 주문했을 때 원래 있던 값을 다시 추가할 수 없기 때문에 APPLY만들어서 여기서 FK로 받아서 중복이 가능하게 만들어 놓는다.
 * 그러면 여러 사람이 같은 광고를 주문할 수 있다.*/
CREATE TABLE TBL_APPLY(
   ID NUMBER CONSTRAINT PK_APPLY PRIMARY KEY,
   COMPANY_ID NUMBER NOT NULL, 
   ADVERTISEMENT_ID NUMBER NOT NULL,
   CONSTRAINT FK_APPLY_COMPANY FOREIGN KEY(COMPANY_ID)
   REFERENCES TBL_COMPANY(ID),
   CONSTRAINT FK_APPLY_ADVERTISEMENT FOREIGN KEY(ADVERTISEMENT_ID)
   REFERENCES TBL_ADVERTISEMENT(ID)
);


/*
1. 요구사항
   음료수 판매 업체입니다. 음료수마다 당첨번호가 있습니다. 
   음료수의 당첨번호는 1개이고 당첨자의 정보를 알아야 상품을 배송할 수 있습니다.
   당첨 번호마다 당첨 상품이 있고, 당첨 상품이 배송 중인지 배송 완료인지 구분해야 합니다.

2. 개념 모델링
	음료수				당첨자				당첨번호				당첨상품			생산	
	이름					이름					번호					이름				음료ID
	제조사				주소										배송상태			당첨번호ID
	가격					번호
						당첨번호ID

3. 논리 모델링
	
4. 물리 모델링
	
5. 구현
*/

CREATE TABLE TBL_MEMBER(
   ID NUMBER CONSTRAINT PK_MEMBER PRIMARY KEY,
   MEMBER_ID VARCHAR2(255) CONSTRAINT UK_MEMBER UNIQUE NOT NULL,
   MEMBER_PASSWORD VARCHAR2(255) NOT NULL,
   MEMBER_NAME VARCHAR2(255) NOT NULL,
   MEMBER_ADDRESS VARCHAR2(255) NOT NULL,
   MEMBER_EMAIL VARCHAR2(255),
   MEMBER_BIRTH DATE
);

CREATE TABLE TBL_SOFT_DRINK(
   ID NUMBER CONSTRAINT PK_SOFT_DRINK PRIMARY KEY,
   SOFT_DRINK_NAME VARCHAR2(255)
);

CREATE TABLE TBL_PRODUCT(
   ID NUMBER CONSTRAINT PK_PRODUCT PRIMARY KEY,
   PRODUCT_NAME VARCHAR2(255) NOT NULL,
   PRODUCT_PRICE NUMBER DEFAULT 0,
   PRODUCT_STOCK NUMBER DEFAULT 0
);

CREATE TABLE TBL_LOTTERY(
   ID NUMBER CONSTRAINT PK_LOTTERY PRIMARY KEY,
   LOTTERY_NUMBER VARCHAR2(255) NOT NULL,
   PRODUCT_ID NUMBER,
   CONSTRAINT FK_LOTTERY_PRODUCT FOREIGN KEY(PRODUCT_ID)
   REFERENCES TBL_PRODUCT(ID)
);

CREATE TABLE TBL_CIRCULATION(
   ID NUMBER CONSTRAINT PK_CIRCULATION PRIMARY KEY,
   SOFT_DRINK_ID NUMBER,
   LOTTERY_ID NUMBER,
   CONSTRAINT FK_CIRCULATION_SOFT_DRINK FOREIGN KEY(SOFT_DRINK_ID)
   REFERENCES TBL_SOFT_DRINK(ID),
   CONSTRAINT FK_CIRCULATION_LOTTERY FOREIGN KEY(LOTTERY_ID)
   REFERENCES TBL_LOTTERY(ID)
);

CREATE TABLE TBL_DILIVERY(
   ID NUMBER CONSTRAINT PK_DILIVERY PRIMARY KEY,
   MEMBER_ID NUMBER NOT NULL,
   PRODUCT_ID NUMBER NOT NULL,
   STATUS NUMBER DEFAULT 0,
   CONSTRAINT FK_DILIVERY_MEMBER FOREIGN KEY(MEMBER_ID)
   REFERENCES TBL_MEMBER(ID),
   CONSTRAINT FK_DILIVERY_PRODUCT FOREIGN KEY(PRODUCT_ID)
   REFERENCES TBL_PRODUCT(ID)
);

/*
1. 요구사항
   이커머스 창업 준비중입니다. 기업과 사용자 간 거래를 위해 기업의 정보와 사용자 정보가 필요합니다.
   기업의 정보는 기업 이름, 주소, 대표번호가 있고
   사용자 정보는 이름, 주소, 전화번호가 있습니다. 결제 시 사용자 정보와 기업의 정보, 결제한 카드의 정보 모두 필요하며,
   상품의 정보도 필요합니다. 상품의 정보는 이름, 가격, 재고입니다.
   사용자는 등록한 카드의 정보를 저장할 수 있으며, 카드의 정보는 카드번호, 카드사, 회원 정보가 필요합니다.

2. 개념 모델링
	기업				사용자			카드				결제				상품			사용자_카드
	-------------------------------------------------------------------------------------
	이름				이름				카드번호			사용자ID			이름			카드ID
	주소				주소				카드사			카드ID			가격			사용자ID
	대표번호			전화번호			사용자ID			기업ID			재고
					카드ID							상품ID
					
					
3. 논리 모델링
	
4. 물리 모델링
	
5. 구현
*/

CREATE TABLE TBL_COMPANY(
	ID NUMBER CONSTRAINT PK_COMPANY PRIMARY KEY,
	COMPANY_NAME VARCHAR2(255) NOT NULL,
	COMPANY_ADDERSS VARCHAR2(255) NOT NULL,
	COMPANY_TELL VARCHAR2(255) NOT NULL
);

CREATE TABLE TBL_CARD(
	ID NUMBER CONSTRAINT PK_CARD PRIMARY KEY,
	CARD_NUMBER NUMBER NOT NULL,
	CARD_COMPANY VARCHAR2(255) NOT NULL
);


CREATE TABLE TBL_MEMBER(
   ID NUMBER CONSTRAINT PK_MEMBER PRIMARY KEY,
   MEMBER_NAME VARCHAR2(255) NOT NULL,
   MEMBER_ADDRESS VARCHAR2(255) NOT NULL
);

CREATE TABLE TBL_MEMBER_CARD(
   ID NUMBER CONSTRAINT PK_MEMBER_CARD PRIMARY KEY,
   CARD_ID NUMBER,
   MEMBER_ID NUMBER,
   CONSTRAINT FK_MEMBER_CARD_CARD FOREIGN KEY(CARD_ID)
   REFERENCES TBL_CARD(ID),
   CONSTRAINT FK_MEMBER_CARD_MEMBER FOREIGN KEY(MEMBER_ID)
   REFERENCES TBL_MEMBER(ID)
);

CREATE TABLE TBL_PRODUCT(
   ID NUMBER CONSTRAINT PK_PRODUCT PRIMARY KEY,
   PRODUCT_NAME VARCHAR2(255) NOT NULL,
   PRODUCT_PRICE NUMBER DEFAULT 0,
   PRODUCT_STOCK NUMBER DEFAULT 0
);

CREATE TABLE TBL_PAYMENT(
	ID NUMBER CONSTRAINT PK_PAYMENT PRIMARY KEY,
	MEMBER_CARD_ID NUMBER,
	PRODUCT_ID NUMBER,
	COMPANY_ID NUMBER,
	CONSTRAINT FK_PAYMENT_MEMBERCARD FOREIGN KEY(MEMBER_CARD_ID)
	REFERENCES TBL_MEMBER_CARD(ID),
	CONSTRAINT FK_PAYMENT_PRODUCT FOREIGN KEY(PRODUCT_ID)
	REFERENCES TBL_PRODUCT(ID),
	CONSTRAINT FK_PAYMENT_COMPANY FOREIGN KEY(COMPANY_ID)
	REFERENCES TBL_COMPANY(ID)
);









