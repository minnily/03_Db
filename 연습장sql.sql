DCL 다시 정리해보기!

계정 추가하고 접속 권한을 부여하는 방법

계정을 추가하는 방법
CREATE USER 사용자명 IDENTIFIED BY 비밀번호!

접속 권한을 부여하는 방법
GRANT CREATE SESSION TO (권한을 줄 계정의) 사용자명!

테이블 을 생성할 권한을 부여하는 방법

GRANT CREATE TABLE TO 사용자명

그리고 해당 사용자가 무제한으로 공간을 사용할 수 있는 권한을 제공하는 방법
ALTER USER 사용자계정 DEFAULT TABLESPACE 
SYSTEM QUOTA UNLIMITED ON SYSTEM;


계정에 CONNECT, RESOURCE 부여하기!

CONNECT -> 접속 관련 권한을 묶어둔 ROLE
RESOURCE ->  사용을 위한 기본 객체 생성 권한을 묶어둔 ROLE

GRANT CONNECT, RESOURSE TO 사용자계정명


객체에 권한을 부여하는 방법
 1. sample계정에 있는 EMPLOYEE 테이블을 kh_cmh 계정을 통해 조회해보기
SELECT * FROM kh_cmh.EMPLOYEE;
---> 조회 시 존재하지 않는다고 오류가 발생하는데, 접근할 수 있는 권한이 없기에 조회가 불가능하다.
따라서, sample계정에서 객체에 권한을 부여해줘야함!

테이블 조회 권한을 부여하는 방법
GRANT 객체 권한 (여기서는 SELECT임! SELECT 문이기에!) ON 객체명!
(해당구문에서는 테이블명이 해당된다.) EMPLOYEE TO 사용자명! 


객체 권한을 회수하는 방법은 뭐가 있을까?!
REVOKE 를 사용하면 된다.
객체 권한 회수 작성법!
REVOKE (객체권한)SELECT ON (객체명=테이블명)EMPLOYEE FROM 사용자명


서브쿼리 다시 정리해보기!

서브쿼리란?(SUBQUERY)
SQL문 안에 포함된 또다른 SQL문인데, 메인 쿼리를 위해 보조 역할을 한다! 
서브쿼리는 SELECT, FROM, WHERE, HAVING 절에 사용이 가능하다!

서브쿼리 예시
부서코드가 노옹철 사원과 같은 소속의 직원의 이름, 부서코드 조회하기
=> 부서코드가 같은 직원의 이름, 부서코드 조회하기(메인쿼리)/ 노옹철 사원의 부서코드 조회하기 (서브쿼리)
임을 알 수 있다.
처음에는 바로 작성하기에 어려움이 있을 수 있으니 메인쿼리, 서브쿼리를 따로 작성 후 합쳐주기를 연습하면 한결 쉽게 작성할 수 있음~!


-- 1) 노옹철의 부서코드 조회 (서브쿼리)
SELECT DEPT_CODE 
FROM EMPLOYEE 
WHERE EMP_NAME = '노옹철';

-- 2) 부서 코드가 'D9'인 직원을 조회(메인쿼리)
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

--3) 부서코드가 노옹철 사원과 같은 소속의 직원 명단 조회
--> 위의 2개의 단계를 하나의 쿼리로!
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE 
									FROM EMPLOYEE 
									WHERE EMP_NAME = '노옹철');
									
==> 노옹철의 부서코드와 같은 부서의 직원의 명단을 조회해야하기에  WHERE절에 서브쿼리를 넣어주면 된다.

두번째 서브쿼리 예시
전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의 사번, 이름, 직급코드, 급여조회

=> 여기서 전 직원의 평균 급여가 서브쿼리이며 이보다 많이 받는 직원의 사번, 이름, 직급코드 급여를 조회하는 것이 메인 쿼리인 것을 알 수 있다.
;

SELECT  EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= (SELECT ROUND(AVG(SALARY),1)
FROM EMPLOYEE);

으로 작성하여 조회를 하면 된다~!

서브쿼리에는 정말 많은 유형이 있는데..! 짧게 알아보자 !
위에서 작성한 것 같은 예시 같은 유형은 단일행 서브쿼리라고 해서 조회결과 값의 개수가  하나인 것이다. 따라서 단일행 서브쿼리 앞에는
비교연산자를 사용한다!

예시
-- 부서별(부서가 없는 사람 포함) 급여의 합계 중 (서브쿼리)
-- 가장 큰 부서의 부서명, 급여 합계를 조회 (메인쿼리)
;

SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_ID =DEPT_CODE)
GROUP BY DEPT_TITLE 
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
											FROM EMPLOYEE
											GROUP BY DEPT_CODE);
										
										
다중행 서브쿼리란? 서브쿼리의 조회 결과 값의 개수가 여러행인 경우를 말한다. 그럴때 



