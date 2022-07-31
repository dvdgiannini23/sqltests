**free

ctl-opt main(main);

dcl-proc main;
    dcl-s text char(52);
    dcl-ds orders dim(*auto:10000) qualified;
        id zoned(5) inz;
        data varchar(250);
    end-ds;

    exec sql 
        set options commit = *none;

    // I'm going to read a table into a structure
    %elem(orders) = 0;

    exec sql
        select order_id, order_data
        into :orders
        from clv1.orders

    text = %editc(%elem(orders):'Z');

    dsply text;

    return;
end-proc;
