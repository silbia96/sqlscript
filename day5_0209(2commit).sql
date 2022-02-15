-- commit ,rollback 테스트
--   ㄴ 디비버 auto commit 설정을 변경해야합니다.
--   ㄴ 방법1) 현재 편집기에 대해서먼 변경 (데이터베이스 메뉴 - 트랜잭션 모드 - manual commit )
--   ㄴ 방법2) 윈도우 메뉴 - 설정 - 연결 -연결 유형을 auto commit을 해제

-- 실행 순서 1번
SELECT * FROM tbl#;  -- 현재 상태 확인

DELETE FROM tbl# WHERE acol='momo';
SELECT * FROM tbl#;   -- 확인
rollback ;		-- DELETE 명령을 원래로 되돌리기(취소)
SELECT * FROM tbl#;	-- 확인

-- 실행 순서 2번
DELETE FROM tbl# WHERE acol='momo';
SELECT * FROM tbl#;
COMMIT;
SELECT * FROM tbl#;
rollback ;		-- 위에서 COMMIT 을 했으므로 delete를 취소할 수 없어요.
SELECT * FROM tbl#;

-- 실행 순서 3번
INSERT INTO "TBL#" (acol,age) VALUES ('nana',33);
SELECT * FROM tbl#;
rollback ;
SELECT * FROM tbl#;


-- 실행 순서 4번
INSERT INTO "TBL#" (acol,age) VALUES ('nana22',33);
INSERT INTO "TBL#" (acol,age) VALUES ('쯔위',29);
COMMIT;		-- 최종 COMMIT 또는 ROLLBACK 한 그 이후의 명령을 commit
UPDATE "TBL#" SET bcol='test' WHERE acol='nana22';
DELETE FROM "TBL#" t WHERE acol ='main22';
ROLLBACK;	-- 최종 COMMIT 또는 ROLLBACK 한 그 이후의 명령을 rollback




