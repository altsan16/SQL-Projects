--Creating pre-structured table rate_report

CREATE TABLE IF NOT EXISTS public.rate_report
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
    "2022" text COLLATE pg_catalog."default",
	"rate_type" INTEGER,
	"ed_level_id" INTEGER
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.rate_report
    OWNER to postgres;


SELECT * FROM rate_report;


/*INSERTING VALUES FROM THE 2 Datasets*/

INSERT INTO rate_report
SELECT * FROM comp_rate

INSERT INTO rate_report
SELECT * FROM drp_rate

--observed another column that needs cleaning
update rate_report
set "2022" = '...'
where "2022" = '..."';

--checks if all data is loaded correctly
SELECT * FROM rate_report
ORDER BY level_of_education;
