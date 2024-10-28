-- DROP FUNCTION ova2.udf_update_user_data(int4, varchar, varchar, varchar, varchar, varchar, varchar, int4, int4, bool, bool);

CREATE OR REPLACE FUNCTION ova2.udf_update_user_data(p_registration_id integer, p_first_name character varying, p_last_name character varying, p_email character varying, p_phone character varying, p_password character varying, p_address character varying, p_role_id integer, p_registration_type_id integer, p_is_active boolean, p_is_deleted boolean)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE ova2.tbl_registration
    SET 
        first_name = COALESCE(p_first_name, first_name),
        last_name = COALESCE(p_last_name, last_name),
        email = COALESCE(p_email, email),
        phone = COALESCE(p_phone, phone),
        password = COALESCE(p_password, password),
        address = COALESCE(p_address, address),
        role_id = COALESCE(p_role_id, role_id),
        registration_type_id = COALESCE(p_registration_type_id, registration_type_id),
        modified_date = NOW(),
        is_active = COALESCE(p_is_active, is_active),
        is_deleted = COALESCE(p_is_deleted, is_deleted)
    WHERE registration_id = p_registration_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'User with registration_id % not found', p_registration_id;
    END IF;
END;
$function$
;
