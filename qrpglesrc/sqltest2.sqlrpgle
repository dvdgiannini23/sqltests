**free

dcl-s id zoned(5);
dcl-s order zoned(5);
dcl-s customer char(52);
dcl-s number zoned(5);
dcl-s z zoned(4);
dcl-s rows zoned(4);
dcl-ds data dim(*auto:1000) qualified;
    id zoned(5) inz;
    name varchar(50);
end-ds;

exec sql
    set option commit = *none;

// Looking for a record using a key
id = 26;
exec sql
    select customer_description into :customer
    from clv1.customers
    where customer_id = :id;

if sqlcod = 0;   
    dsply customer;
else;
    dsply 'Not found';
endif;

// Join of two tables
order = 5;
exec sql
    select c.customer_description into :customer
    from clv1.customers c, clv1.orders o
    where o.order_id = :order and o.customer_id = c.customer_id;
if sqlcod = 0;
    dsply customer;
else;
    dsply 'Not found';
endif;

// Counting number of records in the table
exec sql
    select count(*) into :number
    from clv1.customers;
dsply number;

// Adding data to the table
customer = 'Example!';
exec sql
    insert into clv1.customers
    values ( default , :customer);

// Retrieving data in a loop
exec sql
    declare c1 cursor for 
        select customer_id, customer_description
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
// (in this case we will not need a loop...)
%elem(data) = 0;
exec sql
    declare c2 cursor for 
        select customer_id, customer_description
        from clv1.customers;
exec sql
    open c2;

// Maximum elements to store in the data structure
rows = 1000;
exec sql
    fetch c2 for :rows rows into :data;

exec sql 
    close c2;

dsply %elem(data);


*inlr = '1';
return;

