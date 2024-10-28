-- DROP FUNCTION ova2.udf_fetch_company_by_id_in_json(int4);

CREATE OR REPLACE FUNCTION ova2.udf_fetch_company_by_id_in_json(_id integer)
 RETURNS jsonb
 LANGUAGE plpgsql
AS $function$
DECLARE
    result jsonb;
BEGIN
    -- Fetch the company details as a JSON object
    SELECT jsonb_build_object(
            'company_name', c.company_name,
            'contact_no', c.contact_no,
            'email_address', c.email_address,
            'company_type_id', c.company_type_id,
            'website_url', c.website_url,
            'location', c.location,
            'industry_sector', c.industry_sector,
            'contact_person_name', c.contact_person_name,
            'contact_person_designation', c.contact_person_designation,
            'contact_person_phone', c.contact_person_phone,
            'contact_person_email', c.contact_person_email,
            'is_active', c.is_active,
            'is_deleted', c.is_deleted,
            'created_date', c.created_date,
            'modified_date', c.modified_date,
            'description', c.description,
            'additional_info', c.additional_info,
            'employee', c.employee,
            'followup', c.followup,
            'followupdate', c.followupdate,
            'communicatethrough', c.communicatethrough,
            'currentposition', c.currentposition,
            'comment', c.comment
        )
    INTO result
    FROM ova2.tbl_company c
    WHERE c.id = _id 
      AND c.is_active = TRUE 
      AND c.is_deleted = FALSE;

    -- Return the result or an empty JSON object if no match
    RETURN COALESCE(result, '{}'::jsonb);
END;
$function$
;
