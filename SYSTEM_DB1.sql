 create user a_user identified by 1234;
 grant create session to a_user;
 grant create table to a_user;
  grant create tablespace to a_user; 
 --권한 부여해줌 
 
 grant connect, resource to a_user;
 
 revoke create session from a_user;
 --회수: 나갔다 접속하면 거부된다. 
 
 create user B_user identified by 1234;
 grant create session to B_user;
 
 --권한부여
  grant create session to b_user with admin option;
  -- system에서 
  
  --a user권한회수 후 b user권한이 동등한지 보려고 동등관계라 접속이 된다.
  -- a 접속안됨 b 접속된다
  -- A_USER   B_USER 접속해제 시킨후 다시 재접속한다. 
  
  select * from dba_sys_privs;
  --권한에 대한 정보를 갖는 딕셔너리 
  
  /*
        오라클은 트랜잭션을 기반으로 데이터의 일관성을 보장합니다.
        트랜잭션은 데이터 처리에서 논리적으로 하나의 작업 단위를 말합니다.
        
        commit은 모든 작업들을 정상적으로 처리하겠다고 그 확정하는 명령어
        rollback은 작업 중 문제가 발생하여서 트랜잭션의 처리 과정에서 발생한 변경사항을 취소하는 명령어
  */
  
  