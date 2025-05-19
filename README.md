<a name="readme-top"></a>

<div align="center"> <h1><b>SQL PROFICIENCY ASSESSMENT</b></h1> <p>A structured evaluation of relational database query skills using real-world business scenarios.</p> </div>

## 🧾 Overview

This repository presents solutions to the Data Analyst Assessment designed to test SQL proficiency across various real-life business tasks such as identifying customer behavior patterns, segmenting users, and estimating customer lifetime value. The dataset includes four main tables:

`users_customuser`: Customer demographic and contact details.

`savings_savingsaccount`: Records of deposit transactions.

`plans_plan`: Records of customer-created plans.

`withdrawals_withdrawal`: Withdrawal transaction logs.

The focus areas of this assessment include:

- Accurate data retrieval using joins and subqueries.

- Efficient query structuring.

- Interpretation and transformation of business problems into SQL.

- Properly formatted and readable SQL code.

All solutions are documented with clear logic and methodology in the respective .sql files.


## 🧠 Topical Questions and Methodology


#### 1️⃣  High-Value Customers with Multiple Products

Problem: Identify customers who have both a funded savings plan and an investment plan. This helps in understanding cross-sell opportunities.

Approach:
We performed joins between the users_customuser, savings_savingsaccount, and plans_plan tables. The query filters for users with:

At least one savings account with is_regular_savings = 1

At least one investment plan with is_a_fund = 1

We used aggregation functions to count the number of savings and investment products and calculated the total confirmed deposits (converted from kobo to naira). Final results were sorted by total deposits in descending order to highlight high-value users.

<img width="827" alt="Screenshot 2025-05-19 at 4 47 59 AM" src="https://github.com/user-attachments/assets/13db39da-830a-43e4-bdd2-12f6019617e2" />



### 2️⃣  Transaction Frequency Analysis

Problem: Segment customers based on their monthly transaction frequency.

Approach:
We calculated the total number of deposit transactions per customer and normalized this by the number of months since the first recorded transaction to get the average monthly frequency. Each customer was categorized into:

High Frequency (≥10 transactions/month)

Medium Frequency (3–9 transactions/month)

Low Frequency (≤2 transactions/month)

The final result shows customer count per segment and the average transaction frequency per category.


<img width="831" alt="Screenshot 2025-05-19 at 4 51 55 AM" src="https://github.com/user-attachments/assets/b71a3bfd-046b-4ec7-bd4a-2d7290c6681f" />


### 3️⃣  Account Inactivity Alert

Problem: Identify all savings or investment accounts that have not had any inflow for over 365 days.

Approach:
We used the savings_savingsaccount and plans_plan tables and computed the difference between the current date and the latest transaction date for each account. Accounts were filtered where inactivity exceeded one year. The output includes:

Account type (Savings/Investment)

Date of last transaction

Days since last inflow

This is vital for operations to prompt re-engagement or consider account dormancy actions.

<img width="912" alt="Screenshot 2025-05-19 at 4 53 55 AM" src="https://github.com/user-attachments/assets/cc2b20c5-1112-4dbb-a2f6-4efcad766206" />




### 4️⃣  Customer Lifetime Value (CLV) Estimation

Problem: Estimate a simplified version of CLV based on transaction volume and tenure.

Approach:
Tenure was calculated as the number of months between the customer signup date and the current date.
Total transactions were aggregated from the savings_savingsaccount table.
We assumed profit_per_transaction = 0.1% of the transaction amount.
The formula used was:


```sh
CLV = (total_transactions / tenure_months) * 12 * average_profit_per_transaction
```
This output helps marketing teams prioritize top-tier customers based on value.
<img width="1144" alt="Screenshot 2025-05-19 at 5 01 33 AM" src="https://github.com/user-attachments/assets/d9c77388-a8e9-46c3-a126-aa13d8518e80" />



🗃️ Key Files

```sh
DataAnalytics-Assessment/
│
├── Assessment_Q1.sql             # High-Value Customers with Multiple Products
├── Assessment_Q2.sql             # Transaction Frequency Analysis
├── Assessment_Q3.sql             # Account Inactivity Alert
├── Assessment_Q4.sql             # Customer Lifetime Value Estimation
└── README.md                     # This file
```

Each SQL file contains:

- One query

- Indentation for readability

- Comments for clarity on complex logic

## ⚙️ Tools Used:

- SQL (MYSQL)

- Relational database concepts

- Joins, subqueries, CASE statements, aggregate functions

- Date and time manipulation

## 💡 Challenges Encountered
- Ensuring unit conversions from kobo to naira were handled accurately across queries.

- Handling missing or NULL transaction dates using IS NULL and careful filtering to avoid skewed inactivity detection.

- Normalizing transaction frequency per customer required careful handling of edge cases with short tenure.

## ✅ Evaluation Criteria

- The queries were written to meet the following evaluation benchmarks:

- Accuracy: Matching expected outputs and edge cases

- Efficiency: Use of indexes, avoiding nested subqueries where unnecessary

- Completeness: Every question fully answered

- Readability: Logical structure, comments, and consistent formatting


<!-- AUTHORS -->

## 👥 Authors <a name="authors"></a>

- 🕵🏽‍♀️ **Aminu Oluwarotimi Desmond**                  [GitHub Profile](https://github.com/bamzyyyy?tab=repositories)


<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTRIBUTING -->

## 🤝 Contributing <a name="contributing"></a>

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](../../issues/).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- SUPPORT -->

## ⭐️ Show your support <a name="support"></a>

If you like this project kindly show some love, give it a 🌟 **STAR** 🌟

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ACKNOWLEDGEMENTS -->

## 🙏 Acknowledgments <a name="acknowledgements"></a>

We acknowledge the Cowrywise team for providing data for me to deliver this real-life project and earn a spot in their firm.

<!-- LICENSE -->

## 📝 License <a name="license"></a>

This project is [MIT](./LICENSE) licensed.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
