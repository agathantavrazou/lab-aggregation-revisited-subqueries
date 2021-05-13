select first_name, last_name, email from customer
where active = 0;

select c.customer_id, concat(c.first_name, " ", c.last_name) as customer_name,  avg(p.amount) from customer c
join payment p on c.customer_id = p.customer_id
group by c.customer_id;

-- Select the name and email address of all the customers who have rented the "Action" movies.
--- Write the query using multiple join statements
select concat(c.first_name, " ", c.last_name), c.email from customer c
join rental r on c.customer_id = r.customer_id
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
join film_category fc on f.film_id = fc.film_id
join category cat on fc.category_id = cat.category_id
where cat.name = "Action";

-- Write the query using sub queries with multiple WHERE clause and IN condition
select film_id from film_category where category_id in (select name = "Action" from category);
select inventory_id from inventory where film_id in (select film_id from film_category where category_id in (select name = "Action" from category));
select customer_id from rental where inventory_id in (select inventory_id from inventory where film_id in (select film_id from film_category where category_id in (select name = "Action" from category)));
select concat(first_name, " ", last_name), email from customer where customer_id in (select customer_id from rental where inventory_id in (select inventory_id from inventory where film_id in (select film_id from film_category where category_id in (select name = "Action" from category))));

-- Verify if the above two queries produce the same results or not
-- So far so good

-- Use the case statement to create a new column classifying existing columns as:
-- either or high value transactions based on the amount of payment. 
-- If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, 
-- and if it is more than 4, then it should be high.
select *, 
case when amount <= 2 then "low"
when 2 < amount <= 4 then "medium"
when amount> 4 then "high"
end as amount_clasif from payment;

