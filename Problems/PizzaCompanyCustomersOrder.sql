create schema PizzaCompanyCustomerTable;
use PizzaCompanyCustomerTable;
create table customer_orders(cust_name varchar(20),order_id varchar(10),status varchar(50));
insert into customer_orders values('John','J1','DELIVERED'),('John','J2','DELIVERED'),
('David','D1','DELIVERED'),('David','D3','CREATED')
,('Smith','S1','SUBMITTED'),('KRISH','K1','CREATED');
SELECT * FROM customer_orders;
select cust_name,
  case
    when sum(case when status = 'DELIVERED' then 1 else 0 end) = count(*) then 'COMPLETED'
    when sum(case when status = 'DELIVERED' then 1 else 0 end) > 0 and sum(case when status in ('CREATED', 'SUBMITTED') then 1 else 0 end) > 0 then 'IN PROGRESS'
    when SUM(case when status = 'SUBMITTED' then 1 else 0 end) > 0 and sum(case when status <> 'DELIVERED' then 1 else 0 end) = count(*) then 'AWAITING PROGRESS'
    else 'AWAITING SUBMISSION'
  end as final_status
from customer_orders
group by cust_name;


/*
SELECT * FROM customer_orders;
select cust_name,
CASE
   when status='DELIVERED'  then 'COMPLETED'
   when  status='DELIVERED' and status!='CREATED' THEN 'IN PROGRESS'
   when status='SUBMITTED' and status!='DELIVERED' THEN 'AWAITING PROGRESS'
 else 'AWAITING SUBMISSION'
end as FINAL_STATUS
FROM customer_orders group by cust_name order by cust_name;
*/