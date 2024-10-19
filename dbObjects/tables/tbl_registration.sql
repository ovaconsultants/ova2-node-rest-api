-- ova2.tbl_registration definition

-- Drop table

-- DROP TABLE ova2.tbl_registration;

CREATE TABLE ova2.tbl_registration (
	registration_id serial4 NOT NULL,
	first_name varchar(50) NOT NULL,
	last_name varchar(50) NOT NULL,
	email varchar(100) NOT NULL,
	phone varchar(15) NULL,
	"password" text NOT NULL,
	address text NULL,
	role_id int4 DEFAULT 1 NULL,
	registration_type_id int4 NOT NULL,
	created_date timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	modified_date timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	is_active bool DEFAULT false NOT NULL,
	is_deleted bool DEFAULT false NOT NULL,
	CONSTRAINT tbl_registration_email_key UNIQUE (email),
	CONSTRAINT tbl_registration_pkey PRIMARY KEY (registration_id)
);

-- ova2.tbl_company_type definition

-- Drop table

-- DROP TABLE ova2.tbl_company_type;

CREATE TABLE ova2.tbl_company_type (
	id int4 DEFAULT nextval('company_type_id_seq'::regclass) NOT NULL,
	type_name varchar(100) NOT NULL,
	description text NULL,
	is_active bool DEFAULT true NULL,
	is_deleted bool DEFAULT true NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT company_type_pkey PRIMARY KEY (id),
	CONSTRAINT company_type_type_name_key UNIQUE (type_name)
);

-- ova2.tbl_registration definition

-- Drop table

-- DROP TABLE ova2.tbl_registration;

CREATE TABLE ova2.tbl_registration (
	registration_id serial4 NOT NULL,
	first_name varchar(50) NOT NULL,
	last_name varchar(50) NOT NULL,
	email varchar(100) NOT NULL,
	phone varchar(15) NULL,
	"password" text NOT NULL,
	address text NULL,
	role_id int4 DEFAULT 1 NULL,
	registration_type_id int4 NOT NULL,
	created_date timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	modified_date timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	is_active bool DEFAULT false NOT NULL,
	is_deleted bool DEFAULT false NOT NULL,
	CONSTRAINT tbl_registration_email_key UNIQUE (email),
	CONSTRAINT tbl_registration_pkey PRIMARY KEY (registration_id)
);

-- ova2.tbl_registration_type definition

-- Drop table

-- DROP TABLE ova2.tbl_registration_type;

CREATE TABLE ova2.tbl_registration_type (
	registration_type_id serial4 NOT NULL,
	type_name varchar(50) NOT NULL,
	description text NULL,
	created_date timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	modified_date timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	is_active bool DEFAULT true NULL,
	CONSTRAINT tbl_registration_type_pkey PRIMARY KEY (registration_type_id)
);

-- ova2.tbl_roles definition

-- Drop table

-- DROP TABLE ova2.tbl_roles;

CREATE TABLE ova2.tbl_roles (
	role_id serial4 NOT NULL,
	role_name varchar(50) NOT NULL,
	CONSTRAINT tbl_roles_pkey PRIMARY KEY (role_id),
	CONSTRAINT tbl_roles_role_name_key UNIQUE (role_name)
);


// Functions 

-- DROP FUNCTION ova2.delete_company(int4);

CREATE OR REPLACE FUNCTION ova2.delete_company(_id integer)
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

-- DROP FUNCTION ova2.fetch_active_company_types();

CREATE OR REPLACE FUNCTION ova2.fetch_active_company_types()
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

-- DROP FUNCTION ova2.fetch_companies();

CREATE OR REPLACE FUNCTION ova2.fetch_companies()
 RETURNS TABLE(id integer, company_name character varying, contact_no character varying, email_address character varying, company_type_id integer, website_url character varying, location text, established_year integer, industry_sector character varying, contact_person_name character varying, contact_person_designation character varying, contact_person_phone character varying, contact_person_email character varying, is_active boolean, is_deleted boolean, created_date timestamp without time zone, modified_date timestamp without time zone, description text, additional_info jsonb)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT * FROM ova2.tbl_company c
    WHERE c.is_active = TRUE AND c.is_deleted = FALSE;
END;
$function$
;

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

-- DROP FUNCTION ova2.udf_fetch_company_types();

CREATE OR REPLACE FUNCTION ova2.udf_fetch_company_types()
 RETURNS TABLE(id integer, type_name text, description text, is_active boolean, is_deleted boolean, created_at timestamp without time zone, updated_at timestamp without time zone)
 LANGUAGE sql
AS $function$
    SELECT * FROM ova2.tbl_company_type;
$function$
;

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

-- DROP FUNCTION ova2.udf_insert_company(varchar, varchar, varchar, int4, varchar, text, int4, varchar, varchar, varchar, varchar, varchar, text, jsonb);

CREATE OR REPLACE FUNCTION ova2.udf_insert_company(_company_name character varying, _contact_no character varying, _email_address character varying, _company_type_id integer, _website_url character varying DEFAULT NULL::character varying, _location text DEFAULT NULL::text, _established_year integer DEFAULT NULL::integer, _industry_sector character varying DEFAULT NULL::character varying, _contact_person_name character varying DEFAULT NULL::character varying, _contact_person_designation character varying DEFAULT NULL::character varying, _contact_person_phone character varying DEFAULT NULL::character varying, _contact_person_email character varying DEFAULT NULL::character varying, _description text DEFAULT NULL::text, _additional_info jsonb DEFAULT NULL::jsonb)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
DECLARE
    existing_company INT;
BEGIN
    -- Check if the company already exists with the same name and contact number
    SELECT COUNT(*) INTO existing_company
    FROM ova2.tbl_company
    WHERE company_name = _company_name AND contact_no = _contact_no AND is_deleted = FALSE;

    IF existing_company > 0 THEN
        -- If the company already exists, return a message
        RETURN 'Company with this name and contact number already exists.';
    ELSE
        -- If no such company exists, insert the new record
        INSERT INTO ova2.tbl_company (
            company_name, contact_no, email_address, website_url, location, company_type_id,
            established_year, industry_sector,
            contact_person_name, contact_person_designation, contact_person_phone, contact_person_email,
            description, additional_info
        )
        VALUES (
            _company_name, _contact_no, _email_address, _website_url, _location, _company_type_id,
            _established_year,_industry_sector,
            _contact_person_name, _contact_person_designation, _contact_person_phone, _contact_person_email,
            _description, _additional_info
        );

        -- Return success message
        RETURN 'Company inserted successfully.';
    END IF;
END;
$function$
;

-- DROP FUNCTION ova2.udf_insert_company(varchar, varchar, varchar, int4, varchar, text, int4, int4, numeric, varchar, varchar, varchar, varchar, varchar, text, jsonb);

CREATE OR REPLACE FUNCTION ova2.udf_insert_company(_company_name character varying, _contact_no character varying, _email_address character varying, _company_type_id integer, _website_url character varying DEFAULT NULL::character varying, _location text DEFAULT NULL::text, _established_year integer DEFAULT NULL::integer, _no_of_employees integer DEFAULT NULL::integer, _revenue numeric DEFAULT NULL::numeric, _industry_sector character varying DEFAULT NULL::character varying, _contact_person_name character varying DEFAULT NULL::character varying, _contact_person_designation character varying DEFAULT NULL::character varying, _contact_person_phone character varying DEFAULT NULL::character varying, _contact_person_email character varying DEFAULT NULL::character varying, _description text DEFAULT NULL::text, _additional_info jsonb DEFAULT NULL::jsonb)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
DECLARE
    existing_company INT;
BEGIN
    -- Check if the company already exists with the same name and contact number
    SELECT COUNT(*) INTO existing_company
    FROM ova2.tbl_company
    WHERE company_name = _company_name AND contact_no = _contact_no AND is_deleted = FALSE;

    IF existing_company > 0 THEN
        -- If the company already exists, return a message
        RETURN 'Company with this name and contact number already exists.';
    ELSE
        -- If no such company exists, insert the new record
        INSERT INTO company (
            company_name, contact_no, email_address, website_url, location, company_type_id,
            established_year, no_of_employees, revenue, industry_sector,
            contact_person_name, contact_person_designation, contact_person_phone, contact_person_email,
            description, additional_info
        )
        VALUES (
            _company_name, _contact_no, _email_address, _website_url, _location, _company_type_id,
            _established_year, _no_of_employees, _revenue, _industry_sector,
            _contact_person_name, _contact_person_designation, _contact_person_phone, _contact_person_email,
            _description, _additional_info
        );

        -- Return success message
        RETURN 'Company inserted successfully.';
    END IF;
END;
$function$
;

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

-- DROP FUNCTION ova2.update_company(int4, varchar, varchar, varchar, int4, varchar, text, int4, int4, numeric, varchar, varchar, varchar, varchar, varchar, text, jsonb);

CREATE OR REPLACE FUNCTION ova2.update_company(_id integer, _company_name character varying, _contact_no character varying, _email_address character varying, _company_type_id integer, _website_url character varying DEFAULT NULL::character varying, _location text DEFAULT NULL::text, _established_year integer DEFAULT NULL::integer, _no_of_employees integer DEFAULT NULL::integer, _revenue numeric DEFAULT NULL::numeric, _industry_sector character varying DEFAULT NULL::character varying, _contact_person_name character varying DEFAULT NULL::character varying, _contact_person_designation character varying DEFAULT NULL::character varying, _contact_person_phone character varying DEFAULT NULL::character varying, _contact_person_email character varying DEFAULT NULL::character varying, _description text DEFAULT NULL::text, _additional_info jsonb DEFAULT NULL::jsonb)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
DECLARE
    existing_company INT;
BEGIN
    -- Check if another company exists with the same name and contact number (excluding the current company being updated)
    SELECT COUNT(*) INTO existing_company
    FROM ova2.tbl_company
    WHERE company_name = _company_name
    AND contact_no = _contact_no
    AND id != _id
    AND is_deleted = FALSE;

    IF existing_company > 0 THEN
        -- If another company exists, return a message
        RETURN 'Another company with this name and contact number already exists.';
    ELSE
        -- If no conflict, proceed with the update
        UPDATE company
        SET
            company_name = _company_name,
            contact_no = _contact_no,
            email_address = _email_address,
            website_url = _website_url,
            location = _location,
            company_type_id = _company_type_id,
            established_year = _established_year,
            no_of_employees = _no_of_employees,
            revenue = _revenue,
            industry_sector = _industry_sector,
            contact_person_name = _contact_person_name,
            contact_person_designation = _contact_person_designation,
            contact_person_phone = _contact_person_phone,
            contact_person_email = _contact_person_email,
            description = _description,
            additional_info = _additional_info,
            modified_date = CURRENT_TIMESTAMP
        WHERE id = _id;

        -- Return success message
        RETURN 'Company updated successfully.';
    END IF;
END;
$function$
;
