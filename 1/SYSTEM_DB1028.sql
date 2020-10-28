/*
사용자 생성 
create user 유저아이디 identified by 비밀번호;

create user user_id identified by password
default tablespace appl_data
temporary tablespace temp

create user user_id identified by password
default tablespace appl_data
temporary tablespace temp;
quota 20M on appl_data quota 10M on system
*/

create user user1 identified by 1234
default tablespace users
temporary tablespace temp
quota 20M on users quota 10M on system;

grant create session to user1;

/*
사용자 변경 
비밀번호 변경
alter user user1 identified by 1234;

테이블 스페이스변경
alter user user1 default tablespace test_2;

공간변경
alter user user1 quota 10 on test_1;

*/

alter user user1 identified by 1234;
alter user user1 quota 5 on users;

/*
      tkdydwk wprj
      drop user user_id;
      drop user user_id cascade;
*/

