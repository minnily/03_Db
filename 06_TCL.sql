-- TCL(Transaction Control Language) :트랜잭션 제어 언어
-- COMMIT(트랜잭션 종료 후 저장), ROLLBACK(트랜잭션 취소), SAVEPOINT(임시저장)

-- DML : 데이터 조작 언어로 데이터의 삽입, 수정, 삭제
--> 트랜잭션은 DML과 관련되어 있음

/*[TRANSACTION 이란? ]
 * - 데이터베이스의 논리적 연산 단위
 * - 데이터 변경 사항을 묶어서 하나의 트랜잭션에 담아 처리함.
 * - 트랜잭션의 대상이 되는 데이터 변경 사항 : INSERT, UPDATE, DELETE, MERGE
 * 
 * INSERT수행을 한다고 해서 바로 DB에 반영되는 것은 아니며, 중간에 트랜잭션에 저장(추가)되는 것이다!
 * 만약, PCL중에 COMMIT을 수행한다면 그때는 실제로 DB에 반영이 된다.
 * 예를 들어 INSERT 10번을 수행한 경우 1개의 트랜잭션에 10개가 추가되는 것이고 ROLLBACK을 하는 경우에는
 * 트랜잭션에 추가된 10개가 모두 사라지면서 DB에 반영이 되지 않는다~!
 * 
 * 
 * 1) COMMIT : 메모리 버퍼(==트랜잭션)에 임시 저장된 데이터 변경 사항을 실제로 DB에 반영한다.
 * 
 * 2) ROLLBACK : 메모리 버퍼(== 트랜잭션)에 임시 저장된 데이터 변경 사항을 삭제하고 
 * 								마지막 COMMIT 사항으로 돌아가는 것이다. (DB에 변경 내용을 반영하지 않는 것!)
 * 
 * 3) SAVEPOINT : 메모리 버퍼(==트랜잭션)에 저장 지점을 정의하여 ROLLBACK 수행 시 전체 작업을 삭제하는 것이 아닌
 * 								저장 지점까지만 일부 ROLLBACK 할 수 있게 하는 것이다.
 * 
 * [SAVEPOINT 사용법]
 * 
 * ...
 * SAVEPOINT "포인트명1";
 * 
 *  ...
 * SAVEPOINT "포인트명2";
 * 
 * ...
 * ROLLBACK TO "포인트명1"; -- 포인트1 지점까지 데이터 변경사항이 삭제됨!
 * 
 * [유의사항]
 * SAVEPOINT 지정 및 호출 시 이름에 ""(쌍따옴표)를 꼭 붙여야한다!!
 * "" 쌍따옴표가 없으면 지정되지 않아서 전체 ROLLBACK이 된다.....! 유의하기..!!
 * */


-- 새로운 데이터 INSERT 
SELECT * FROM DEPARTMENT2;

INSERT INTO DEPARTMENT2 VALUES('T1','개발1팀', 'L2');
INSERT INTO DEPARTMENT2 VALUES('T2','개발2팀', 'L2');
INSERT INTO DEPARTMENT2 VALUES('T3','개발3팀', 'L2');

-- 마우스로 여러범위 지정후 ALT+ X => 범위로 수행됨!

--INSERT 확인
SELECT * FROM DEPARTMENT2;

--> DB에 반영된 것 처럼 보이지만 실제로 아직 DB에 반영된 것은 아님!
--> SQL 수행 시 트랜잭션 내용도 포함해서 수행된다.

-- ROLLBACK 후 확인
ROLLBACK;
--ROLLBACK 후 DB에 반영되었는지 INSERT 확인!
SELECT * FROM DEPARTMENT2;


--COMMIT 후 ROLLBACK이 되는지 확인
INSERT INTO DEPARTMENT2 VALUES('T1','개발1팀', 'L2');
INSERT INTO DEPARTMENT2 VALUES('T2','개발2팀', 'L2');
INSERT INTO DEPARTMENT2 VALUES('T3','개발3팀', 'L2');

SELECT * FROM DEPARTMENT2;

COMMIT;

ROLLBACK;
--ROLLBACK 후 DB에 반영되었는지 INSERT 확인!
SELECT * FROM DEPARTMENT2;-- 롤백이 안됨 WHY? DB에 이미 반영이 되었기 때문



--------------------------------------------------------------------


--SAVEPOINT 확인
INSERT INTO DEPARTMENT2 VALUES('T4','개발4팀', 'L2');
SAVEPOINT "SP1"; -- SAVEPOINT 지정

INSERT INTO DEPARTMENT2 VALUES('T5','개발5팀', 'L2');
SAVEPOINT "SP2"; -- SAVEPOINT 지정

INSERT INTO DEPARTMENT2 VALUES('T6','개발6팀', 'L2');
SAVEPOINT "SP3"; -- SAVEPOINT 지정

ROLLBACK TO "SP1";

SELECT * FROM DEPARTMENT2;

-- ROLLBACK TO "SP1" 구문 수행 시 SP2, SP3도 삭제됨.

ROLLBACK TO "SP2";
--ORA-01086: 'SP2' 저장점이 이 세션에 설정되지 않았거나 부적합합니다.
-- 이미 삭제가되었기에 에러 발생!


INSERT INTO DEPARTMENT2 VALUES('T5','개발5팀', 'L2');
SAVEPOINT "SP2"; -- SAVEPOINT 지정

INSERT INTO DEPARTMENT2 VALUES('T6','개발6팀', 'L2');
SAVEPOINT "SP3"; -- SAVEPOINT 지정


SELECT * FROM DEPARTMENT2;

-- 개발팀 전체 삭제해보기
DELETE FROM DEPARTMENT2
WHERE DEPT_ID LIKE 'T%';

SELECT  *FROM DEPARTMENT2;
--> 현재 삭제가 되었지만 그렇게 보이는 것일 뿐 DB안에는 실제로 있는 상태이다. 

--SP2 지점까지 롤백
ROLLBACK TO "SP2";


SELECT * FROM DEPARTMENT2; -- 개발6팀만 롤백

--SP1 지점까지 롤백
ROLLBACK TO "SP1";

SELECT * FROM DEPARTMENT2; -- 개발5팀만 롤백

-- 롤백 수행
ROLLBACK;
SELECT * FROM DEPARTMENT2;-- 개발4팀까지 롤백 (개발1팀, 2팀, 3팀만 남음)







