--1
SELECT STUDENT_NAME, STUDENT_ADDRESS 
FROM TB_STUDENT
ORDER BY 1;

--2.
SELECT STUDENT_NAME, STUDENT_SSN 
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY 2 DESC ;

--3. 
SELECT STUDENT_NAME 학생이름, STUDENT_NO 학번, STUDENT_ADDRESS "거주지 주소"
FROM TB_STUDENT
WHERE STUDENT_NO LIKE '9%'
AND STUDENT_ADDRESS LIKE '경기도%'
OR STUDENT_ADDRESS LIKE '강원도%';

--4
SELECT PROFESSOR_NAME, PROFESSOR_SSN 
FROM TB_PROFESSOR
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '법학과'
ORDER BY 2;

--5 (뒤에 소수점 2자리까지 표시하는 방법??)
SELECT STUDENT_NO, POINT 
FROM TB_GRADE
WHERE TERM_NO = '200402'
AND CLASS_NO = 'C3118100'
ORDER BY 2 DESC ;

--6
SELECT STUDENT_NO , STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
ORDER BY 2 DESC ;

--7


