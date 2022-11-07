CREATE TABLE "ROK"."MVCBOARD" 
   (	"IDX" NUMBER(*,0) NOT NULL ENABLE, 
	"NAME" VARCHAR2(20 BYTE) NOT NULL ENABLE, 
	"SUBJECT" VARCHAR2(200 BYTE) NOT NULL ENABLE, 
	"CONTENT" VARCHAR2(3000 BYTE) NOT NULL ENABLE, 
	"GUP" NUMBER(*,0), 
	"LEV" NUMBER(*,0), 
	"SEQ" NUMBER(*,0), 
	"HIT" NUMBER(*,0) DEFAULT 0, 
	"WRITEDATE" TIMESTAMP (6) DEFAULT sysdate, 
	 CONSTRAINT "MVCBOARD_PK" PRIMARY KEY ("IDX"));
     
    delete from mvcboard;
    drop sequence mvcboard_idx_seq;
    create sequence mvcboard_idx_seq;
    
    select * from mvcboard order by idx asc;
    insert into mvcboard (idx, name, subject, content, gup, lev, seq) values (mvcboard_idx_seq.nextval,'홍길동', '1등', '1등입니다.', mvcboard_idx_seq.currval, 0, 0);
    insert into mvcboard (idx, name, subject, content, gup, lev, seq) values (mvcboard_idx_seq.nextval,'임꺽정', '2등', '2등입니다.', mvcboard_idx_seq.currval, 0, 0);
    insert into mvcboard (idx, name, subject, content, gup, lev, seq) values (mvcboard_idx_seq.nextval,'장길산', '3등', '3등입니다.', mvcboard_idx_seq.currval, 0, 0);
    insert into mvcboard (idx, name, subject, content, gup, lev, seq) values (mvcboard_idx_seq.nextval,'일지매', '4등', '4등입니다.', mvcboard_idx_seq.currval, 0, 0);
    
    select count(*) from mvcboard;
    
    commit;