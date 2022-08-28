**free

ctl-opt main(main);

dcl-proc main;

    dcl-s #library char(10);
    dcl-s #file char(10);
    dcl-s #job_name varchar(50);

    exec sql
        set option commit = *none;

    #library = 'CLV1';
    #file = 'ORDERS';

    exec sql
        select job_name into :#job_name
        from qsys2.object_lock_info
        where system_object_schema = :#library and
            system_object_name = :#file and
            object_type = '*FILE';

    if #job_name <> *blanks;
        dsply 'Locked!';
    endif;

    return;

end-proc;