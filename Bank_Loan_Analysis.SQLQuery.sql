select * from financial_loan

--Total Loan Application
select COUNT(id) as Total_loan_Application from financial_loan

--MTD Loan Application
select COUNT(id) as MTD_Total_Application from financial_loan
where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021

--PMTD Loan Application
select COUNT(id) as PMTD_Total_Application from financial_loan
where MONTH(issue_date) = 11 and YEAR(issue_date) = 2021

--Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM financial_loan

--(MTD -PMTD)/PMTD
--MTD Funded Amount
select SUM(loan_amount) as MTD_Total_funded_amount from financial_loan
where month(issue_date) = 12 and year(issue_date) = 2021

--PMTD Funded Amount
select SUM(loan_amount) as PMTD_Total_funded_amount from financial_loan
where month(issue_date) = 11 and year(issue_date) = 2021

--Total Amount Recieved
SELECT SUM(total_payment) AS Total_Amount_Collected FROM financial_loan

--MTD Amount Recieved
select SUM(total_payment) as MTD_Total_amount_recieved from financial_loan
where month(issue_date) = 12 and year(issue_date) = 2021

--PMTD Amount Recieved
select SUM(total_payment) as PMTD_Total_amount_recieved from financial_loan
where month(issue_date) = 11 and year(issue_date) = 2021

--Total Average Interest 
select round(avg(int_rate),4) * 100 as Avg_interest_rate from financial_loan

--MTD Average Interest 
select round(avg(int_rate),4) * 100 as MTD_Avg_interest_rate from financial_loan
where month(issue_date) = 12 and year(issue_date) = 2021

--PMTD Average Interest
select round(avg(int_rate),4) * 100 as PMTD_Avg_interest_rate from financial_loan
where month(issue_date) = 11 and year(issue_date) = 2021

--Average DTI
select round(AVG(dti),4) * 100 as Avg_DTI from financial_loan

--MTD Average DTI
select round(AVG(dti),4) * 100 as MTD_Avg_DTI from financial_loan
where month(issue_date) = 12 and year(issue_date) = 2021

--PMTD Average DTI
select round(AVG(dti),4) * 100 as PMTD_Avg_DTI from financial_loan
where month(issue_date) = 11 and year(issue_date) = 2021

--Good Loan percentage
select (count(case when loan_status = 'Fully Paid' or loan_status = 'current' then id end)* 100)
        /
		count(id) as good_loan_percentage
from financial_loan

--Good Loan Application
select COUNT(id) as good_loan_application from financial_loan
where loan_status = 'Fully Paid' or loan_status = 'Current'

--Good Loan funded amount
select sum(loan_amount) as good_funded_amount from financial_loan
where loan_status = 'Fully Paid' or loan_status = 'Current'

--Good Loan amount recieved
select sum(total_payment) as good_loan_total_amount_recieved from financial_loan
where loan_status = 'Fully Paid' or loan_status = 'Current'

-- Bad Loan percentage

select round((count(case when loan_status = 'Charged Off' then id end)*100)
       /
	   count(id),6)as Bad_Loan_Application
from financial_loan

--Bad loan applications
select COUNT(id) as Bad_Loan_Applications from financial_loan
where loan_status = 'charged off'

-- Bad loan funded amount
select sum(loan_amount) as Bad_Loan_funded_amount from financial_loan
where loan_status = 'charged off'

-- bad loan amount recieved
select sum(total_payment) as Bad_Loan_amount_recieved from financial_loan
where loan_status = 'charged off'

-- Loan status grid view

select
      loan_status,
	  count(id) as Total_Loan_applications,
	  sum(total_payment) as Total_payment_recieved,
	  sum(loan_amount) as total_loan_funded_amount,
	  avg(int_rate * 100) as Avg_interest_rate,
	  avg(dti * 100) as avg_dti
   from financial_loan
      group by loan_status


select
      loan_status,
	  sum(total_payment) as MTD_Total_payment_recieved,
	  sum(loan_amount) as MTD_total_loan_funded_amount
	  from financial_loan
	  where MONTH(issue_date) = 12
      group by loan_status

 -- month

select
      MONTH(issue_date) as month_number,
      DATENAME (month, issue_date) as month_name,
	  count(id) as total_applications,
	  sum(loan_amount) as total_funded_amount,
	  sum(total_Payment) as total_amount_recieved
from financial_loan
group by DATENAME (month, issue_date), MONTH(issue_date)
order by MONTH(issue_date)

-- state
select
      address_state,
      count(id) as total_applications,
	  sum(loan_amount) as total_funded_amount,
	  sum(total_Payment) as total_amount_recieved
from financial_loan
group by address_state
order by sum(loan_amount) desc

--term
select 
      term,
      count(id) as total_applications,
	  sum(loan_amount) as total_funded_amount,
	  sum(total_Payment) as total_amount_recieved
from financial_loan
group by term
order by term

--employee length
select 
      emp_length,
      count(id) as total_applications,
	  sum(loan_amount) as total_funded_amount,
	  sum(total_Payment) as total_amount_recieved
from financial_loan
group by emp_length
order by count(id) desc

--purpose
select 
      purpose,
      count(id) as total_applications,
	  sum(loan_amount) as total_funded_amount,
	  sum(total_Payment) as total_amount_recieved
from financial_loan
group by purpose
order by count(id) desc

-- home ownership
select 
      home_ownership,
      count(id) as total_applications,
	  sum(loan_amount) as total_funded_amount,
	  sum(total_Payment) as total_amount_recieved
from financial_loan
group by home_ownership
order by count(id) desc

-- applying filters
select 
      home_ownership,
      count(id) as total_applications,
	  sum(loan_amount) as total_funded_amount,
	  sum(total_Payment) as total_amount_recieved
from financial_loan
where grade ='A' and address_state = 'CA'
group by home_ownership
order by count(id) desc



