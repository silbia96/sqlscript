-- 데이터 타입 number 연습 테이블
-- number : 자바 byte,short,int,long,float,double 해당
--		    number(정밀도,소수점자리수)
-- table_number 테이블 이름
CREATE TABLE table_number(
	col1 NUMBER,		-- 자릿수를 지정하지 않으면 최대 38자리입니다.(자바 BigDecimal)
	col2 number(5),
	col3 number(7,2),
	col4 number(2,5)
);
-- 정상 실행
INSERT INTO IDEV.TABLE_NUMBER (COL1, COL2, COL3, COL4)
VALUES(1234567, 12345, 12345.67, 0.00012);
-- col2 칼럼의 자릿수가 6개 : 오류
INSERT INTO IDEV.TABLE_NUMBER (COL1, COL2, COL3, COL4)
VALUES(1234567, 123456, 12345.67, 0.00012);
-- col3 칼럼은 소수점 이하 자릿수를 2개 : 반올림
INSERT INTO IDEV.TABLE_NUMBER (COL1, COL2, COL3, COL4)
VALUES(1234567, 12345, 12345.678, 0.00012);
-- col3 컬럼 전체 자릿수 7개 : 소수점이하 항상 2개 , 그리고 정수자릿수 5개 -> 자릿수 초과 오류
INSERT INTO IDEV.TABLE_NUMBER (COL1, COL2, COL3, COL4)
VALUES(1234567, 12345, 123456.67, 0.00012);
-- col4 컬럼은 number(2,5) : 전체 유효자릿수 :5 개, 
--       이 때 항상~~~ 유효자릿수 최대 2개(0 포함 가능) , 나머지 3개는 무조건 0
INSERT INTO IDEV.TABLE_NUMBER (COL1, COL2, COL3, COL4)
VALUES(1234567, 12345, 12345.67, 0.000126);
-- col4 컬럼은 number(2,5) : 최소 나머지 3개는 유효자릿수 0 -> 이것이 아니면 오류
INSERT INTO IDEV.TABLE_NUMBER (COL1, COL2, COL3, COL4)
VALUES(1234567, 12345, 12345.67, 0.0012);

-- 0.00012300 일 때, 유효한 숫자 0.000123  123뒤에 00은 유효한 값이 아닙니다.
-- 00123000 일때, 유효한 숫자 123000 , 123 앞에 00은 유효한 값이 아닙니다.

INSERT INTO IDEV.TABLE_NUMBER (COL1, COL2, COL3, COL4)
VALUES(1234567, 12345, 12345.67, 0.0000123);
INSERT INTO IDEV.TABLE_NUMBER (COL1, COL2, COL3, COL4)
VALUES(1234567, 12345, 12345.67, 0.0);