/* Resolved Questions and Solutions

Today, I am excited to present a glimpse into my expertise as a data analyst by sharing a selection of resolved data analysis questions I have recently tackled. 
These examples are intended to showcase my problem-solving skills and demonstrate the breadth of my capabilities in the field of data analysis. */

--- 1- Find the 3 most profitable companies in the entire world.

SELECT * FROM forbes_global_2010_2014
ORDER BY profits DESC
LIMIT 3;

/* 2- Find the highest target achieved by the employee or employees who works under the manager id 13. 
Output the first name of the employee and target achieved. The solution should show the highest target achieved under manager_id=13 and which employee(s) achieved it.*/

SELECT
    first_name,
    target
FROM salesforce_employees
WHERE manager_id = 13
AND target = (SELECT MAX(target) FROM salesforce_employees WHERE manager_id = 13);


/* 3- Find the total number of downloads for paying and non-paying users by date. Include only records where non-paying customers have more downloads than paying customers. 
The output should be sorted by earliest date first and contain 3 columns date, non-paying downloads, paying downloads. */

SELECT
    date,
    SUM(IF(paying_customer = 'no', downloads, 0)) AS non_payin,
    SUM(IF(paying_customer = 'yes', downloads, 0)) AS paying
FROM ms_user_dimension
LEFT JOIN ms_acc_dimension
    USING(acc_id)
LEFT JOIN ms_download_facts
    USING(user_id)
GROUP BY date
HAVING non_payin > paying
 ORDER BY date ASC;
 
 /* 4- Classify each business as either a restaurant, cafe, school, or other.

•	A restaurant should have the word 'restaurant' in the business name.
•	A cafe should have either 'cafe', 'café', or 'coffee' in the business name.
•	A school should have the word 'school' in the business name.
•	All other businesses should be classified as 'other'.

Output the business name and their classification. */
 
 SELECT 
    DISTINCT business_name,
    CASE
        WHEN business_name LIKE "%restaurant%" THEN "restaurant"
        WHEN business_name LIKE  "%cafe%"
            OR business_name LIKE "%café%"
            OR business_name LIKE "%coffee%" 
            THEN "cafe"
        WHEN business_name LIKE "%school%" THEN "school"
        ELSE "other"
        END "classification"
FROM sf_restaurant_health_violations;

/* 5- Calculate the total revenue from each customer in March 2019. Include only customers who were active in March 2019.
Output the revenue along with the customer id and sort the results based on the revenue in descending order. */

SELECT 
    cust_id,
    SUM(total_order_cost) AS total_order_cost
FROM orders
WHERE year(order_date) = 2019 AND MONTH(order_date) = 3
GROUP BY cust_id
ORDER BY total_order_cost DESC;
