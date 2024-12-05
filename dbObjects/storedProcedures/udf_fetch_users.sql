-- DROP FUNCTION ova2.udf_fetch_users();

CREATE OR REPLACE FUNCTION ova2.udf_fetch_users()
 RETURNS TABLE(registration_id integer, first_name character varying, last_name character varying, email character varying, phone character varying, password text, address text, role_id integer, registration_type_id integer, created_date timestamp without time zone, modified_date timestamp without time zone, is_active boolean, is_deleted boolean)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY 
    SELECT 
       *
    FROM ova2.tbl_registration AS u order by  first_name asc ;
     
END;
$function$
;
