-- 중요1 : 고객과 상품테이블의 행(row)데이터를 구분한 CUSTOM_ID ,PCODE 는 중복되면 안됩니다.
--			ㄴ 기본키 컬럼을 정합니다.(중복된 값과 NULL은 허용이 안됩니다.)
--			ㄴ 기본키는 테이블의 행(row)을 식별하는것이 목적입니다.
--			ㄴ select 를 기본키값으로 검색할 때 오직 0 또는 1개의 행 결과가 조회됩니다.
select * FROM "TBL_CUSTOM#" tc WHERE CUSTOM_ID ='mina012';
-- 중요2: 예를들면  PRICE , QUANTITY 등의 컬럼은 꼭 필수 데이터로 저장되어야 합니다.
--			ㄴ NOT NULL 컬럼으로 설정합니다.	(NULL 저장 안됩니다.)		
-- 중요3: 고객과 상품테이블에 없는 CUSTOM_ID,PCODE 컬럼 값을 사용하면 부정확한 데이터
--		ㄴ 외래키 컬럼을 정합니다.(다른테이블에서 값을 참조합니다.NULL 허용도 안합니다.)
--		ㄴ 외래키는 컬럼의 데이터가 참조값(다른테이블 컬럼)을 사용하게 하는것이 목적입니다.

-- 위의 NOT NULL, 기본키 , 외래키는 대표적인 *제약조건(CONSTRAINT)* 설정입니다.
-- 제약조건을 설정한 테이블로 생성해 봅니다.
-- 고객 테이블 
CREATE TABLE tbl_custom# (
	custom_id varchar2(20) PRIMARY KEY ,  
	name nvarchar2(20) NOT NULL ,		 
	email varchar2(20),
	age number(3),
	reg_date timestamp DEFAULT sysdate
);
-- 상품 테이블 : 상품코드(가변길이 20자리),카테고리(고정길이 2자리)
--								A1:전자제품, B1:식품
CREATE TABLE tbl_product#(
	pcode varchar2(20) CONSTRAINT pk_product PRIMARY KEY ,
	category char(2),
	pname nvarchar2(20) NOT NULL ,
	price number(9) NOT NULL 
);

-- 구매 테이블 : 어느 고객이 무슨 상품을 구입하는가?
-- 구매 테이블의 기본키는 별도로 컬럼을 추가합니다.

CREATE TABLE tbl_buy#(
	buy_seq number(8) ,		-- 구매정보 일련번호
	custom_id varchar2(20),
	pcode varchar2(20),
	quantity number(5) NOT NULL ,		--수량
	buy_date timestamp ,
--  CONSTRAINT키워드  제약조건이름  제약조건유형 (적용되는컬럼)
	CONSTRAINT pk_buy_seq PRIMARY KEY(buy_seq),
	CONSTRAINT fk_custom_id FOREIGN KEY (custom_id) -- 이 테이블의 컬럼명
		REFERENCES tbl_custom#(custom_id),	--참조테이블과 그 컬럼명
	CONSTRAINT fk_pcode FOREIGN KEY (pcode)
		REFERENCES tbl_product#(pcode)
	-- 외래키로 설정될 수 있는 컬럼은 기본키 또는 unique(유일한) 에 대해서만 가능합니다.	
	-- 외래키 컬럼은 참조(REFERENCES)테이블의	 컬럼값 중 하나로 저장할 수 있습니다.
);

SELECT * FROM "TBL_CUSTOM#" tc ;
-- 데이터의 추가 : INSERT 
INSERT INTO IDEV.TBL_CUSTOM#(CUSTOM_ID, NAME, EMAIL, AGE, REG_DATE)
VALUES('mina012', '김미나', 'kimm@gmail.com', 20, sysdate);
INSERT INTO IDEV.TBL_CUSTOM#(CUSTOM_ID, NAME, EMAIL, AGE, REG_DATE)
VALUES('hongGD', '홍길동', 'gil@korea.com', 32, sysdate);
INSERT INTO IDEV.TBL_CUSTOM#(CUSTOM_ID, NAME, EMAIL, AGE, REG_DATE)
VALUES('twice', '박모모', 'momo@daum.net', 29, sysdate);
INSERT INTO IDEV.TBL_CUSTOM#(CUSTOM_ID, NAME, EMAIL, AGE, REG_DATE)
VALUES('wonder', '이나나', 'lee@naver.com', 40, sysdate);
-- 중요1 : custom 테이블의 행(row)데이터를 구분한 CUSTOM_ID ,PCODE 는 중복되면 안됩니다.
INSERT INTO IDEV.TBL_CUSTOM#(CUSTOM_ID, NAME, EMAIL, AGE, REG_DATE)
VALUES('wonder', '최모모', 'choi@naver.com', 33, sysdate);

SELECT * FROM "TBL_PRODUCT#" tp ;
INSERT INTO IDEV.TBL_PRODUCT#(PCODE, CATEGORY, PNAME, PRICE)
VALUES('IPAD011', 'A1', '아이패드10', 880000);
INSERT INTO IDEV.TBL_PRODUCT#(PCODE, CATEGORY, PNAME, PRICE)
VALUES('DOWON123a', 'B1', '동원참치선물세트', 54000);
INSERT INTO IDEV.TBL_PRODUCT#(PCODE, CATEGORY, PNAME, PRICE)
VALUES('dk_143', 'A2', '모션데스크', 234500);
-- 중요2: 예를들면  PRICE , QUANTITY 등의 컬럼은 꼭 필수 데이터로 저장되어야 합니다.
INSERT INTO IDEV.TBL_PRODUCT#(PCODE, CATEGORY, PNAME)
VALUES('dk_1433', 'A2', '자동모션데스크');


-- 오라클에서는 일련번호를 자동으로 증가해서 사용하게 할수 있는 시퀀스 기능이 있스빈다.
CREATE SEQUENCE tbl_buy_seq;
-- 한번만들어져서 사용하던 시퀀스는 값을 되돌릴 수 없습니다.

--시퀀스 새로 만들고 싶다면 삭제하고 다시 만드세요.
DROP SEQUENCE tbl_buy_seq ;
--		테이블의 데이터도 삭제하세요. 그리고 다시 시퀀스 생성/데이터 추가하세요.

SELECT * FROM TBL_BUY# tb ;

-- 김미나가 아이패드 1개를 어제 구매
INSERT INTO IDEV.TBL_BUY#(BUY_SEQ,CUSTOM_ID, PCODE, QUANTITY, BUY_DATE)
VALUES(tbl_buy_seq.nextval,'mina012', 'IPAD011', 1, '2022-02-06');
-- 홍길동이 아이패드 2개를 오늘 구매
INSERT INTO IDEV.TBL_BUY#(BUY_SEQ,CUSTOM_ID, PCODE, QUANTITY, BUY_DATE)
VALUES(tbl_buy_seq.nextval,'hongGD', 'IPAD011', 2, sysdate);
-- 이나나가 참치선물세트 3개를 어제 구매
INSERT INTO IDEV.TBL_BUY#(BUY_SEQ,CUSTOM_ID, PCODE, QUANTITY, BUY_DATE)
VALUES(tbl_buy_seq.nextval,'wonder', 'DOWON123a', 3, '2022-02-06');
-- 김미나가 모션데스크 1개를 오늘 구매
INSERT INTO IDEV.TBL_BUY#(BUY_SEQ,CUSTOM_ID, PCODE, QUANTITY, BUY_DATE)
VALUES(tbl_buy_seq.nextval,'mina012', 'dk_143',1, sysdate);
-- 박모모가 참치선물세트 2개를 오늘 구매
INSERT INTO IDEV.TBL_BUY#(BUY_SEsQ,CUSTOM_ID, PCODE, QUANTITY, BUY_DATE)
VALUES(tbl_buy_seq.nextval,'twice', 'DOWON123a', 2, '2022-02-07');
COMMIT;
-- 중요3: 고객과 상품테이블에 없는 CUSTOM_ID,PCODE 컬럼 값을 사용하면 부정확한 데이터
-- 외래키로 설정된 custom_id는 tbl_custom# 테이블을 참조합니다. 참조테이블의
-- custom_id 컬럼값에 없는것을 저장할 수 없습니다. (외래키 위반,*무결성 제약조건* 위반)
INSERT INTO IDEV.TBL_BUY#(BUY_SEQ,CUSTOM_ID, PCODE, QUANTITY, BUY_DATE)
VALUES(tbl_buy_seq.nextval,'min012', 'dk_143',1, sysdate);
-- 외래키로 설정된 pcode는 tbl_product# 테이블을 참조합니다. 참조테이블의
-- pcode 컬럼값에 없는것을 저장할 수 없습니다. (외래키 위반,무결성 제약조건 위반)
INSERT INTO IDEV.TBL_BUY#(BUY_SEQ,CUSTOM_ID, PCODE, QUANTITY, BUY_DATE)
VALUES(tbl_buy_seq.nextval,'mina012', 'd_14',1, sysdate);


--1. custom# 테이블에서 age 가 30세 이상 모든 내용 조회
SELECT * FROM "TBL_CUSTOM#" tc WHERE age >= 30;
--2. custom# 테이블에서 custom_id 'twice' 의 email 조회
SELECT EMAIL FROM "TBL_CUSTOM#" tc WHERE CUSTOM_ID = 'twice'  
--3. product# 테이블에서 category 'A2' 의 pname 조회
SELECT pname FROM "TBL_PRODUCT#" tp WHERE CATEGORY = 'A2';
--4. product# 테이블에서 price 의 최고값 조회
SELECT MAX(price) FROM "TBL_PRODUCT#" tp ; 
--5. buy# 테이블에서 'IPAD011' 총구매 수량 조회
SELECT sum(QUANTITY) FROM "TBL_BUY#" tp WHERE PCODE = 'IPAD011'; 
--6. buy# 테이블에서 custom_id 'mina012' 의 모든 내용 조회
SELECT * FROM "TBL_BUY#" tb WHERE CUSTOM_ID = 'mina012'; 
--7. buy# 테이블에서 pcode 가 '1'이 포함된 것 조회
SELECT * FROM "TBL_BUY#" tb WHERE pcode='1';    --완전일치 조회
SELECT * FROM "TBL_BUY#" tb WHERE pcode LIKE '%1%';    --부분일치 조회.1을 포함
SELECT * FROM "TBL_BUY#" tb WHERE pcode LIKE '1%';    --부분일치 조회.1로 시작
SELECT * FROM "TBL_BUY#" tb WHERE pcode LIKE '%1';    --부분일치 조회.1로 끝나는
--8. buy# 테이블에서 pcode 에 'on'을 포함하는 것 조회(대소문자 구분없는 조회)
SELECT * FROM "TBL_BUY#" tb WHERE lower(pcode) like '%on%';



