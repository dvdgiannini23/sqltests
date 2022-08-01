**free

ctl-opt main(main);

dcl-proc main;
    dcl-s #rows zoned(5);
    dcl-ds #orders dim(*auto:10000) qualified;
        id zoned(5) inz;
        data varchar(250);
    end-ds;

    exec sql 
        set option commit = *none;

    // I'm going to read a table into a structure
    %elem(#orders) = 0;

    exec sql
        declare tstCursor cursor for
            select *
            from clv1.orders;
    exec sql
        open tstCursor;
    
    // Max.number of rows to load
    #rows = 10000;

    exec sql
        fetch tstCursor for :rows rows into :orders;

    exec sql
        close tstCursor;

    dsply %elem(orders);

    return;
end-proc;
