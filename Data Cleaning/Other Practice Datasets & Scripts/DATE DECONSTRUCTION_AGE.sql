--selects/extracts month from each date in column date_opened
--since the date is formatted as numerical, the output is also numerical rep of month (feb=2)
SELECT *, DATE_PART('month', date_opened) AS month_opened
FROM account;

--Extracts and count the instances of months from coulumn date_opened, and sorts it by number of accts_opened in descending manner
SELECT DATE_PART('month',date_opened) AS month_opened, COUNT (*) AS num_accts_opened
FROM account
GROUP BY month_opened
ORDER BY num_accts_opened DESC;


--counts the number of days from account creation
SELECT *, (COALESCE(date_closed, NOW())-date_opened) AS AgeOfAccount
FROM account;


--converts result from previous example as years, months and days
SELECT *,
AGE(COALESCE(date_closed, NOW()),date_opened) AS AgeOfAccount
FROM account;