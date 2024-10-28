-- DROP FUNCTION ova2.udf_fetch_companies();

CREATE OR REPLACE FUNCTION ova2.udf_fetch_companies()
 RETURNS TABLE(id integer, company_name character varying, contact_no character varying, email_address character varying, company_type_id integer, website_url character varying, location text, industry_sector character varying, contact_person_name character varying, contact_person_designation character varying, contact_person_phone character varying, contact_person_email character varying, is_active boolean, is_deleted boolean, created_date timestamp without time zone, modified_date timestamp without time zone, description text, additional_info jsonb, employee character varying, followup character varying, followupdate timestamp without time zone, communicatethrough character varying, currentposition character varying, comment text)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT 
        c.id, 
        c.company_name, 
        c.contact_no, 
        c.email_address, 
        c.company_type_id, 
        c.website_url, 
        c.location,  
        c.industry_sector, 
        c.contact_person_name, 
        c.contact_person_designation, 
        c.contact_person_phone, 
        c.contact_person_email, 
        c.is_active, 
        c.is_deleted, 
        c.created_date, 
        c.modified_date, 
        c.description, 
        c.additional_info, 
        c.employee, 
        c.followup, 
        c.followupdate, 
        c.communicatethrough, 
        c.currentposition, 
        c.comment
    FROM 
        ova2.tbl_company c
    WHERE 
        c.is_active = TRUE 
        AND c.is_deleted = FALSE;
END;
$function$
;
