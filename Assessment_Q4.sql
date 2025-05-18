#4. For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:
# Account tenure (months since signup)
# Total transactions
# Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)
# Order by estimated CLV from highest to lowest



# Calculate transaction statistics per owner
WITH transaction_stats AS (
    SELECT
        s.owner_id,
        COUNT(*) AS total_transactions, # total number of transactions per owner
        AVG(s.confirmed_amount * 0.001) / 100 AS avg_profit_per_transaction # average profit per transaction (convert from kobo to naira)
    FROM savings_savingsaccount s
    WHERE s.confirmed_amount IS NOT NULL AND s.confirmed_amount > 0 # only consider positive confirmed amounts
    GROUP BY s.owner_id
),

# Calculate tenure (in months) for each customer
tenure AS (
    SELECT
        u.id AS customer_id,
        u.name, # customer name from users_customuser table
        TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months # number of months since customer joined until today
    FROM users_customuser u
)

# Final select to estimate Customer Lifetime Value (CLV)
SELECT
    t.customer_id,
    t.name,
    t.tenure_months,
    ts.total_transactions,
    # Estimated CLV calculated as (transactions per year * average profit per transaction), rounded to 2 decimal places
    ROUND((ts.total_transactions / NULLIF(t.tenure_months, 0)) * 12 * ts.avg_profit_per_transaction, 2) AS estimated_clv
FROM tenure t
JOIN transaction_stats ts ON t.customer_id = ts.owner_id
ORDER BY estimated_clv DESC; # Order customers by highest estimated CLV first



