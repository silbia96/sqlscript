-- UPDATE ���� 
-- 		UPDATE ���̺��
-- 		SET ������ �÷��̸�=�� �� ,�� �����ؼ� ����
-- 		WHERE ������ �࿡ ���� ���ǽ�.

SELECT * FROM "TBL_CUSTOM#" tc ;

-- *update�� delete �� where ���ǽ��� ���Ǵ� ���� �����մϴ�.*
UPDATE "TBL_CUSTOM#" 
SET age=39
WHERE CUSTOM_ID ='twice';	
--�⺻Ű �÷���� ���ǽ��� 1�� �ุ �����˴ϴ�.

UPDATE "TBL_CUSTOM#" 
SET age=23 , EMAIL ='nana@korea.kr'
WHERE CUSTOM_ID = 'wonder';

-- custom_id : wonder�� twice �� ���� 
-- reg_date�� 2022��2��5�Ϸ� ����
UPDATE "TBL_CUSTOM#" 
SET REG_DATE ='2022-02-05'
WHERE CUSTOM_ID IN ('wonder','twice');	-- IN �����ڴ� OR ��ü

-- delete ����
--   delete from ���̺�� where ���ǽ�;
-- ������ ���� ���õ����� �߰�
INSERT INTO "TBL_PRODUCT#" (pcode,CATEGORY,PNAME,PRICE)
VALUES ('GAL0112','A1','������20',912300);


DELETE FROM "TBL_PRODUCT#" tp WHERE PCODE ='GAL0112';	-- ���� : buy#���� �������� �ʴ°�
DELETE FROM "TBL_PRODUCT#" tp WHERE PCODE ='IPAD011';	-- ���� : ���Ἲ ����

UPDATE "TBL_PRODUCT#" SET PNAME ='�����е�����'
WHERE pcode='IPAD011';		-- ���� ����

UPDATE "TBL_PRODUCT#" SET PCODE='IPAD011X'
WHERE pcode='IPAD011';		-- ���� : buy#���� �����ϴ� ��(���Ἲ ����)

SELECT * FROM "TBL_CUSTOM#" tc ;
SELECT * FROM "TBL_PRODUCT#" tp ;
SELECT * FROM "TBL_BUY#" tb ;
-- on delete, on update(����Ŭ�� �ȵ�) �Ӽ� �����Ͽ� �ܷ�Ű �ٽ� �����մϴ�.
ALTER TABLE IDEV."TBL_BUY#" 
			DROP CONSTRAINT "FK_TBL_PRODUCT#" ;
ALTER TABLE IDEV."TBL_BUY#" 
			ADD CONSTRAINT "FK_TBL_PRODUCT#" 
			FOREIGN KEY (PCODE) REFERENCES IDEV."TBL_PRODUCT#"(PCODE) 
			ON DELETE CASCADE;	
			-- ���Ἲ�� ���ؼ� �����ϴ°� ������ �����ϴ� �൵ ������(���޾Ƽ�)���� ����
-- ALTER TABLE ���� : drop ,add, modify(���������� ���մϴ�.)

		
-- SELECT �� JOIN : �� �̻��� ���̺�(�ַ� ���������� ���̺�)�� �����Ͽ� �����͸� ��ȸ�ϴ� ���
--				�� �̻��� ���̺��� ����� �÷��� ���� �� �÷��� �̿��Ͽ� join �մϴ�.
-- ����1 : select ~~~ from ���̺�1 a,���̺�2 b 
--					where a.�����÷�1=b.�����÷�1;	

SELECT * FROM "TBL_PRODUCT#" tp , "TBL_BUY#" tb 
		 WHERE tp.PCODE = tb.PCODE ;		-- ���� ����.

-- JOIN�� ���� ��ɹ� ����2(ǥ��)
SELECT * FROM "TBL_PRODUCT#" tp 
		 JOIN "TBL_BUY#" tb 
		 ON tp.PCODE =tb.PCODE ; 
		
-- 	mina012 �� ������ ��ǰ���� �����ΰ� ��ȸ�ϱ�
SELECT tp.PNAME  FROM "TBL_PRODUCT#" tp , "TBL_BUY#" tb 
		 WHERE tp.PCODE = tb.PCODE AND custom_id ='mina012';		
		
--  mina012 �� ������ ��ǰ��� ���� ��ȸ�ϱ�		
SELECT tp.PNAME,tp.PRICE  FROM "TBL_PRODUCT#" tp , "TBL_BUY#" tb 
		 WHERE tp.PCODE = tb.PCODE AND custom_id ='mina012';	
		
-- �����Ҷ� , ����� �÷��� ���̺���� �� �����ؾ� �մϴ�.		
SELECT tp.PCODE ,tp.PNAME  FROM "TBL_PRODUCT#" tp , "TBL_BUY#" tb 
		 WHERE tp.PCODE = tb.PCODE AND custom_id ='mina012';	

-- �ܺ����� ���� 2����		
SELECT * FROM "TBL_PRODUCT#" tp , "TBL_BUY#" tb 
		 WHERE tp.PCODE = tb.PCODE(+) ;		-- �ܺ�����.

-- JOIN�� ���� ��ɹ� ����2(ǥ��)
SELECT * FROM "TBL_PRODUCT#" tp 
		 LEFT OUTER JOIN "TBL_BUY#" tb 	-- ������ �Ǵ� ���̺��� ���� product#
		 ON tp.PCODE =tb.PCODE ; 		

SELECT * FROM "TBL_BUY#" tb
		 RIGHT OUTER JOIN "TBL_PRODUCT#" tp  	-- ������ �Ǵ� ���̺��� ������ product#
		 ON tp.PCODE =tb.PCODE ; 
		
-- ������ �׽�Ʈ �Ǵ� ������ ������ ���� ���̺��� ��� ������ �����ϱ�
-- delete : rollback���� ���� ��� ����, truncate : ���� ��ҺҰ���
-- truncate : ���������� �� , fk�� ��Ȱ��ȭ�ϰ� ������ �����ؾ��մϴ�.		
TRUNCATE TABLE "TBL_BUY#" ;		-- �������̺� ������ ���� ����
DELETE FROM "TBL_PRODUCT#" ;	-- ��ü ������ ������ �������� ���-> Ȯ��
TRUNCATE TABLE "TBL_CUSTOM#" ;	-- ����
		