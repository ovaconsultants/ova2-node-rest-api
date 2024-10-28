-- DROP FUNCTION ova2.udf_fetch_user_with_id(int4);

CREATE OR REPLACE FUNCTION ova2.udf_fetch_user_with_id(_registration_id integer DEFAULT 1)
 RETURNS jsonb
 LANGUAGE sql
AS $function$
  SELECT json_build_object(
    'registration_id', r.registration_id,
    'first_name', r.first_name,
    'last_name', r.last_name,
    'email', r.email,
    'phone', r.phone,
    'address', r.address,
    'role_id', r.role_id,
    'registration_type_id', r.registration_type_id,
    'created_date', r.created_date,
    'modified_date', r.modified_date,
    'is_active', r.is_active, 
    'is_deleted', r.is_deleted
  )
  FROM ova2.tbl_registration r
  WHERE r.registration_id = _registration_id;
$function$
;
