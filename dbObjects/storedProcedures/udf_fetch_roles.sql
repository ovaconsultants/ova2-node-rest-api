-- DROP FUNCTION ova2.udf_fetch_roles();

CREATE OR REPLACE FUNCTION ova2.udf_fetch_roles()
 RETURNS TABLE(role_id integer, role_name character varying)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY 
    SELECT r.role_id, r.role_name 
    FROM ova2.tbl_roles r;
END;
$function$
;
