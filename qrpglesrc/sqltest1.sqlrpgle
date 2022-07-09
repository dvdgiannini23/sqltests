**free

ctl-opt main(main);

dcl-proc main;

    dcl-s customer char(52);

    exec sql
        set option commit = *none;
    
    exec sql
        select customer_description into :customer
        from clv1.customers
        where customer_id = 13;
    
    dsply customer;

    return;

end-proc;