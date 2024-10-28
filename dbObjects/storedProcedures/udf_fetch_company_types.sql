-- DROP FUNCTION ova2.udf_fetch_company_types();

CREATE OR REPLACE FUNCTION ova2.udf_fetch_company_types()
 RETURNS TABLE(id integer, type_name text, description text, is_active boolean, is_deleted boolean, created_at timestamp without time zone, updated_at timestamp without time zone)
 LANGUAGE sql
AS $function$
    SELECT * FROM ova2.tbl_company_type;
$function$
;
