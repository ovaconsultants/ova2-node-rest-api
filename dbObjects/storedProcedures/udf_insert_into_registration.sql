-- DROP FUNCTION ova2.udf_insert_into_registration(text, text, text, text, text, text, int4);

CREATE OR REPLACE FUNCTION ova2.udf_insert_into_registration(_first_name text, _last_name text, _email text, _phone text, _password text, _address text, _registration_type_id integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO ova2.tbl_registration(
        first_name,
        last_name,
        email,
        phone,
        password,
        address,
        registration_type_id
    )
    VALUES (
        _first_name,
        _last_name,
        _email,
        _phone,
        _password,
        _address,
        _registration_type_id
    );
END;
$function$
;
