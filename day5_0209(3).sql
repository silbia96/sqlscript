-- view : 가상 테이블(물리적으로 존재하지 않고 논리적으로 만들어진 테이블)
--          ㄴ 물리적인 테이블을 이용해서 생성합니다.
--			ㄴ 사용자(개발자)가 테이블처럼 select 를 조회를 할수 있는 테이블
--			ㄴ grant resource,connect to idev;   -> resource 에 view 생성은 제외입니다.


CREATE VIEW v_buy
AS
select PCODE ,CUSTOM_ID  FROM tbl_buy#;  --insufficient PRIVILEGES

/*  idev 유저에게 creat view 권한 주세요. (sql*plus 에서 실행하기)
SQL> connect system
Enter password:
Connected.
SQL> grant create view to idev;
Grant succeeded.
  
 */

-- view 를 이용한 select 조회
SELECT * FROM V_BUY vb WHERE pcode='dk_143';

-- buy#, custom# 을 조인하여 custom_id,pcode,고객이름,이메일,구매수량,구매날짜
--  ㄴ v_sale 이름의 view를 만드세요.

CREATE VIEW v_sale
AS 
SELECT tc.CUSTOM_ID , tc.NAME ,tc.EMAIL ,tb.QUANTITY ,tb.BUY_DATE 
FROM "TBL_CUSTOM#" tc , "TBL_BUY#" tb 
WHERE tc.CUSTOM_ID = tb.CUSTOM_ID ;

SELECT * FROM v_sale ;
