
BIN_LIB=CMPSYS
LIBLIST=$(BIN_LIB) CLV1
SHELL=/QOpenSys/usr/bin/qsh

all: sqltest1.sqlrpgle nosql1.rpgle sqltest2.sqlrpgle

%.sqlrpgle:
	system -s "CHGATR OBJ('/home/CLV/sqltests/qrpglesrc/$*.sqlrpgle') ATR(*CCSID) VALUE(1252)"
	liblist -a $(LIBLIST);\
	system "CRTSQLRPGI OBJ($(BIN_LIB)/$*) SRCSTMF('/home/CLV/sqltests/qrpglesrc/$*.sqlrpgle') COMMIT(*NONE) DBGVIEW(*SOURCE) OPTION(*EVENTF) OBJTYPE(*PGM) RPGPPOPT(*LVL2)"

%.rpgle:
	system -s "CHGATR OBJ('/home/CLV/sqltests/qrpglesrc/$*.rpgle') ATR(*CCSID) VALUE(1252)"
	liblist -a $(LIBLIST);\
	system "CRTBNDRPG PGM($(BIN_LIB)/$*) SRCSTMF('/home/CLV/sqltests/qrpglesrc/$*.rpgle') DBGVIEW(*ALL) OPTION(*EVENTF)"
