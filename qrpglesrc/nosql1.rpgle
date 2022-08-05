**free

dcl-f customers usage(*input:*output)
    extdesc('CLV1/CUSTOMERS')
    extfile(*extdesc)
    keyed prefix(c_);

dcl-f orders usage(*input)
    extdesc('CLV1/ORDERS')
    extfile(*extdesc)
    keyed prefix(o_);

dcl-s id zoned(5);
dcl-s order zoned(5);
dcl-s customer char(52);
dcl-s number zoned(5);
dcl-ds data dim(*auto:1000) qualified;
    id zoned(5) inz;
    name varchar(50);
end-ds;

// Looking for a record using a key
id = 26;
chain id rcustomers;
if %found;
    customer = c_descrip;
    dsply customer;
else;
    dsply 'Not found';
endif;

// Join of two tables
order = 5;
chain order rorders;
if %found;
    chain o_customerid rcustomers;
    if %found;
        customer = c_descrip;
        dsply customer;
    else;
        dsply 'Customer not found';
    endif;
else;
    dsply 'Order not found';
endif;

// Counting number of records in the table
number = 0;
setll *loval rcustomers;
dou %eof(CUSTOMERS);
    read rcustomers;
    if not %eof(CUSTOMERS);
        number += 1;
    endif;
enddo;
dsply number;

// Adding data to the table
clear *all rcustomers;
c_descrip = 'Example!';
write rcustomers;

// Retrieving data in a loop
setll *loval rcustomers;
dou %eof(CUSTOMERS);
    read rcustomers;
    if not %eof(CUSTOMERS);
        dsply c_id;
        dsply c_descrip;
    endif;
enddo;

// Retrieving data in a loop and storing into a data structure
%elem(data) = 0;
setll *loval rcustomers;
dou %eof(CUSTOMERS);
    read rcustomers;
    if not %eof(CUSTOMERS);
        z = %elem(data);
        z += 1;
        data(z).id = c_id;
        data(z).name = c_descrip;
    endif;
enddo;
dsply %elem(z);

*inlr = '1';
return;
