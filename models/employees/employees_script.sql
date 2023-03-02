/***********
* DBA MODE *
************/

--Let's set our worksheet role and db/schema
use role ACCOUNTADMIN;
use schema PC_FIVETRAN_DB.AV_STEP3_DATA;

--Make a new DEV db and schema and then clone the 3 key tables for isolated analysis and experimentation
create databASe AV_STEP3_DEV clone PC_FIVETRAN_DB;
use schema AV_STEP3_DEV.AV_STEP3_DATA;

--Create a virtual warehouse (compute) for the external team to do their work
create or replace warehouse EXT_ANALYSIS 
with 
warehouse_size = 'XSMALL' 
auto_suspend = 120 --seconds
auto_resume = TRUE;

/************************************
* NOW WE ARE IN TRANSFORMATION MODE *
*************************************/

-- Transformation on the employees table
SELECT 
    EMP_NO AS id,
    EMP_TITLE_ID AS title_id,
    TO_DATE(BIRTH_DATE, 'MM/DD/YY') AS birth_date,
    FIRST_NAME AS first_name,
    LAST_NAME AS lASt_name,
    SEX AS sex,
    TO_DATE(HIRE_DATE, 'MM/DD/YY') AS hire_date
FROM 
    employees;