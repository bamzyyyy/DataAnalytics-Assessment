#1.  Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.

# Select customers who have both savings and investment plans, along with their total deposits
SELECT
    u.id AS owner_id, # unique customer ID
    u.name, # customer name
    
    # Count of distinct savings plans (is_regular_savings = 1)
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN p.id END) AS savings_count,
    
    # Count of distinct investment plans (is_a_fund = 1)
    COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN p.id END) AS investment_count,
    
    # Total amount deposited across all plans (converted from kobo to naira)
    ROUND(SUM(s.confirmed_amount) / 100, 2) AS total_deposits
FROM savings_savingsaccount s
# Join plan table to get plan details (savings or investment)
JOIN plans_plan p ON s.plan_id = p.id
# Join user table to get customer details
JOIN users_customuser u ON s.owner_id = u.id
# Only consider confirmed deposit transactions (non-null and positive)
WHERE s.confirmed_amount IS NOT NULL AND s.confirmed_amount > 0
# Group results by customer
GROUP BY u.id, u.name
# Only include customers who have at least one savings and one investment plan
HAVING savings_count >= 1 AND investment_count >= 1
# Sort results by total deposits in descending order
ORDER BY total_deposits DESC;
