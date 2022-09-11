
BIN_LIB=CMPSYS
LIBLIST=$(BIN_LIB) CLV1
SHELL=/QOpenSys/usr/bin/qsh

all: nosql1.rpgle sqltest2.sqlrpgle sqltest3.sqlrpgle sqltest4.sqlrpgle sqltest5.sqlrpgle

%.sqlrpgle:
	system -s "CHGATR OBJ('/home/CLV/sqltests/qrpglesrc/$*.sqlrpgle') ATR(*CCSID) VALUE(1252)"
	liblist -a $(LIBLIST);\
	system "CRTSQLRPGI OBJ($(BIN_LIB)/$*) SRCSTMF('/home/CLV/sqltests/qrpglesrc/$*.sqlrpgle') COMMIT(*NONE) DBGVIEW(*SOURCE) OPTION(*EVENTF) OBJTYPE(*PGM) RPGPPOPT(*LVL2)"

%.rpgle:
	system -s "CHGATR OBJ('/home/CLV/sqltests/qrpglesrc/$*.rpgle') ATR(*CCSID) VALUE(1252)"
	liblist -a $(LIBLIST);\
	system "CRTBNDRPG PGM($(BIN_LIB)/$*) SRCSTMF('/home/CLV/sqltests/qrpglesrc/$*.rpgle') DBGVIEW(*ALL) OPTION(*EVENTF)"
