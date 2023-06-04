-- CREATE initial table
CREATE TABLE IF NOT EXISTS public.drp_rate
(
    geolocation character varying COLLATE pg_catalog."default",
    level_of_education character varying COLLATE pg_catalog."default",
    sex character varying COLLATE pg_catalog."default",
    "2000" text COLLATE pg_catalog."default",
    "2001" text COLLATE pg_catalog."default",
    "2002" text COLLATE pg_catalog."default",
    "2003" text COLLATE pg_catalog."default",
    "2004" text COLLATE pg_catalog."default",
    "2005" text COLLATE pg_catalog."default",
    "2006" text COLLATE pg_catalog."default",
    "2007" text COLLATE pg_catalog."default",
    "2008" text COLLATE pg_catalog."default",
    "2009" text COLLATE pg_catalog."default",
    "2010" text COLLATE pg_catalog."default",
    "2011" text COLLATE pg_catalog."default",
    "2012" text COLLATE pg_catalog."default",
    "2013" text COLLATE pg_catalog."default",
    "2014" text COLLATE pg_catalog."default",
    "2015" text COLLATE pg_catalog."default",
    "2016" text COLLATE pg_catalog."default",
    "2017" text COLLATE pg_catalog."default",
    "2018" text COLLATE pg_catalog."default",
    "2019" text COLLATE pg_catalog."default",
    "2020" text COLLATE pg_catalog."default",
    "2021" text COLLATE pg_catalog."default",
    "2022" text COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.drp_rate
    OWNER to postgres;
	
	
--used pgAdmin to IMPORT dataset from csv

SELECT * FROM drp_rate;

--used DELETE function because I forgot to indicate that there is a header, hence first row repetitively reflected the column names
DELETE FROM drp_rate where geolocation='"Geolocation';

/* The succeeding codes are used to clean the entries in each column where unwanted symbols are seen from the the first run of
SELECT function */
update drp_rate
set geolocation = 'Philippines'
where geolocation='"PHILIPPINES';

update drp_rate
set level_of_education = 'Elementary'
where level_of_education = '""Elementary""';

update drp_rate
set level_of_education = 'Secondary (Junior High School)'
where level_of_education = '""Secondary (Junior High School)""';

update drp_rate
set level_of_education = 'Secondary (Senior High School)'
where level_of_education = '""Secondary (Senior High School)""';

update drp_rate
set sex = 'Both Sexes'
where sex = '""Both Sexes""';

update drp_rate
set sex = 'Male'
where sex = '""Male""';

update drp_rate
set sex = 'Female'
where sex = '""Female""';

--checks if data was loaded correctly
SELECT * FROM drp_rate
ORDER BY level_of_education, sex;



-- adding extra columns to fit in the pre-structured dataset (rate_report)

ALTER TABLE drp_rate
ADD COLUMN rate_type INTEGER,
ADD COLUMN ed_level_id INTEGER;


/* the succeeding lines are used to update column values using predefined values
rate_type = drop rate = 2
elementary = 1
secondary(junior high school) = 2
secondary(senior high school) = 3
*/

update drp_rate
set rate_type = 2
where rate_type IS NULL;


update drp_rate
set ed_level_id = 1
where level_of_education='Elementary';


update drp_rate
set ed_level_id = 2
where level_of_education='Secondary (Junior High School)';


update drp_rate
set ed_level_id = 3
where level_of_education='Secondary (Senior High School)';