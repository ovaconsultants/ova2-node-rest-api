
-- DROP FUNCTION ova2.udf_fetch_active_company_types();

CREATE OR REPLACE FUNCTION ova2.udf_fetch_active_company_types()
 RETURNS TABLE(id integer, type_name character varying, description text, created_at timestamp without time zone, updated_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT id, type_name, description, created_at, updated_at
    FROM ova2.tbl_company_type
    WHERE is_active = TRUE AND is_deleted = FALSE;
END;
$function$
;
