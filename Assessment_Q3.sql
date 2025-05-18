#3. Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days) .

# The most recent transaction date for each plan
WITH last_tx_per_plan AS (
    SELECT
        plan_id,
        MAX(transaction_date) AS last_transaction_date # get the latest transaction date per plan
    FROM savings_savingsaccount
    GROUP BY plan_id
),

# Identifying the active savings and investment plans along with their last transaction dates
active_plans AS (
    SELECT
        p.id AS plan_id,
        p.owner_id,
        # Categorize the plan type based on flags
        CASE
            WHEN p.is_regular_savings = 1 THEN 'Savings'
            WHEN p.is_a_fund = 1 THEN 'Investment'
            ELSE 'Other'
        END AS type,
        l.last_transaction_date
    FROM plans_plan p
    LEFT JOIN last_tx_per_plan l ON p.id = l.plan_id # attach last transaction date
    WHERE 
        # Include only regular savings or investment plans
        (p.is_regular_savings = 1 OR p.is_a_fund = 1)
        # Exclude archived plans unless the archived flag is NULL
        AND (p.is_archived = 0 OR p.is_archived IS NULL)
        # Exclude deleted plans unless the deleted flag is NULL
        AND (p.is_deleted = 0 OR p.is_deleted IS NULL)
)

# Then Select plans that have been inactive for over a year or have no transactions
SELECT
    plan_id,
    owner_id,
    type,
    DATE_FORMAT(last_transaction_date, '%Y-%m-%d') AS last_transaction_date, # format the date as YYYY-MM-DD
    DATEDIFF(CURDATE(), last_transaction_date) AS inactivity_days # calculate days since last transaction
FROM active_plans
# Filtering Include plans with no transaction date or with inactivity over 365 days
WHERE last_transaction_date IS NULL
   OR DATEDIFF(CURDATE(), last_transaction_date) > 365
ORDER BY inactivity_days DESC; -- sort with most inactive plans first
