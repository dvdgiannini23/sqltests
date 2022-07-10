**free

ctl-opt main(main);

dcl-proc main;

    dcl-s data char(300);

    exec sql
        set option commit = *none;
        
    exec sql
        select data_area_value 
        into :data
        from table(qsys2.data_area_info(
            data_area_name => 'TEST',
            data_area_library => 'CLV1'
        ));

    return;

end-proc;