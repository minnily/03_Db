--JOIN 연습문제

--1. 

SELECT EMP_NAME 사원명, EMP_NO 주민번호, DEPT_TITLE 부서명, JOB_NAME 직급명
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE= DEPT_ID)
JOIN JOB USING (JOB_CODE)
WHERE EMP_NO LIKE '7%'
AND SUBSTR(EMP_NO,8,1) = '2'
AND EMP_NAME LIKE '전%';

--2. 

SELECT EMP_ID 사번, EMP_NAME 사원명, JOB_NAME 직급명, DEPT_TITLE 부서명
FROM EMPLOYEE
NATURAL JOIN JOB
LEFT JOIN DEPARTMENT ON (DEPT_ID =DEPT_CODE)
WHERE EMP_NAME LIKE '%형%';

-- 3.
SELECT EMP_NAME 사원명, JOB_NAME 직급명, DEPT_CODE 부서코드, DEPT_TITLE 부서명
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_ID =DEPT_CODE)
JOIN JOB USING(JOB_CODE)
WHERE DEPT_TITLE LIKE '해%'
AND DEPT_TITLE NOT LIKE '____3%'; 

--4.  
SELECT EMP_NAME 사원명, BONUS 보너스포인트, DEPT_TITLE 부서명, LOCAL_NAME 근무지역명
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_ID =DEPT_CODE)
LEFT JOIN LOCATION ON(LOCAL_CODE = LOCATION_ID)
WHERE BONUS IS NOT NULL;

--5.
SELECT EMP_NAME 사원명, JOB_NAME 직급명, DEPT_TITLE 부서명, LOCAL_NAME 지역명
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON(DEPT_ID =DEPT_CODE)
JOIN LOCATION ON(LOCAL_CODE = LOCATION_ID); 


--6.
SELECT EMP_NAME 사원명, JOB_NAME 직급명, SALARY 급여, (SALARY*(1+NVL(BONUS,0)))*12 연봉
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN SAL_GRADE USING(SAL_LEVEL)
WHERE MIN_SAL < SALARY ;

--7. 
SELECT EMP_NAME 사원명, DEPT_CODE 부서명, LOCAL_NAME 지역명, NATIONAL_NAME 국가명
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_ID =DEPT_CODE)
JOIN LOCATION ON(LOCAL_CODE = LOCATION_ID)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_CODE IN('KO','JP'); 

--8.
SELECT MAIN.EMP_NAME 사원명, MAIN.DEPT_CODE 부서코드, TEAM.EMP_NAME 동료이름
FROM EMPLOYEE MAIN
LEFT JOIN EMPLOYEE TEAM ON(MAIN.DEPT_CODE = TEAM.DEPT_CODE)
WHERE MAIN.EMP_NAME <> TEAM.EMP_NAME
ORDER BY 1 ;

--9. 
SELECT EMP_NAME 사원명, JOB_NAME, SALARY 
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE BONUS IS NULL
AND JOB_CODE IN ('J4','J7');
