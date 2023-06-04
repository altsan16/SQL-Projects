/* Codes for the Dimensional Data Model */

/* The succeeding line of codes creates extra tables with values derived from the original table
rate_report to mirror the dimensional model
The following may also be achieved by using VIEW function*/

--EducationLevel_Dim 
CREATE TABLE public.educationlevel_dim
(
    ed_level_id integer,
    level_of_education character varying
);
INSERT INTO educationlevel_dim
SELECT ed_level_id, level_of_education
FROM rate_report
GROUP BY ed_level_id,  level_of_education
ORDER BY ed_level_id
-- VERIFY OUTPUT TABLE USING:
SELECT * FROM educationlevel_dim



--Location_Dim
CREATE TABLE public.loc_dim
(
    loc_key integer,
    geolocation character varying
);
INSERT INTO loc_dim
SELECT case when geolocation ='Philippines' then 1 end as loc_key,
		geolocation
FROM rate_report
GROUP BY loc_key,  geolocation
ORDER BY loc_key
-- VERIFY OUTPUT TABLE USING:
SELECT * FROM loc_dim;



--Time_Dim
CREATE TABLE public.time_dim
(
    "year" character varying
);
INSERT INTO time_dim
SELECT * FROM
		(SELECT column_name as year
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE table_name = 'rate_report') y
WHERE 	y.year != 'rate_type' and y.year != 'ed_level_id' and y.year != 'sex'
		and y.year != 'geolocation' and y.year != 'level_of_education';

ALTER TABLE time_dim ADD COLUMN time_key SERIAL;

-- VERIFY OUTPUT TABLE USING:
SELECT time_key, year FROM time_dim;



--Group_Dim
CREATE TABLE public.grp_dim
(
    grp_key integer,
    sex character varying
);
INSERT INTO grp_dim
SELECT case 
			when sex='Male' then 1
			when sex='Female' then 2
			when sex='Both Sexes' then 3
			end as grp_key,
			sex
FROM rate_report
group by grp_key,  sex
ORDER BY grp_key
-- VERIFY OUTPUT TABLE USING:
SELECT * FROM grp_dim;



--Rate_Type_Dim
CREATE TABLE public.rtype_dim
(rate_type integer,rate_type_r character varying);
INSERT INTO rtype_dim
SELECT rate_type, 
				case when rate_type='1' then 'completion_rate'
					 when rate_type='2' then 'dropout_rate'
					 end as rate_type_r
FROM rate_report
group by rate_type, rate_type_r
ORDER BY rate_type;
-- VERIFY OUTPUT TABLE USING:
SELECT * FROM rtype_dim;



--Fact Table Rate Report
CREATE TABLE public.rate_report_fact
(ed_level_id integer,loc_key integer, time_key integer, group_key integer, rate_type integer);
INSERT INTO rate_report_fact
SELECT a.ed_level_id AS ed_level_id, b.loc_key AS loc_key, c.time_key AS time_key, d.grp_key AS group_key, e.rate_type  AS rate_type
		FROM educationlevel_dim a
LEFT JOIN loc_dim b ON b.loc_key=a.ed_level_id
RIGHT JOIN time_dim c ON c.time_key=a.ed_level_id
LEFT JOIN grp_dim d ON d.grp_key=a.ed_level_id
LEFT JOIN rtype_dim e ON e.rate_type=a.ed_level_id
-- VERIFY OUTPUT TABLE USING:
SELECT * FROM rate_report_fact