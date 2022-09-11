**free

ctl-opt main(main) dftactgrp(*no);

dcl-proc main;

    dcl-s #program char(10) inz('TEST21');

    exec sql
        set option commit = *none;

    if anyJobRunning(#program);
        dsply 'The program is running...';
    endif;

    if anyJobwithMsgw();
        dsply 'There are jobs with MSGW status...';
    endif;

    return;

end-proc;

dcl-proc anyJobRunning;

    dcl-pi *n ind;
        #program char(10) const;
    end-pi;

    dcl-s #number zoned(5) inz(0);

    exec sql
        select count(*) into :#number
        from table(qsys2.active_job_info (
            detailed_info =>'NONE'
        ))
        where function = :#program;

    return (#number > 0);

end-proc;

dcl-proc anyJobwithMsgw;

    dcl-pi *n ind;
    end-pi;

    dcl-s #number zoned(5) inz(0);

    exec sql
        select count(*) into :#number
        from table(qsys2.active_job_info (
            detailed_info =>'NONE'
        ))
        where job_status = 'MSGW';

    return (#number > 0);

end-proc;