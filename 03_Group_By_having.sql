/*SELECT 문 해석 순서

* 해석5: SELECT 컬럼명 AS 별칭, 계산식, 함수식
* 해석1: FROM 테이블명
  해석2: WHERE 컬럼명 | 함수식 비교연산자 비교값
	해석3: GROUP BY 그룹을 묶을 컬럼명
* 해석4: HAVING 그룹함수식 비교연산자 비교값
* 해석6: ORDER BY 컬럼명 | 별칭 | 컬럼순번 정렬방식(ASC/DESC) [NULLS FIRST | LAST] 
  																														=> NULL 값이 앞에나오게 할것인지 뒤에나오게 할것인지
* 
***/

-----------------------------------------------------------------------------------------------------------------------

-- * GROUP BY 절 : 같은 값들이 여러개 기록된 컬럼을 가지고 같은 값들을 하나의 그룹으로 묶음


-- GROUP  BY 컬럼명 | 함수식, ...

-- 여러개의 값을 묶에서 하나로 처리할 목적으로 사용함.
-- 그룹으로 묶은 값에 대해서 SELECT절에서 그룹함수로 사용함.

-- 그룹함수는 단 한개의 결과 값만 산출하기 때문에 그룹이 여러개일 경우 오류 발생
-- 여러개의 결과 값을 산출하기 위해 그룹함수가 적용된 기분을 ORDER BY절에 기술하여 사용

--EMPLOYEE 테이블에서 부서코드, 부서별 급여 합 조회

--1) 부서코드만 조회
SELECT DEPT_CODE FROM EMPLOYEE; --23행

--2) 전체 급여 합 조회
SELECT SUM(SALARY) FROM EMPLOYEE; --1행

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE;
-- 오류 발생 ORA-00937: 단일 그룹의 그룹 함수가 아닙니다

--오류 발생한 위 내용 알맞게 수정하기!
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE; --> DEPT_CODE가 같은 행끼리 하나의 그룹이 됨.

--EMPLOYEE 테이블에서 직급코드가 같은 사람의 직급코드, 급여평균, 인원수를 
-- 직급코드 오름차순으로 조회
SELECT JOB_CODE, ROUND(AVG(SALARY)),COUNT(*)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE ;

-- EMPLOYEE 테이블에서 
-- 성별(남/여)과 각 성별 별 인원 수, 급여 합을 
-- 인원 수 오름차순으로 조회
SELECT DECODE(SUBSTR(EMP_NO,8,1),'1', '남', '2','여') 성별 ,
				COUNT(*) "인원 수" , SUM(SALARY) "급여 합"  
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO,8,1),'1', '남', '2','여') 
					--> 별칭사용이 안된다! 별칭 또는 컬럼순서를 작성하면X SELECT절을 해석하기 전이기 때문
ORDER BY "인원 수" ; --> 해석순서로 인해 별칭 사용O





