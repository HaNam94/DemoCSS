use demoData;
select orders, customers.customer_name, customers.customer_id
from orders
join customers on customers.customer_id = orders.customer_id where customers.customer_id = 1;

select products.product_name, products.price, orders.order_id
from orders
join order_details on orders.order_id = order_details.order_id
join products on order_details.product_id = products.product_id
where orders.order_id = 1;
select sum(total_amount) from orders;
select  count(order_id) as 'SLL_DH', avg(total_amount) as 'amount_avg_order'
from orders
