-- DROP FUNCTION ova2.udf_delete_company(int4);

CREATE OR REPLACE FUNCTION ova2.udf_delete_company(_id integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE ova2.tbl_company
    SET is_deleted = TRUE, modified_date = CURRENT_TIMESTAMP
    WHERE id = _id;
END;
$function$
;