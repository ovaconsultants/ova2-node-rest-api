-- DROP FUNCTION ova2.udf_fetch_company_by_id(int4);

CREATE OR REPLACE FUNCTION ova2.udf_fetch_company_by_id(_company_id integer)
 RETURNS TABLE(id integer, company_name character varying, contact_no character varying, email_address character varying, company_type_id integer, website_url character varying, location text, industry_sector character varying, contact_person_name character varying, contact_person_designation character varying, contact_person_phone character varying, contact_person_email character varying, is_active boolean, is_deleted boolean, created_date timestamp without time zone, modified_date timestamp without time zone, description text, additional_info jsonb, employee character varying, followup character varying, followupdate timestamp without time zone, communicatethrough character varying, currentposition character varying, comment text)
 LANGUAGE sql
AS $function$
    -- Select all the fields from the company table where the id matches
    SELECT *
    FROM ova2.tbl_company
    WHERE id = _company_id;
$function$
;
