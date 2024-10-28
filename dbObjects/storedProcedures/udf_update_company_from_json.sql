-- DROP FUNCTION ova2.udf_update_company_from_json(int4, jsonb);

CREATE OR REPLACE FUNCTION ova2.udf_update_company_from_json(_id integer, _company_data jsonb)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
DECLARE
    _company_name varchar(255);
    _contact_no varchar(15);
    _email_address varchar(255);
    _company_type_id integer;
    _website_url varchar(255);
    _location text;
    _industry_sector varchar(100);
    _contact_person_name varchar(255);
    _contact_person_designation varchar(255);
    _contact_person_phone varchar(15);
    _contact_person_email varchar(255);
    _description text;
    _additional_info jsonb;
    _communicatethrough varchar(255);
    _employee varchar(255); 
    _followup varchar(255);         
    _followupdate timestamp;   
    _currentposition varchar(255);  
    _comment text;             
    _is_active boolean;        
    _is_deleted boolean;       

    existing_company INT;

BEGIN
    -- Validation: Check if company_name is missing or empty
    IF _company_data->>'company_name' IS NULL OR _company_data->>'company_name' = '' THEN
        RETURN 'Company name is required.';
    END IF;

    -- Extract values from the JSON object and handle missing/NULL values
    _company_name := COALESCE(_company_data->>'company_name', '');
    _contact_no := COALESCE(_company_data->>'contact_no', '');
    _email_address := COALESCE(_company_data->>'email_address', '');
    _company_type_id := COALESCE((_company_data->>'company_type_id')::integer, NULL);
    _website_url := COALESCE(_company_data->>'website_url', '');
    _location := COALESCE(_company_data->>'location', '');
    _industry_sector := COALESCE(_company_data->>'industry_sector', '');
    _contact_person_name := COALESCE(_company_data->>'contact_person_name', '');
    _contact_person_designation := COALESCE(_company_data->>'contact_person_designation', '');
    _contact_person_phone := COALESCE(_company_data->>'contact_person_phone', '');
    _contact_person_email := COALESCE(_company_data->>'contact_person_email', '');
    _description := COALESCE(_company_data->>'description', '');
    _additional_info := COALESCE(_company_data->'additional_info', '{}'::jsonb);
    _communicatethrough := COALESCE(_company_data->>'communicatethrough', '');
    _employee := COALESCE(_company_data->>'employee', '');  
    _followup := COALESCE(_company_data->>'followup', '');  
    _followupdate := COALESCE((_company_data->>'followupdate')::timestamp, CURRENT_TIMESTAMP);  
    _currentposition := COALESCE(_company_data->>'currentposition', '');  
    _comment := COALESCE(_company_data->>'comment', '');  
    _is_active := COALESCE((_company_data->>'is_active')::boolean, true);  
    _is_deleted := COALESCE((_company_data->>'is_deleted')::boolean, false);  

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
        UPDATE ova2.tbl_company
        SET
            company_name = _company_name,
            contact_no = _contact_no,
            email_address = _email_address,
            website_url = _website_url,
            location = _location,
            company_type_id = _company_type_id, 
            industry_sector = _industry_sector,
            contact_person_name = _contact_person_name,
            contact_person_designation = _contact_person_designation,
            contact_person_phone = _contact_person_phone,
            contact_person_email = _contact_person_email,
            description = _description,
            additional_info = _additional_info,
            communicatethrough = _communicatethrough,
            employee = _employee,           
            followup = _followup,           
            followupdate = _followupdate,   
            currentposition = _currentposition,  
            "comment" = _comment,
            is_active = _is_active,         
            is_deleted = _is_deleted,       
            modified_date = CURRENT_TIMESTAMP
        WHERE id = _id;

        -- Return success message
        RETURN 'Company updated successfully.';
    END IF;
END;
$function$
;
