**free

dcl-s id zoned(5);
dcl-s order zoned(5);
dcl-s customer char(52);
dcl-s number zoned(5);

// Looking for a record using a key
id = 13;
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
customer = 'Customer 66';
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

*inlr = '1';
return;

