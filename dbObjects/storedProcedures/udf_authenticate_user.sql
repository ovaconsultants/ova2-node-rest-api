-- DROP FUNCTION ova2.udf_authenticate_user(in text, in text, out int4, out text, out int4, out text);

CREATE OR REPLACE FUNCTION ova2.udf_authenticate_user(_email text, _password text, OUT _registration_id integer, OUT _full_name text, OUT _role_id integer, OUT _role_name text)
 RETURNS record
 LANGUAGE plpgsql
AS $function$
	BEGIN
-- Retrieve user details if email, password match and the user is active
    SELECT r.registration_id, CONCAT(r.first_name, ' ', r.last_name), o.role_id , o.role_name
    INTO _registration_id, _full_name,_role_id , _role_name
    FROM ova2.tbl_registration r
    JOIN ova2.tbl_roles o 
    ON   r.role_id = o.role_id 
    WHERE r.email = _email
      AND r.password = _password   -- Plain-text password comparison
      AND r.is_active = TRUE
      AND r.is_deleted = FALSE;

    -- If no match found, set output values to NULL
    IF NOT FOUND THEN
        _registration_id := NULL;
        _full_name := NULL;
        _role_id := NULL ;
        _role_name := NULL ;
    END IF;
	END;
$function$
;
