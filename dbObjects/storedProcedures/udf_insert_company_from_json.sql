-- DROP FUNCTION ova2.udf_insert_company_from_json(jsonb);

CREATE OR REPLACE FUNCTION ova2.udf_insert_company_from_json(company_data jsonb)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
DECLARE
    existing_company INT;
    _company_name character varying;
    _contact_no character varying;
    _email_address character varying;
    _company_type_id integer;
    _website_url character varying;
    _location text;
    _industry_sector character varying;
    _contact_person_name character varying;
    _contact_person_designation character varying;
    _contact_person_phone character varying;
    _contact_person_email character varying;
    _description text;
    _additional_info jsonb;
    _employee character varying;
    _followup character varying;
    _followupdate timestamp without time zone;
    _communicatethrough character varying;
    _currentposition character varying;
    _comment text;
BEGIN
    -- Extract fields from the JSON object
    _company_name := company_data->>'company_name';
    _contact_no := company_data->>'contact_no';
    _email_address := company_data->>'email_address';
    _company_type_id := (company_data->>'company_type_id')::integer;
    _website_url := company_data->>'website_url';
    _location := company_data->>'location';
    _industry_sector := company_data->>'industry_sector';
    _contact_person_name := company_data->>'contact_person_name';
    _contact_person_designation := company_data->>'contact_person_designation';
    _contact_person_phone := company_data->>'contact_person_phone';
    _contact_person_email := company_data->>'contact_person_email';
    _description := company_data->>'description';
    _additional_info := company_data->'additional_info';
    _employee := company_data->>'employee';
    _followup := company_data->>'followup';
    _followupdate := (company_data->>'followupdate')::timestamp without time zone;
    _communicatethrough := company_data->>'communicatethrough';
    _currentposition := company_data->>'currentposition';
    _comment := company_data->>'comment';

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
            industry_sector,
            contact_person_name, contact_person_designation, contact_person_phone, contact_person_email,
            description, additional_info, employee, followup, followupdate, communicatethrough, currentposition, comment
        )
        VALUES (
            _company_name, _contact_no, _email_address, _website_url, _location, _company_type_id,
            _industry_sector,
            _contact_person_name, _contact_person_designation, _contact_person_phone, _contact_person_email,
            _description, _additional_info, _employee, _followup, _followupdate, _communicatethrough, _currentposition, _comment
        );

        -- Return success message
        RETURN 'Company inserted successfully.';
    END IF;
END;
$function$
;
