-- commit ,rollback �׽�Ʈ
--   �� ���� auto commit ������ �����ؾ��մϴ�.
--   �� ���1) ���� �����⿡ ���ؼ��� ���� (�����ͺ��̽� �޴� - Ʈ����� ��� - manual commit )
--   �� ���2) ������ �޴� - ���� - ���� -���� ������ auto commit�� ����

-- ���� ���� 1��
SELECT * FROM tbl#;  -- ���� ���� Ȯ��

DELETE FROM tbl# WHERE acol='momo';
SELECT * FROM tbl#;   -- Ȯ��
rollback ;		-- DELETE ����� ������ �ǵ�����(���)
SELECT * FROM tbl#;	-- Ȯ��

-- ���� ���� 2��
DELETE FROM tbl# WHERE acol='momo';
SELECT * FROM tbl#;
COMMIT;
SELECT * FROM tbl#;
rollback ;		-- ������ COMMIT �� �����Ƿ� delete�� ����� �� �����.
SELECT * FROM tbl#;

-- ���� ���� 3��
INSERT INTO "TBL#" (acol,age) VALUES ('nana',33);
SELECT * FROM tbl#;
rollback ;
SELECT * FROM tbl#;


-- ���� ���� 4��
INSERT INTO "TBL#" (acol,age) VALUES ('nana22',33);
INSERT INTO "TBL#" (acol,age) VALUES ('����',29);
COMMIT;		-- ���� COMMIT �Ǵ� ROLLBACK �� �� ������ ����� commit
UPDATE "TBL#" SET bcol='test' WHERE acol='nana22';
DELETE FROM "TBL#" t WHERE acol ='main22';
ROLLBACK;	-- ���� COMMIT �Ǵ� ROLLBACK �� �� ������ ����� rollback

