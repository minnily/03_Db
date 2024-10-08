/* 
[JOIN 용어 정리]
  오라클       	  	                                SQL : 1999표준(ANSI)
----------------------------------------------------------------------------------------------------------------
등가 조인		                            내부 조인(INNER JOIN), JOIN USING / ON
                                            + 자연 조인(NATURAL JOIN, 등가 조인 방법 중 하나)
----------------------------------------------------------------------------------------------------------------
포괄 조인 		                        왼쪽 외부 조인(LEFT OUTER), 오른쪽 외부 조인(RIGHT OUTER)
                                            + 전체 외부 조인(FULL OUTER, 오라클 구문으로는 사용 못함)
----------------------------------------------------------------------------------------------------------------
자체 조인, 비등가 조인   	                		    JOIN ON
----------------------------------------------------------------------------------------------------------------
카테시안(카티션) 곱		              			 교차 조인(CROSS JOIN)
CARTESIAN PRODUCT

- 미국 국립 표준 협회(American National Standards Institute, ANSI) 미국의 산업 표준을 제정하는 민간단체.
- 국제표준화기구 ISO에 가입되어 있음.
*/
-----------------------------------------------------------------------------------------------------------------------------------------------------
-- JOIN
-- 하나 이상의 테이블에서 데이터를 조회하기 위해 사용.
-- 수행 결과는 하나의 Result Set으로 나옴.

-- (참고) JOIN은 서로 다른 테이블의 행을 하나씩 이어 붙이기 때문에
--       시간이 오래 걸리는 단점이 있다!

/* 
- 관계형 데이터베이스에서 SQL을 이용해 테이블간 '관계'를 맺는 방법.

- 관계형 데이터베이스는 최소한의 데이터를 테이블에 담고 있어
  원하는 정보를 테이블에서 조회하려면 한 개 이상의 테이블에서 
  데이터를 읽어와야 되는 경우가 많다.
  이 때, 테이블간 관계를 맺기 위한 연결고리 역할이 필요한데,
  두 테이블에서 같은 데이터를 저장하는 컬럼이 연결고리가됨.   
*/


--------------------------------------------------------------------------------------------------------------------

-- 기존에 서로 다른 테이블의 데이터를 조회 할 경우 아래와 같이 따로 조회함.

-- 직원번호, 직원명, 부서코드, 부서명을 조회하고자 할 때
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

-- 부서명은 DEPARTMENT 테이블에서 조회 가능
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);



-- 1. 내부 조인(INNER JOIN) (== 등가 조인(EQUAL JOIN))
---> 연결되는 컬럼의 값이 일치하는 행들만 조인됨.
-- (===> 일치하는 값이 없는 행은 조인에서 제외됨)


-- 작성 방법은 크게 ANSI 구문과 오라클 구문으로 나뉘고 
-- ANSI에서 USING과 ON을 쓰는 방법으로 나뉜다.


-- 1) 연결에 사용할 두 컬럼명이 다른 경우

-- ANSI
-- 연결에 사용할 컬럼명이 다른 경우 ON()을 사용
-- (오라클 문법 보다는 ANSI 문법을 주로 사용함)

SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- 오라클
-- 연결할 테이블을 FROM절 옆에 , 하고 사용하고 
-- 밑에 조건으로 컬럼명이 같을 때라는 조건을 넣어줌.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID ;


--DEPARTMENT 테이블, LOCATION 테이블을 참조하여 
-- 부서명, 지역명 조회
/*
 *
 DEPARTMENT 테이블
 DEPT_ID|DEPT_TITLE|LOCATION_ID|
-------+----------+-----------+
D1     |인사관리부     |L1         |
D2     |회계관리부     |L1         |
D3     |마케팅부      |L1         |
D4     |국내영업부     |L1         |
D5     |해외영업1부    |L2         |
D6     |해외영업2부    |L3         |
D7     |해외영업3부    |L4         |
D8     |기술지원부     |L5         |
D9     |총무부       |L1         |


LOCATION 테이블
LOCAL_CODE|NATIONAL_CODE|LOCAL_NAME|
----------+-------------+----------+
L1        |KO           |ASIA1     |
L2        |JP           |ASIA2     |
L3        |CH           |ASIA3     |
L4        |US           |AMERICA   |
L5        |RU           |EU        |


*/


-- ANSI 방식
SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT
JOIN LOCATION ON (LOCATION_ID  = LOCAL_CODE);

-- 오라클 방식
SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT, LOCATION 
WHERE  LOCATION_ID  = LOCAL_CODE;

-- 2) 연결에 사용할 두 컬럼명이 같은 경우

-- EMPLOYEE 테이블, JOB테이블을 참조하여
-- 사번, 이름, 직급코드, 직급명 조회

-- ANSI 
-- 연결에 사용할 컬럼명이 같은 경우 USING(컬럼명)을 사용함
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

-- 오라클 --> 별칭 사용!
-- 테이블 별로 별칭을 등록할 수 있음.
-- 별칭을 사용해야하는 이유?

SELECT EMP_ID,EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE  ,JOB
WHERE JOB_CODE  = JOB_CODE;
-- ORA-00918: 열의 정의가 애매합니다 

SELECT EMP_ID,EMP_NAME, E.JOB_CODE, JOB_NAME
-- (= SELECT EMP_ID,EMP_NAME, J.JOB_CODE, JOB_NAME)
FROM EMPLOYEE  E ,JOB J
WHERE E.JOB_CODE  = J.JOB_CODE;


/* INNER(내부 조인) 문제점
 * -> 연결에 사용된 컬럼에 값이 일치하지 않으면 조회 결과에 포함되지 않는다.!
 * */
----------------------------------------------------------------------------------------------------------

-- 2. 외부 조인 (OUTER JOIN)

-- 두 테이블의 지정하는 컬럼값이 일치하지 않는 행도 조인에 포함 시킴
--> * 반드시 OUTER JOIN 명시해야 한다.

--OUTER JOIN과 비교할 INNER JOIN 쿼리문
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
/*INNER (생략이 가능하다)*/JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);


-- 1) LEFT [OUTER] JOIN : 합치기에 사용한 두 테이블 중 왼편에 기술된 테이블의 컬럼수로 JOIN
--> 왼편에 작성된 테이블의 모든 행이 결과에 포함되어야 한다(JOIN이 안되는 행도 결과에 포함)

-- ANSI 표준
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE LEFT JOIN DEPARTMENT
ON( DEPT_CODE = DEPT_ID);-- 23행 (하동운,이오리 포함)


-- 오라클 구문
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID (+); 
-- 반대쪽 테이블 컬럼에 (+) 기호를 작성해야 함 !



-- 2) RIGHT  [ OUTER ] JOIN : 합치기에 사용한 두 테이블 중 
--오른편에 기술된 테이블의 컬럼 수를 기준으로 JOIN


-- ANSI 표준
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE RIGHT JOIN DEPARTMENT
ON( DEPT_CODE = DEPT_ID); 
--> EMPLOYEE 부서에 없는 부서들도 함께 나타남. (NULL로)
-- 마케팅 부, 국내영업부, 해외 영업3부 NULL


-- 오라클 구문

SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID ; 

-- 3) FULL[OUTER] JOIN : 합치기에 사용한 두 테이블이 가진 
--	모든 행을 결과에 포함
-- ** 오라클 구문 FULL OUTER JOIN을 사용 못함 **

-- ANSI 표준
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE FULL JOIN DEPARTMENT
ON( DEPT_CODE = DEPT_ID); -- 포함하지 않은 모든 값이 다 나옴


-- 오라클 구문(안됨!!!XX)

SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID(+) ; 
-- ORA-01468: outer-join된 테이블은 1개만 지정할 수 있습니다 오류발생
