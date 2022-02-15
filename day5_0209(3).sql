-- view : ���� ���̺�(���������� �������� �ʰ� �������� ������� ���̺�)
--          �� �������� ���̺��� �̿��ؼ� �����մϴ�.
--			�� �����(������)�� ���̺�ó�� select �� ��ȸ�� �Ҽ� �ִ� ���̺�
--			�� grant resource,connect to idev;   -> resource �� view ������ �����Դϴ�.


CREATE VIEW v_buy
AS
select PCODE ,CUSTOM_ID  FROM tbl_buy#;  --insufficient PRIVILEGES

/*  idev �������� creat view ���� �ּ���. (sql*plus ���� �����ϱ�)
SQL> connect system
Enter password:
Connected.
SQL> grant create view to idev;
Grant succeeded.
  
 */

-- view �� �̿��� select ��ȸ
SELECT * FROM V_BUY vb WHERE pcode='dk_143';

-- buy#, custom# �� �����Ͽ� custom_id,pcode,���̸�,�̸���,���ż���,���ų�¥
--  �� v_sale �̸��� view�� ���弼��.

CREATE VIEW v_sale
AS 
SELECT tc.CUSTOM_ID , tc.NAME ,tc.EMAIL ,tb.QUANTITY ,tb.BUY_DATE 
FROM "TBL_CUSTOM#" tc , "TBL_BUY#" tb 
WHERE tc.CUSTOM_ID = tb.CUSTOM_ID ;

SELECT * FROM v_sale ;
