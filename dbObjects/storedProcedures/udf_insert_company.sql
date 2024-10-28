-- DROP FUNCTION ova2.udf_insert_company(varchar, varchar, varchar, int4, varchar, text, int4, varchar, varchar, varchar, varchar, varchar, text, jsonb, varchar, varchar, timestamp, varchar, varchar, text);

CREATE OR REPLACE FUNCTION ova2.udf_insert_company(_company_name character varying, _contact_no character varying, _email_address character varying, _company_type_id integer, _website_url character varying DEFAULT NULL::character varying, _location text DEFAULT NULL::text, _established_year integer DEFAULT NULL::integer, _industry_sector character varying DEFAULT NULL::character varying, _contact_person_name character varying DEFAULT NULL::character varying, _contact_person_designation character varying DEFAULT NULL::character varying, _contact_person_phone character varying DEFAULT NULL::character varying, _contact_person_email character varying DEFAULT NULL::character varying, _description text DEFAULT NULL::text, _additional_info jsonb DEFAULT NULL::jsonb, _employee character varying DEFAULT NULL::character varying, _followup character varying DEFAULT NULL::character varying, _followupdate timestamp without time zone DEFAULT NULL::timestamp without time zone, _communicatethrough character varying DEFAULT NULL::character varying, _currentposition character varying DEFAULT NULL::character varying, _comment text DEFAULT NULL::text)
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
            description, additional_info, employee, followup, followupdate, communicatethrough, currentposition,comment
        )
        VALUES (
            _company_name, _contact_no, _email_address, _website_url, _location, _company_type_id,
            _established_year, _industry_sector,
            _contact_person_name, _contact_person_designation, _contact_person_phone, _contact_person_email,
            _description, _additional_info, _employee, _followup, _followupdate, _communicatethrough, _currentposition , _comment
        );

        -- Return success message
        RETURN 'Company inserted successfully.';
    END IF;
END;
$function$
;
