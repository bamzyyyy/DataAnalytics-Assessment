#2. Calculate the average number of transactions per customer per month and categorize them:
#"High Frequency" (≥10 transactions/month)
# "Medium Frequency" (3-9 transactions/month)
# "Low Frequency" (≤2 transactions/month)


# Count number of transactions per customer for each month
WITH customer_monthly_tx AS (
    SELECT
        owner_id,
        DATE_FORMAT(transaction_date, '%Y-%m') AS month, # extract month from transaction date
        COUNT(*) AS monthly_tx  # count of transactions for the customer in that month
    FROM savings_savingsaccount
    WHERE transaction_date IS NOT NULL
    GROUP BY owner_id, DATE_FORMAT(transaction_date, '%Y-%m')
),

# Calculate the average number of monthly transactions per customer
customer_avg_tx AS (
    SELECT
        owner_id,
        AVG(monthly_tx) AS avg_tx_per_month
    FROM customer_monthly_tx
    GROUP BY owner_id
),

# Assign frequency categories to each customer based on their average
categorized_customers AS (
    SELECT
        owner_id,
        avg_tx_per_month,
        CASE
            WHEN avg_tx_per_month >= 10 THEN 'High Frequency'
            WHEN avg_tx_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM customer_avg_tx
)

# Aggregate the categorized data to get summary statistics
SELECT
    frequency_category,
    COUNT(*) AS customer_count, # number of customers in each category
    ROUND(AVG(avg_tx_per_month), 2) AS avg_transactions_per_month # avg monthly txns in each category
FROM categorized_customers
GROUP BY frequency_category
ORDER BY FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');





