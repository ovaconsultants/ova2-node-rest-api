-- DROP FUNCTION ova2.udf_fetch_registration_type();

CREATE OR REPLACE FUNCTION ova2.udf_fetch_registration_type()
 RETURNS TABLE(registration_type_id integer, registration_type_name character varying)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT t.registration_type_id, t.type_name 
    FROM ova2.tbl_registration_type t;
END;
$function$
;
