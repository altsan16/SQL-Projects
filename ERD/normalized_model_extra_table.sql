/* Codes for the Normalized Data Model */

/* The succeeding line of codes creates extra table named "education_subcateg" with values derived from the original table
rate_report to mirror planned the normalized data model
The following may also be achieved by using VIEW function*/

CREATE TABLE public.education_sub_categ
(
    ed_level_id integer,
    level_of_education character varying
);

INSERT INTO education_sub_categ
SELECT ed_level_id, level_of_education
FROM rate_report
group by ed_level_id,  level_of_education
ORDER BY ed_level_id

--check if desired table output is achieved
SELECT * FROM education_sub_categ;