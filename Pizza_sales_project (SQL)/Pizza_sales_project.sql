-- Determine los 3 tipos de pizza más pedidos en función de los ingresos de cada categoría de pizza.

select category, name, revenue 
from
(select category, name, revenue,
rank() over(partition by category order by revenue DESC) as rn
from
(select pizza_types.category, pizza_types.name,
sum((order_details.quantity) * pizzas.price) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category, pizza_types.name) as A) as B
where rn <= 3;
