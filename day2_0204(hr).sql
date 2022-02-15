-- 연습문제 : 작성자 김땡땡 -> 스크립트 화면 캡쳐해서 dm 보내주세요.

--1.jobs 테이블 문제
	--1)min_salary 컬럼이 10000이상인 Job_title조회
		SELECT job_title FROM JOBS j WHERE MIN_SALARY  >=10000;
	--2)job_title 컬럼이 programmer 인 행의 모든 컬럼 조회
		SELECT *FROM JOBS j WHERE job_title ='programmer';
		SELECT *FROM JOBS j WHERE job_title ='Programmer';
		-- 대소문자 상관없이 조건 검색한다면 문자열 관련 오라클 함수 : upper(), lower() 이용합니다.
		SELECT *FROM JOBS j WHERE UPPER(job_title)  ='PROGRAMMER';
		SELECT *FROM JOBS j WHERE LOWER(job_title)  ='programmer';
	
	--3)max_salary 필드값의 컬럼의 최대값 조회
		SELECT MAX(max_salary) FROM JOBS j ;
	

--2. locations 테이블 문제
	--1)city 컬럼이 Lodon 인 postal_code 조회
		SELECT postal_code FROM LOCATIONS l WHERE CITY  ='London';
		SELECT postal_code FROM LOCATIONS l WHERE CITY  ='Seattle';
	
	--2)LOCATIONAL_ID컬럼이 1700,2700,2500이 아니고 city 컬럼이 Tokyo인 행의 모든 컬럼 조회
	SELECT *FROM LOCATIONS l WHERE LOCATION_ID NOT IN (1700,2700,2500) AND  CITY ='Tokyo';


--3. employees 테이블
-- 통계함수(집계 함수) 를 좀더 연습합니다.
SELECT count(*) FROM EMPLOYEES e ;		-- 총개수 : 107
SELECT count(*) FROM EMPLOYEES e WHERE JOB_ID ='IT_PROG';    -- 조건 job_id 직원수 : 5 

SELECT AVG(SALARY) FROM EMPLOYEES e ;	-- 직원 평균 급여 : 6461.83
SELECT AVG(SALARY) FROM EMPLOYEES e WHERE JOB_ID ='IT_PROG';  -- 조건 job_id 평균급여 : 5760

SELECT MAX(salary) FROM EMPLOYEES e ;    -- 직원 중 최고 급여 : 24,000
SELECT MAX(salary) FROM EMPLOYEES e  WHERE JOB_ID ='IT_PROG';  -- 조건 job_id 최고급여 : 9000

SELECT MIN(salary) FROM EMPLOYEES e;    -- 직원 중 최소 급여 : 2,100
SELECT MIN(salary) FROM EMPLOYEES e WHERE JOB_ID ='IT_PROG';    -- 조건 job_id 최소급여 : 4200

-- 통계함수는 그룹함수입니다. 해당함수 결과값을 구하기위해 여러 데이터들을 그룹화하고 실행합니다.
-- 그룹함수 결과와 다른 컬럼을 같이 조회할수 없습니다. 아래 sql은 오류 입니다.
SELECT JOB_ID , MAX(salary) FROM EMPLOYEES e ;

SELECT * FROM EMPLOYEES e2 WHERE SALARY = (
-- 위의 max,min 구한 sql명령을 하나씩 여기에 넣어보세요.그 의미를 파악해 봅시다.
--	SELECT MAX(salary) FROM EMPLOYEES e
--	SELECT MAX(SALARY) FROM EMPLOYEES e WHERE JOB_ID ='IT_PROG'
--	SELECT MIN(salary) FROM EMPLOYEES e
  SELECT MIN(salary) FROM EMPLOYEES e WHERE JOB_ID ='IT_PROG'
);  -- SELECT 안에 쓰인 또 다른 SELECT 는 서브쿼리입니다.서브쿼리 결과값이 1개이므로 = 조건식에 사용하수 있습니다.

-- IT_PROG 중에서 최소급여를 받는 사람의 first_name, last_name 컬럼 조회하기
SELECT first_name, last_name,SALARY  FROM EMPLOYEES e 
WHERE SALARY = (SELECT MIN(SALARY)  FROM EMPLOYEES e WHERE JOB_ID ='IT_PROG')
	AND JOB_ID ='IT_PROG';



-- 추가 : min_salary 의 평균값보다 작은 행의 job_id,job_title 컬럼 조회 -
--     * 아래 명령은 오류 -> 그룹함수는 반드시 select 문으로 사용합니다. *
SELECT job_id ,job_title,MIN_SALARY  FROM JOBS j 
WHERE MIN_SALARY < AVG(MIN_SALARY);

-- 평균값 
SELECT AVG(MIN_SALARY) FROM JOBS j;
-- 평균값을 조건식에 이용하기 (서브쿼리)
SELECT job_id ,job_title,MIN_SALARY  FROM JOBS j 
WHERE MIN_SALARY < (SELECT AVG(MIN_SALARY) FROM JOBS j);
























