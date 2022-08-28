**free

dcl-s id zoned(5);
dcl-s order zoned(5);
dcl-s customer char(52);
dcl-s number zoned(5);
dcl-s z zoned(4);
dcl-ds data dim(*auto:1000) qualified;
    id zoned(5) inz;
    name varchar(50);
end-ds;

exec sql
    set option commit = *none;

// Looking for a record using a key
id = 26;

exec sql
    select descrip into :customer
    from clv1.customers
    where id = :id;
if sqlcod = 0;
    dsply customer;
else;
    dsply 'Not found';
endif;

// Join of two tables
// I have the order number, and I want the name of the customer
order = 5;
exec sql
    select c.descrip into :customer
    from clv1.customers c, clv1.orders o
    where o.order_id = :order and
        o.customer_id = c.id;
if sqlcod = 0;
    dsply customer;
else;
    dsply 'Not found';
endif;


// Counting number of records in the table
number = 0;
exec sql
    select count(*) into :number
    from clv1.customers;
dsply number;

// Adding data to the table
customer = 'Example';
exec sql
    insert into clv1.customers
    values ( default, :customer);

// Retrieving data in a loop
exec sql
    declare c1 cursor for
        select id, descrip 
        from clv1.customers;
exec sql
    open c1;

dou sqlcod <> 0;
    exec sql
        fetch c1 into :id, :customer;
    if sqlcod <> 0;
        leave;
    endif;
    dsply id;
    dsply customer;
enddo;

exec sql
    close c1;

// Retrieving data in a loop and storing into a data structure
%elem(data) = 0;
exec sql
    declare c2 cursor for
        select id, descrip 
        from clv1.customers;
exec sql
    open c2;

rows = 1000;
exec sql
    fetch c2 for :rows rows into :data;

exec sql
    close c2;

dsply %elem(data);

*inlr = '1';
return;
