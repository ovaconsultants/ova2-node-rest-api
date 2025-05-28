-- DROP SCHEMA ova2;

CREATE SCHEMA ova2 AUTHORIZATION postgres;

-- DROP SEQUENCE ova2.company_id_seq;

CREATE SEQUENCE ova2.company_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE ova2.company_type_id_seq;

CREATE SEQUENCE ova2.company_type_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE ova2.tbl_communication_mediums_id_seq;

CREATE SEQUENCE ova2.tbl_communication_mediums_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE ova2.tbl_contact_queries_queryid_seq;

CREATE SEQUENCE ova2.tbl_contact_queries_queryid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE ova2.tbl_course_enrollments_enrollment_id_seq;

CREATE SEQUENCE ova2.tbl_course_enrollments_enrollment_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE ova2.tbl_employee_salary_id_seq;

CREATE SEQUENCE ova2.tbl_employee_salary_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE ova2.tbl_employeeallocation_id_seq;

CREATE SEQUENCE ova2.tbl_employeeallocation_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE ova2.tbl_exception_log_id_seq;

CREATE SEQUENCE ova2.tbl_exception_log_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE ova2.tbl_job_posting_job_id_seq;

CREATE SEQUENCE ova2.tbl_job_posting_job_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE ova2.tbl_job_seeker_job_seeker_id_seq;

CREATE SEQUENCE ova2.tbl_job_seeker_job_seeker_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE ova2.tbl_registration_registration_id_seq;

CREATE SEQUENCE ova2.tbl_registration_registration_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE ova2.tbl_registration_type_registration_type_id_seq;

CREATE SEQUENCE ova2.tbl_registration_type_registration_type_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE ova2.tbl_roles_role_id_seq;

CREATE SEQUENCE ova2.tbl_roles_role_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE ova2.tbl_software_technologies_id_seq;

CREATE SEQUENCE ova2.tbl_software_technologies_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE ova2.tbl_technology_mapping_mapping_id_seq;

CREATE SEQUENCE ova2.tbl_technology_mapping_mapping_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE ova2.tbl_vendor_comments_comment_id_seq;

CREATE SEQUENCE ova2.tbl_vendor_comments_comment_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;-- ova2.tbl_communication_mediums definition

-- Drop table

-- DROP TABLE ova2.tbl_communication_mediums;

CREATE TABLE ova2.tbl_communication_mediums (
	id serial4 NOT NULL,
	medium varchar(255) NOT NULL,
	CONSTRAINT tbl_communication_mediums_pkey PRIMARY KEY (id)
);


-- ova2.tbl_company_type definition

-- Drop table

-- DROP TABLE ova2.tbl_company_type;

CREATE TABLE ova2.tbl_company_type (
	id int4 DEFAULT nextval('ova2.company_type_id_seq'::regclass) NOT NULL,
	type_name varchar(100) NOT NULL,
	description text NULL,
	is_active bool DEFAULT true NULL,
	is_deleted bool DEFAULT true NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT company_type_pkey PRIMARY KEY (id),
	CONSTRAINT company_type_type_name_key UNIQUE (type_name)
);


-- ova2.tbl_contact_queries definition

-- Drop table

-- DROP TABLE ova2.tbl_contact_queries;

CREATE TABLE ova2.tbl_contact_queries (
	queryid serial4 NOT NULL,
	visitor_name varchar(255) NOT NULL,
	email_address varchar(255) NOT NULL,
	phone varchar(15) NULL,
	subject varchar(255) NULL,
	message text NOT NULL,
	submission_date timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	status varchar(50) DEFAULT 'New'::character varying NULL,
	CONSTRAINT tbl_contact_queries_pkey PRIMARY KEY (queryid)
);


-- ova2.tbl_course_enrollments definition

-- Drop table

-- DROP TABLE ova2.tbl_course_enrollments;

CREATE TABLE ova2.tbl_course_enrollments (
	enrollment_id serial4 NOT NULL,
	course_name varchar(100) NOT NULL,
	student_name varchar(100) NOT NULL,
	email varchar(255) NOT NULL,
	phone varchar(15) NULL,
	enrollment_date timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	payment_status varchar(20) DEFAULT 'Pending'::character varying NULL,
	CONSTRAINT tbl_course_enrollments_pkey PRIMARY KEY (enrollment_id)
);


-- ova2.tbl_employeeallocation definition

-- Drop table

-- DROP TABLE ova2.tbl_employeeallocation;

CREATE TABLE ova2.tbl_employeeallocation (
	id serial4 NOT NULL,
	employeename varchar(250) NOT NULL,
	CONSTRAINT tbl_employeeallocation_pkey PRIMARY KEY (id)
);


-- ova2.tbl_exception_log definition

-- Drop table

-- DROP TABLE ova2.tbl_exception_log;

CREATE TABLE ova2.tbl_exception_log (
	id serial4 NOT NULL,
	exception_message text NOT NULL,
	exception_stacktrace text NULL,
	log_date timestamp DEFAULT now() NULL,
	"source" varchar(50) NULL,
	severity varchar(20) DEFAULT 'ERROR'::character varying NULL,
	CONSTRAINT tbl_exception_log_pkey PRIMARY KEY (id)
);


-- ova2.tbl_job_posting definition

-- Drop table

-- DROP TABLE ova2.tbl_job_posting;

CREATE TABLE ova2.tbl_job_posting (
	job_id int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	title varchar(255) NULL,
	description text NULL,
	company varchar(255) NULL,
	workplace_type varchar(50) NULL,
	employee_location varchar(255) NULL,
	employment_type varchar(50) NULL,
	experience varchar(50) NULL,
	work_authorization varchar(50) NULL,
	country varchar(50) NULL,
	created_date timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	modified_date timestamp NULL,
	created_by varchar(255) NULL,
	updated_by varchar(255) NULL,
	is_active bpchar(1) DEFAULT 'Y'::bpchar NULL,
	is_delete bpchar(1) DEFAULT 'N'::bpchar NULL,
	CONSTRAINT tbl_job_posting_pkey PRIMARY KEY (job_id)
);


-- ova2.tbl_job_seeker definition

-- Drop table

-- DROP TABLE ova2.tbl_job_seeker;

CREATE TABLE ova2.tbl_job_seeker (
	job_seeker_id int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	first_name varchar(50) NOT NULL,
	last_name varchar(50) NOT NULL,
	email varchar(100) NOT NULL,
	country_code varchar(5) NULL,
	phone_number varchar(20) NOT NULL,
	current_location varchar(255) NULL,
	country varchar(100) NULL,
	work_authorization varchar(255) NULL,
	experience_years int4 NULL,
	resume_short_summary text NULL,
	linkedin_profile varchar(255) NULL,
	skills text NULL,
	created_date timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	is_active bpchar(1) DEFAULT 'Y'::bpchar NULL,
	"comments" text NULL,
	CONSTRAINT tbl_job_seeker_email_key UNIQUE (email),
	CONSTRAINT tbl_job_seeker_pkey PRIMARY KEY (job_seeker_id)
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
	is_active bool DEFAULT true NOT NULL,
	is_deleted bool DEFAULT false NOT NULL,
	current_location varchar(255) NULL,
	experience_in_years int4 NULL,
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


-- ova2.tbl_software_technologies definition

-- Drop table

-- DROP TABLE ova2.tbl_software_technologies;

CREATE TABLE ova2.tbl_software_technologies (
	id serial4 NOT NULL,
	technology varchar(255) NOT NULL,
	CONSTRAINT tbl_software_technologies_pkey PRIMARY KEY (id)
);


-- ova2.tbl_company definition

-- Drop table

-- DROP TABLE ova2.tbl_company;

CREATE TABLE ova2.tbl_company (
	id int4 DEFAULT nextval('ova2.company_id_seq'::regclass) NOT NULL,
	company_name varchar(255) NOT NULL,
	contact_no varchar(15) NOT NULL,
	email_address varchar(255) NOT NULL,
	company_type_id int4 NULL,
	website_url varchar(255) NULL,
	"location" text NULL,
	industry_sector varchar(100) NULL,
	contact_person_name varchar(255) NULL,
	contact_person_designation varchar(255) NULL,
	contact_person_phone varchar(15) NULL,
	contact_person_email varchar(255) NULL,
	is_active bool DEFAULT true NULL,
	is_deleted bool DEFAULT false NULL,
	created_date timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	modified_date timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	description text NULL,
	additional_info jsonb NULL,
	employee varchar(255) NULL,
	followup varchar(255) NULL,
	followupdate timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	communicatethrough varchar(255) NULL,
	currentposition varchar(255) NULL,
	"comment" text NULL,
	CONSTRAINT company_company_name_contact_no_key UNIQUE (company_name, contact_no),
	CONSTRAINT company_pkey PRIMARY KEY (id),
	CONSTRAINT company_company_type_id_fkey FOREIGN KEY (company_type_id) REFERENCES ova2.tbl_company_type(id)
);


-- ova2.tbl_employee_salary definition

-- Drop table

-- DROP TABLE ova2.tbl_employee_salary;

CREATE TABLE ova2.tbl_employee_salary (
	id serial4 NOT NULL,
	employee_id int4 NULL,
	basic_salary int4 NOT NULL,
	da int4 NULL,
	ta int4 NULL,
	hra int4 NULL,
	gross_salary int4 GENERATED ALWAYS AS (basic_salary + COALESCE(da, 0) + COALESCE(ta, 0) + COALESCE(hra, 0)) STORED NULL,
	provident_fund int4 NULL,
	esi int4 NULL,
	tax int4 NULL,
	loan int4 NULL,
	total_deduction int4 GENERATED ALWAYS AS (COALESCE(provident_fund, 0) + COALESCE(esi, 0) + COALESCE(tax, 0) + COALESCE(loan, 0)) STORED NULL,
	net_salary int4 GENERATED ALWAYS AS (basic_salary + COALESCE(da, 0) + COALESCE(ta, 0) + COALESCE(hra, 0) - (COALESCE(provident_fund, 0) + COALESCE(esi, 0) + COALESCE(tax, 0) + COALESCE(loan, 0))) STORED NULL,
	pay_month varchar(20) NULL,
	bank_name varchar(100) NULL,
	bank_transaction varchar(100) NULL,
	created_date date DEFAULT CURRENT_DATE NOT NULL,
	CONSTRAINT tbl_employee_salary_pkey PRIMARY KEY (id),
	CONSTRAINT tbl_employee_salary_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES ova2.tbl_registration(registration_id)
);


-- ova2.tbl_technology_mapping definition

-- Drop table

-- DROP TABLE ova2.tbl_technology_mapping;

CREATE TABLE ova2.tbl_technology_mapping (
	mapping_id serial4 NOT NULL,
	registration_id int4 NOT NULL,
	technology_id int4 NOT NULL,
	CONSTRAINT tbl_technology_mapping_pkey PRIMARY KEY (mapping_id),
	CONSTRAINT fk_registration FOREIGN KEY (registration_id) REFERENCES ova2.tbl_registration(registration_id) ON DELETE CASCADE,
	CONSTRAINT fk_technology FOREIGN KEY (technology_id) REFERENCES ova2.tbl_software_technologies(id) ON DELETE CASCADE
);


-- ova2.tbl_vendor_comments definition

-- Drop table

-- DROP TABLE ova2.tbl_vendor_comments;

CREATE TABLE ova2.tbl_vendor_comments (
	comment_id serial4 NOT NULL,
	company_id int4 NOT NULL,
	"comment" text NOT NULL,
	created_date timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
	CONSTRAINT tbl_vendor_comments_pkey PRIMARY KEY (comment_id),
	CONSTRAINT vendor_comments_company_id_fkey FOREIGN KEY (company_id) REFERENCES ova2.tbl_company(id)
);



-- DROP FUNCTION ova2.fetch_communication_mediums();

CREATE OR REPLACE FUNCTION ova2.fetch_communication_mediums()
 RETURNS SETOF ova2.tbl_communication_mediums
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT * FROM tbl_communication_mediums;
END;
$function$
;

-- DROP FUNCTION ova2.get_all_employee_allocations();

CREATE OR REPLACE FUNCTION ova2.get_all_employee_allocations()
 RETURNS SETOF ova2.tbl_employeeallocation
 LANGUAGE sql
AS $function$
    SELECT * FROM ova2.tbl_employeeAllocation;
$function$
;

-- DROP FUNCTION ova2.get_job_postings(varchar);

CREATE OR REPLACE FUNCTION ova2.get_job_postings(p_country character varying DEFAULT NULL::character varying)
 RETURNS TABLE(jobid integer, title character varying, description text, company character varying, workplacetype character varying, employeelocation character varying, employmenttype character varying, experience character varying, workauthorization character varying, country character varying, createddate timestamp without time zone, modifieddate timestamp without time zone, createdby character varying, updatedby character varying, isactive character, isdelete character)
 LANGUAGE plpgsql
AS $function$
BEGIN
    -- Query to retrieve job postings based on optional country filter
    RETURN QUERY
    SELECT 
        p.job_id , 
        p.title, 
        p.description, 
        p.company, 
        p.workplace_type , 
        p.employee_location , 
        p.employment_type , 
        p.experience, 
        p.work_authorization , 
        p.country, 
        p.created_date , 
        p.modified_date , 
        p.created_by , 
        p.updated_by , 
        p.is_active , 
        p.is_delete 
    FROM ova2.tbl_job_posting p
    WHERE p.is_delete = 'N' -- Exclude deleted records
      AND (p_country IS NULL OR p_country = 'ALL' OR p.country = p_country);
END;
$function$
;

-- DROP FUNCTION ova2.udf_add_vendor_comment(jsonb);

CREATE OR REPLACE FUNCTION ova2.udf_add_vendor_comment(comment_data jsonb)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
BEGIN
    -- Validate input
    IF comment_data->>'company_id' IS NULL THEN
        RAISE EXCEPTION 'Company ID is required';
    END IF;
    IF comment_data->>'comment' IS NULL THEN
        RAISE EXCEPTION 'Comment is required';
    END IF;

    -- Insert the comment
    INSERT INTO ova2.tbl_vendor_comments (company_id, "comment", created_date)
    VALUES (
        (comment_data->>'company_id')::INT, 
        comment_data->>'comment',
        CURRENT_TIMESTAMP
    );

    RETURN 'Comment added successfully';
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

-- DROP FUNCTION ova2.udf_delete_company(int4);

CREATE OR REPLACE FUNCTION ova2.udf_delete_company(_id integer)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    -- Update the company record
    UPDATE ova2.tbl_company 
    SET is_deleted = TRUE, modified_date = CURRENT_TIMESTAMP
    WHERE id = _id;

    -- Return TRUE if a row was updated, otherwise FALSE
    RETURN FOUND;
END;
$function$
;

-- DROP FUNCTION ova2.udf_delete_job_posting(int4, varchar);

CREATE OR REPLACE FUNCTION ova2.udf_delete_job_posting(p_job_id integer, p_updated_by character varying)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE ova2.tbl_job_posting tjp
    SET 
        is_delete = 'Y',
        updated_by = p_updated_by,
        modified_date = CURRENT_TIMESTAMP
    WHERE tjp.job_id = p_job_id AND tjp.is_delete = 'N';

    RETURN FOUND;
END;
$function$
;

-- DROP FUNCTION ova2.udf_delete_user(int4);

CREATE OR REPLACE FUNCTION ova2.udf_delete_user(p_registration_id integer)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    -- Set is_deleted to TRUE for the specified registration_id
    UPDATE ova2.tbl_registration tr
    SET tr.is_deleted = TRUE
    WHERE tr.registration_id = p_registration_id;

    -- Return whether any rows were affected
    RETURN FOUND;
END;
$function$
;

-- DROP FUNCTION ova2.udf_enroll_student(jsonb);

CREATE OR REPLACE FUNCTION ova2.udf_enroll_student(enrollment_data jsonb)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
BEGIN
    -- Validate fields and raise exceptions for invalid input
    IF enrollment_data->>'course_name' = '' OR enrollment_data->>'course_name' IS NULL THEN RAISE EXCEPTION 'Course name cannot be null or empty'; END IF;
    IF enrollment_data->>'student_name' = '' OR enrollment_data->>'student_name' IS NULL THEN RAISE EXCEPTION 'Student name cannot be null or empty'; END IF;
    IF enrollment_data->>'email' = '' OR enrollment_data->>'email' IS NULL THEN RAISE EXCEPTION 'Email cannot be null or empty'; END IF;
    
    -- Insert data
    INSERT INTO ova2.tbl_course_enrollments (course_name, student_name, email, phone)
    VALUES (enrollment_data->>'course_name', enrollment_data->>'student_name', enrollment_data->>'email', NULLIF(enrollment_data->>'phone', ''));
    
    RETURN 'Enrollment successful';
END;
$function$
;

-- DROP FUNCTION ova2.udf_fetch_active_company_types();

CREATE OR REPLACE FUNCTION ova2.udf_fetch_active_company_types()
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

-- DROP FUNCTION ova2.udf_fetch_all_course_enrollments();

CREATE OR REPLACE FUNCTION ova2.udf_fetch_all_course_enrollments()
 RETURNS TABLE(enrollment_id integer, course_name character varying, student_name character varying, email character varying, phone character varying, enrollment_date timestamp without time zone, payment_status character varying)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY SELECT * FROM ova2.tbl_course_enrollments;
END;
$function$
;

-- DROP FUNCTION ova2.udf_fetch_communication_mediums();

CREATE OR REPLACE FUNCTION ova2.udf_fetch_communication_mediums()
 RETURNS SETOF ova2.tbl_communication_mediums
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT * FROM ova2.tbl_communication_mediums;
END;
$function$
;

-- DROP FUNCTION ova2.udf_fetch_companies();

CREATE OR REPLACE FUNCTION ova2.udf_fetch_companies()
 RETURNS TABLE(id integer, company_name character varying, contact_no character varying, email_address character varying, company_type_id integer, website_url character varying, location text, industry_sector character varying, contact_person_name character varying, contact_person_designation character varying, contact_person_phone character varying, contact_person_email character varying, is_active boolean, is_deleted boolean, created_date timestamp without time zone, modified_date timestamp without time zone, description text, additional_info jsonb, employee character varying, followup character varying, followupdate timestamp without time zone, communicatethrough character varying, currentposition character varying, comment text)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT 
        c.id, 
        c.company_name, 
        c.contact_no, 
        c.email_address, 
        c.company_type_id, 
        c.website_url, 
        c.location,  
        c.industry_sector, 
        c.contact_person_name, 
        c.contact_person_designation, 
        c.contact_person_phone, 
        c.contact_person_email, 
        c.is_active, 
        c.is_deleted, 
        c.created_date, 
        c.modified_date, 
        c.description, 
        c.additional_info, 
        c.employee, 
        c.followup, 
        c.followupdate, 
        c.communicatethrough, 
        c.currentposition, 
        c.comment
    FROM 
        ova2.tbl_company c
    WHERE 
        c.is_deleted = FALSE;
END;
$function$
;

-- DROP FUNCTION ova2.udf_fetch_company_by_id(int4);

CREATE OR REPLACE FUNCTION ova2.udf_fetch_company_by_id(_company_id integer)
 RETURNS TABLE(id integer, company_name character varying, contact_no character varying, email_address character varying, company_type_id integer, website_url character varying, location text, industry_sector character varying, contact_person_name character varying, contact_person_designation character varying, contact_person_phone character varying, contact_person_email character varying, is_active boolean, is_deleted boolean, created_date timestamp without time zone, modified_date timestamp without time zone, description text, additional_info jsonb, employee character varying, followup character varying, followupdate timestamp without time zone, communicatethrough character varying, currentposition character varying, comment text)
 LANGUAGE sql
AS $function$
    -- Select all the fields from the company table where the id matches
    SELECT *
    FROM ova2.tbl_company
    WHERE id = _company_id;
$function$
;

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

-- DROP FUNCTION ova2.udf_fetch_company_types();

CREATE OR REPLACE FUNCTION ova2.udf_fetch_company_types()
 RETURNS TABLE(id integer, type_name text, description text, is_active boolean, is_deleted boolean, created_at timestamp without time zone, updated_at timestamp without time zone)
 LANGUAGE sql
AS $function$
    SELECT * FROM ova2.tbl_company_type;
$function$
;

-- DROP FUNCTION ova2.udf_fetch_exception_logs(varchar, varchar);

CREATE OR REPLACE FUNCTION ova2.udf_fetch_exception_logs(severity_filter character varying, source_filter character varying)
 RETURNS jsonb
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN jsonb_agg(
        query
    )
    FROM (
        SELECT 
            id,
            exception_message,
            exception_stacktrace,
            log_date,
            "source",
            severity
        FROM ova2.tbl_exception_log
        WHERE 
            (severity_filter IS NULL OR severity = severity_filter)
            AND (source_filter IS NULL OR "source" = source_filter)
    ) AS query;
END;
$function$
;

-- DROP FUNCTION ova2.udf_fetch_job_seeker(int4);

CREATE OR REPLACE FUNCTION ova2.udf_fetch_job_seeker(p_job_seeker_id integer DEFAULT NULL::integer)
 RETURNS TABLE(job_seeker_id integer, first_name character varying, last_name character varying, email character varying, country_code character varying, phone_number character varying, current_location character varying, country character varying, work_authorization character varying, experience_years integer, resume_short_summary text, linkedin_profile character varying, skills text, created_date timestamp without time zone, is_active character, comments text)
 LANGUAGE plpgsql
AS $function$
BEGIN
    IF p_job_seeker_id IS NULL THEN
        RETURN QUERY
        SELECT ts.job_seeker_id,        -- Explicitly referencing the column from tbl_job_seeker
               ts.first_name,
               ts.last_name,
               ts.email,
               ts.country_code,
               ts.phone_number,
               ts.current_location,
               ts.country,
               ts.work_authorization,
               ts.experience_years,
               ts.resume_short_summary,
               ts.linkedin_profile,
               ts.skills,
               ts.created_date,
               ts.is_active,
               ts.comments
        FROM ova2.tbl_job_seeker ts     -- Alias 'ts' for tbl_job_seeker
        WHERE ts.is_active = 'Y';
    ELSE
        RETURN QUERY
        SELECT ts.job_seeker_id,        -- Explicitly referencing the column from tbl_job_seeker
               ts.first_name,
               ts.last_name,
               ts.email,
               ts.country_code,
               ts.phone_number,
               ts.current_location,
               ts.country,
               ts.work_authorization,
               ts.experience_years,
               ts.resume_short_summary,
               ts.linkedin_profile,
               ts.skills,
               ts.created_date,
               ts.is_active,
               ts.comments
        FROM ova2.tbl_job_seeker ts     -- Alias 'ts' for tbl_job_seeker
        WHERE ts.job_seeker_id = p_job_seeker_id AND ts.is_active = 'Y';
    END IF;
END;
$function$
;

-- DROP FUNCTION ova2.udf_fetch_pay_slip_data_by_registration_id(int4);

CREATE OR REPLACE FUNCTION ova2.udf_fetch_pay_slip_data_by_registration_id(registration_id_input integer)
 RETURNS SETOF ova2.tbl_employee_salary
 LANGUAGE sql
AS $function$
    SELECT * 
    FROM ova2.tbl_employee_salary
    WHERE employee_id = registration_id_input;
$function$
;

-- DROP FUNCTION ova2.udf_fetch_pay_slip_month_data_by_registration_id_and_year(int4, int4);

CREATE OR REPLACE FUNCTION ova2.udf_fetch_pay_slip_month_data_by_registration_id_and_year(registration_id integer, year integer)
 RETURNS SETOF ova2.tbl_employee_salary
 LANGUAGE sql
AS $function$
    SELECT * 
    FROM ova2.tbl_employee_salary
    WHERE employee_id = registration_id
      AND EXTRACT(YEAR FROM TO_DATE(pay_month, 'YYYY-MM')) = year;
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

-- DROP FUNCTION ova2.udf_fetch_software_technologies();

CREATE OR REPLACE FUNCTION ova2.udf_fetch_software_technologies()
 RETURNS SETOF ova2.tbl_software_technologies
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT * FROM ova2.tbl_software_technologies;
END;
$function$
;

-- DROP FUNCTION ova2.udf_fetch_technologies_with_registration_id(int4);

CREATE OR REPLACE FUNCTION ova2.udf_fetch_technologies_with_registration_id(_registration_id integer)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
DECLARE
    tech_ids_as_string_comma_separated_values TEXT;
BEGIN
    -- Convert the array of technology IDs into a comma-separated string
    SELECT STRING_AGG(technology_id::TEXT, ',')
    INTO tech_ids_as_string_comma_separated_values
    FROM ova2.tbl_technology_mapping
    WHERE registration_id = _registration_id;

    -- Return the resulting string
    RETURN tech_ids_as_string_comma_separated_values;
END;
$function$
;

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
    'password', r.password,
    'address', r.address,
    'role_id', r.role_id,
    'registration_type_id', r.registration_type_id,
    'created_date', r.created_date,
    'modified_date', r.modified_date,
    'is_active', r.is_active, 
    'is_deleted', r.is_deleted,
    'current_location', r.current_location,
    'experience_in_years', r.experience_in_years
  )
  FROM ova2.tbl_registration r
  WHERE r.registration_id = _registration_id;
$function$
;

-- DROP FUNCTION ova2.udf_fetch_user_with_id_and_technologies(int4);

CREATE OR REPLACE FUNCTION ova2.udf_fetch_user_with_id_and_technologies(_registration_id integer DEFAULT 1)
 RETURNS jsonb
 LANGUAGE sql
AS $function$
  SELECT json_build_object(
    'registration_id', r.registration_id,
    'first_name', r.first_name,
    'last_name', r.last_name,
    'email', r.email,
    'phone', r.phone,
    'password', r.password,
    'address', r.address,
    'role_id', r.role_id,
    'registration_type_id', r.registration_type_id,
    'created_date', r.created_date,
    'modified_date', r.modified_date,
    'is_active', r.is_active, 
    'is_deleted', r.is_deleted,
    'current_location', r.current_location,
    'experience_in_years', r.experience_in_years,
    'technologies', STRING_AGG(tm.technology_id::TEXT, ',')
  )
  FROM ova2.tbl_registration r
  LEFT JOIN ova2.tbl_technology_mapping tm ON r.registration_id = tm.registration_id
  WHERE r.registration_id = _registration_id
  GROUP BY r.registration_id;
$function$
;

-- DROP FUNCTION ova2.udf_fetch_users();

CREATE OR REPLACE FUNCTION ova2.udf_fetch_users()
 RETURNS TABLE(registration_id integer, first_name character varying, last_name character varying, email character varying, phone character varying, password text, address text, role_id integer, registration_type_id integer, created_date timestamp without time zone, modified_date timestamp without time zone, is_active boolean, is_deleted boolean, current_location character varying, experience_in_years integer)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY 
    SELECT 
        u.registration_id, 
        u.first_name, 
        u.last_name, 
        u.email, 
        u.phone, 
        u."password", 
        u.address, 
        u.role_id, 
        u.registration_type_id, 
        u.created_date, 
        u.modified_date, 
        u.is_active, 
        u.is_deleted, 
        u.current_location, 
        u.experience_in_years
    FROM ova2.tbl_registration AS u 
    ORDER BY u.first_name ASC;
END;
$function$
;

-- DROP FUNCTION ova2.udf_fetch_vendor_comments_by_company_id(int4);

CREATE OR REPLACE FUNCTION ova2.udf_fetch_vendor_comments_by_company_id(target_company_id integer)
 RETURNS TABLE(comment_id integer, company_id integer, comment text, created_date timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT 
        tbl.comment_id, 
        tbl.company_id, 
        tbl.comment, 
        tbl.created_date
    FROM 
        ova2.tbl_vendor_comments AS tbl
    WHERE 
        tbl.company_id = target_company_id;
END;
$function$
;

-- DROP FUNCTION ova2.udf_get_all_contact_queries();

CREATE OR REPLACE FUNCTION ova2.udf_get_all_contact_queries()
 RETURNS TABLE(queryid integer, visitor_name character varying, email_address character varying, phone character varying, subject character varying, message text, submission_date timestamp without time zone, status character varying)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT 
        t.queryid, 
        t.visitor_name, 
        t.email_address, 
        t.phone, 
        t.subject, 
        t.message, 
        t.submission_date, 
        t.status
    FROM ova2.tbl_contact_queries AS t;
END;
$function$
;

-- DROP FUNCTION ova2.udf_get_employee_payslip_years(int4);

CREATE OR REPLACE FUNCTION ova2.udf_get_employee_payslip_years(employee_id_input integer)
 RETURNS TABLE(year integer)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT DISTINCT EXTRACT(YEAR FROM pay_month::date)::integer AS year
    FROM ova2.tbl_employee_salary
    WHERE employee_id = employee_id_input;
END;
$function$
;

-- DROP FUNCTION ova2.udf_get_job_posting_by_id(int4);

CREATE OR REPLACE FUNCTION ova2.udf_get_job_posting_by_id(p_job_id integer)
 RETURNS TABLE(job_id integer, title character varying, description text, company character varying, workplace_type character varying, employee_location character varying, employment_type character varying, experience character varying, work_authorization character varying, country character varying, created_date timestamp without time zone, modified_date timestamp without time zone, created_by character varying, updated_by character varying, is_active character, is_delete character)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT 
        tjp.job_id,             -- Explicitly qualified
        tjp.title,
        tjp.description,
        tjp.company,
        tjp.workplace_type,
        tjp.employee_location,
        tjp.employment_type,
        tjp.experience,
        tjp.work_authorization,
        tjp.country,
        tjp.created_date,
        tjp.modified_date,
        tjp.created_by,
        tjp.updated_by,
        tjp.is_active,
        tjp.is_delete
    FROM ova2.tbl_job_posting tjp
    WHERE tjp.job_id = p_job_id  -- Explicitly qualified
      AND tjp.is_delete = 'N';   -- Explicitly qualified
END;
$function$
;

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

    -- Handle empty or missing followupdate
    IF company_data->>'followupdate' IS NULL OR company_data->>'followupdate' = '' THEN
        _followupdate := NULL;
    ELSE
        _followupdate := (company_data->>'followupdate')::timestamp without time zone;
    END IF;

    _communicatethrough := company_data->>'communicatethrough';
    _currentposition := company_data->>'currentposition';
    _comment := company_data->>'comment';

    -- Check if the company already exists with the same name and contact number
    SELECT COUNT(*) INTO existing_company
    FROM ova2.tbl_company
    WHERE contact_no = _contact_no AND email_address = _email_address AND is_deleted = FALSE;

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

-- DROP FUNCTION ova2.udf_insert_contact_query_from_json(jsonb);

CREATE OR REPLACE FUNCTION ova2.udf_insert_contact_query_from_json(query_data jsonb)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
DECLARE
    _visitor_name varchar(255);
    _email_address varchar(255);
    _phone_number varchar(15);
    _query_subject varchar(255);
    _message_text text;
    _submission_date timestamp;
    _query_status varchar(50);
BEGIN
    -- Extract fields from the JSONB object using correct keys and handle empty strings
    _visitor_name := NULLIF(query_data->>'_visitor_name', '');
    _email_address := NULLIF(query_data->>'_email_address', '');
    _phone_number := NULLIF(query_data->>'_phone_number', '');
    _query_subject := NULLIF(query_data->>'_query_subject', '');
    _message_text := NULLIF(query_data->>'_message_text', '');
    _submission_date := COALESCE((query_data->>'_submission_date')::timestamp, CURRENT_TIMESTAMP);
    _query_status := COALESCE(NULLIF(query_data->>'_query_status', ''), 'New');

    -- Insert the data into the table
    INSERT INTO ova2.tbl_contact_queries (
        visitor_name, email_address, phone, subject, message, submission_date, status
    )
    VALUES (
        _visitor_name, _email_address, _phone_number, _query_subject, _message_text,
        _submission_date, 
        _query_status
    );

    RETURN 'Contact query inserted successfully.';
END;
$function$
;

-- DROP FUNCTION ova2.udf_insert_exception_log_from_json(jsonb);

CREATE OR REPLACE FUNCTION ova2.udf_insert_exception_log_from_json(log_data jsonb)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
DECLARE
    _exception_message TEXT;
    _exception_stacktrace TEXT;
    _log_date TIMESTAMP;
    _source VARCHAR(50);
    _severity VARCHAR(20);
BEGIN
    -- Extract fields from the JSONB object and handle empty strings
    _exception_message := NULLIF(log_data->>'exception_message', ''); -- Required
    _exception_stacktrace := NULLIF(log_data->>'exception_stacktrace', ''); -- Optional
    _log_date := COALESCE((log_data->>'log_date')::timestamp, CURRENT_TIMESTAMP); -- Optional, defaults to NOW()
    _source := NULLIF(log_data->>'source', ''); -- Optional
    _severity := COALESCE(NULLIF(log_data->>'severity', ''), 'ERROR'); -- Optional, defaults to 'ERROR'

    -- Validate required fields
    IF _exception_message IS NULL THEN
        RAISE EXCEPTION 'Exception message is required and cannot be null';
    END IF;

    -- Insert the data into the exception log table
    INSERT INTO ova2.tbl_exception_log (
        exception_message, exception_stacktrace, log_date, "source", severity
    )
    VALUES (
        _exception_message, _exception_stacktrace, _log_date, _source, _severity
    );

    -- Return success message
    RETURN 'Exception log inserted successfully';
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

-- DROP FUNCTION ova2.udf_insert_into_registration(text, text, text, text, text, text, int4, text, int4);

CREATE OR REPLACE FUNCTION ova2.udf_insert_into_registration(_first_name text, _last_name text, _email text, _phone text, _password text, _address text, _registration_type_id integer, _current_location text, _experience_in_years integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    -- Check if a record with the same email or phone already exists
   IF EXISTS (
    SELECT 1 
    FROM ova2.tbl_registration
    WHERE email = _email OR phone = _phone
) THEN
    RAISE EXCEPTION 'Record with email % or phone % already exists.', _email, _phone;
      END IF;

    -- Insert the new record
    INSERT INTO ova2.tbl_registration(
        first_name,
        last_name,
        email,
        phone,
        password,
        address,
        registration_type_id,
        current_location,
        experience_in_years
    )
    VALUES (
        _first_name,
        _last_name,
        _email,
        _phone,
        _password,
        _address,
        _registration_type_id,
        _current_location,
        _experience_in_years
    );
END;
$function$
;

-- DROP FUNCTION ova2.udf_insert_job_posting_from_json(jsonb);

CREATE OR REPLACE FUNCTION ova2.udf_insert_job_posting_from_json(job_data jsonb)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
DECLARE
    _title varchar(255);
    _description text;
    _company varchar(255);
    _workplace_type varchar(50);
    _employee_location varchar(255);
    _employment_type varchar(50);
    _experience varchar(50);
    _work_authorization varchar(50);
    _country varchar(50);
    _created_by varchar(255);
    _updated_by varchar(255);
    _is_active char(1);
    _is_delete char(1);
BEGIN
    -- Extract fields from the JSONB object, using NULLIF to handle empty strings and defaults
    _title := NULLIF(job_data->>'title', '');
    _description := NULLIF(job_data->>'description', '');
    _company := NULLIF(job_data->>'company', '');
    _workplace_type := NULLIF(job_data->>'workplaceType', ''); -- Use camelCase key
    _employee_location := NULLIF(job_data->>'employeeLocation', ''); -- Use camelCase key
    _employment_type := NULLIF(job_data->>'employmentType', ''); -- Use camelCase key
    _experience := NULLIF(job_data->>'experience', '');
    _work_authorization := NULLIF(job_data->>'workAuthorization', ''); -- Use camelCase key
    _country := NULLIF(job_data->>'country', '');
    _created_by := NULLIF(job_data->>'createdBy', ''); -- Use camelCase key if provided
    _updated_by := NULLIF(job_data->>'updatedBy', ''); -- Use camelCase key if provided
    _is_active := COALESCE(NULLIF(job_data->>'is_active', ''), 'Y')::char(1);
    _is_delete := COALESCE(NULLIF(job_data->>'is_delete', ''), 'N')::char(1);

    -- Insert the extracted data into the table
    INSERT INTO ova2.tbl_job_posting (
        title, description, company, workplace_type, employee_location, employment_type,
        experience, work_authorization, country, created_date, modified_date, 
        created_by, updated_by, is_active, is_delete
    )
    VALUES (
        _title, _description, _company, _workplace_type, _employee_location, _employment_type,
        _experience, _work_authorization, _country, CURRENT_TIMESTAMP, NULL, 
        _created_by, _updated_by, _is_active, _is_delete
    );

    -- Return a success message
    RETURN 'Job posting inserted successfully.';
END;
$function$
;

-- DROP FUNCTION ova2.udf_insert_job_seeker_from_json(jsonb);

CREATE OR REPLACE FUNCTION ova2.udf_insert_job_seeker_from_json(applicant_data jsonb)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
DECLARE
    _first_name VARCHAR(50);
    _last_name VARCHAR(50);
    _email VARCHAR(100);
    _country_code VARCHAR(5);
    _phone_number VARCHAR(20);
    _current_location VARCHAR(255);
    _country VARCHAR(100);
    _work_authorization VARCHAR(255);
    _experience_years INT;
    _resume_short_summary TEXT;
    _linkedin_profile VARCHAR(255);
    _skills TEXT;
    _comments TEXT;
    _is_active CHAR(1);
BEGIN
    -- Extract fields from the JSONB object, using NULLIF to handle empty strings and defaults
    _first_name := NULLIF(applicant_data->>'firstName', '');
    _last_name := NULLIF(applicant_data->>'lastName', '');
    _email := NULLIF(applicant_data->>'email', '');
    _country_code := NULLIF(applicant_data->>'countryCode', '');
    _phone_number := NULLIF(applicant_data->>'phoneNumber', '');
    _current_location := NULLIF(applicant_data->>'currentLocation', '');
    _country := NULLIF(applicant_data->>'country', '');
    _work_authorization := NULLIF(applicant_data->>'workAuthorization', '');
    _experience_years := NULLIF(applicant_data->>'experienceYears', '')::INT;
    _resume_short_summary := NULLIF(applicant_data->>'resumeShortSummary', '');
    _linkedin_profile := NULLIF(applicant_data->>'linkedinProfile', '');
    _skills := NULLIF(applicant_data->>'skills', '');
    _comments := NULLIF(applicant_data->>'comments', '');
    _is_active := COALESCE(NULLIF(applicant_data->>'isActive', ''), 'Y')::CHAR(1);

    -- Insert the extracted data into the tbl_job_seeker table
    INSERT INTO tbl_job_seeker (
        first_name, last_name, email, country_code, phone_number, 
        current_location, country, work_authorization, experience_years, 
        resume_short_summary, linkedin_profile, skills, 
        created_date, is_active, comments
    )
    VALUES (
        _first_name, _last_name, _email, _country_code, _phone_number, 
        _current_location, _country, _work_authorization, _experience_years, 
        _resume_short_summary, _linkedin_profile, _skills, 
        CURRENT_TIMESTAMP, _is_active, _comments
    );

    -- Return a success message
    RETURN 'Applicant inserted successfully.';
END;
$function$
;

-- DROP FUNCTION ova2.udf_retrieve_employee_list();

CREATE OR REPLACE FUNCTION ova2.udf_retrieve_employee_list()
 RETURNS TABLE(first_name character varying, last_name character varying)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT tr.first_name, tr.last_name
    FROM ova2.tbl_registration tr 
    WHERE tr.registration_type_id = 1;
END;
$function$
;

-- DROP FUNCTION ova2.udf_retrieve_users_by_registration_type_id(int4);

CREATE OR REPLACE FUNCTION ova2.udf_retrieve_users_by_registration_type_id(input_registration_type_id integer)
 RETURNS SETOF ova2.tbl_registration
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT *
    FROM ova2.tbl_registration
    WHERE registration_type_id = input_registration_type_id
      AND is_deleted = false; -- Exclude deleted records
END;
$function$
;

-- DROP FUNCTION ova2.udf_retrieve_users_names_by_registration_type_id(int4);

CREATE OR REPLACE FUNCTION ova2.udf_retrieve_users_names_by_registration_type_id(input_registration_type_id integer)
 RETURNS TABLE(registration_id integer, first_name text, last_name text)
 LANGUAGE plpgsql
AS $function$
BEGIN
    -- The query to retrieve specific columns: registration_id, first_name, last_name
    RETURN QUERY
    SELECT r.registration_id, r.first_name::text, r.last_name::text  -- Cast to text
    FROM ova2.tbl_registration r  -- Alias the table as 'r'
    WHERE r.registration_type_id = input_registration_type_id
    AND r.is_deleted = false;  -- Exclude records marked as deleted
END;
$function$
;

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

-- DROP FUNCTION ova2.udf_update_employee_salary_details(jsonb);

CREATE OR REPLACE FUNCTION ova2.udf_update_employee_salary_details(salary_data jsonb)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_employee_id INT;
    v_basic_salary INT;
    v_da INT;
    v_ta INT;
    v_hra INT;
    v_provident_fund INT;
    v_esi INT;
    v_tax INT;
    v_loan INT;
    v_pay_month VARCHAR(20);
    v_bank_name VARCHAR(100);
    v_bank_transaction VARCHAR(100);
    v_existing_salary_id INT;
BEGIN
    -- Extract values from JSON
    v_employee_id := (salary_data->>'employee_id')::INT;
    v_basic_salary := (salary_data->>'basic_salary')::INT;
    v_da := COALESCE((salary_data->>'da')::INT, 0);
    v_ta := COALESCE((salary_data->>'ta')::INT, 0);
    v_hra := COALESCE((salary_data->>'hra')::INT, 0);
    v_provident_fund := COALESCE((salary_data->>'provident_fund')::INT, 0);
    v_esi := COALESCE((salary_data->>'esi')::INT, 0);
    v_tax := COALESCE((salary_data->>'tax')::INT, 0);
    v_loan := COALESCE((salary_data->>'loan')::INT, 0);
    v_pay_month := salary_data->>'pay_month';
    v_bank_name := salary_data->>'bank_name';
    v_bank_transaction := salary_data->>'bank_transaction';

    -- Check if the record exists for the employee_id
    SELECT id INTO v_existing_salary_id
    FROM ova2.tbl_employee_salary
    WHERE employee_id = v_employee_id AND pay_month = v_pay_month LIMIT 1;

    IF FOUND THEN
        -- Update the existing record
        UPDATE ova2.tbl_employee_salary
        SET 
            basic_salary = v_basic_salary,
            da = v_da,
            ta = v_ta,
            hra = v_hra,
            provident_fund = v_provident_fund,
            esi = v_esi,
            tax = v_tax,
            loan = v_loan,
            bank_name = v_bank_name,
            bank_transaction = v_bank_transaction,
            created_date = CURRENT_DATE
        WHERE id = v_existing_salary_id;
        
        RETURN v_existing_salary_id;  -- Return the updated record's ID
    ELSE
        -- Insert a new record
        INSERT INTO ova2.tbl_employee_salary (
            employee_id, basic_salary, da, ta, hra, provident_fund, esi, tax, loan, 
            pay_month, bank_name, bank_transaction, created_date
        )
        VALUES (
            v_employee_id, v_basic_salary, v_da, v_ta, v_hra, v_provident_fund, 
            v_esi, v_tax, v_loan, v_pay_month, v_bank_name, v_bank_transaction, CURRENT_DATE
        )
        RETURNING id INTO v_existing_salary_id;  -- Capture the new record's ID
        
        RETURN v_existing_salary_id;  -- Return the newly created record's ID
    END IF;
END;
$function$
;

-- DROP FUNCTION ova2.udf_update_job_posting(int4, jsonb, varchar);

CREATE OR REPLACE FUNCTION ova2.udf_update_job_posting(p_job_id integer, p_job_data jsonb, p_updated_by character varying)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    -- Update the job posting with the specified job_id
    UPDATE ova2.tbl_job_posting
    SET 
        title = p_job_data->>'title', 
        description = p_job_data->>'description', 
        company = p_job_data->>'company', 
        workplace_type = p_job_data->>'workplace_type', 
        employee_location = p_job_data->>'employee_location', 
        employment_type = p_job_data->>'employment_type', 
        experience = p_job_data->>'experience', 
        work_authorization = p_job_data->>'work_authorization', 
        country = p_job_data->>'country', -- Extract country value from JSONB
        modified_date = CURRENT_TIMESTAMP,
        updated_by = p_updated_by
    WHERE job_id = p_job_id AND is_delete = 'N';

    -- Return whether any rows were affected
    RETURN FOUND;
END;
$function$
;

-- DROP FUNCTION ova2.udf_update_password(text, text);

CREATE OR REPLACE FUNCTION ova2.udf_update_password(user_identifier text, new_password text)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
DECLARE
    user_exists BOOLEAN;
BEGIN
    -- Check if the user exists by either email or phone
    SELECT EXISTS(
        SELECT 1 FROM ova2.tbl_registration
        WHERE email = user_identifier OR phone = user_identifier
    ) INTO user_exists;

    -- If user exists, update password
    IF user_exists THEN
        UPDATE ova2.tbl_registration
        SET "password" = new_password, modified_date = CURRENT_TIMESTAMP
        WHERE email = user_identifier OR phone = user_identifier;

        -- Return success status
        RETURN 'success';
    ELSE
        -- If user does not exist, return failure status
        RETURN 'User not found';
    END IF;
END;
$function$
;

-- DROP FUNCTION ova2.udf_update_user_data(jsonb);

CREATE OR REPLACE FUNCTION ova2.udf_update_user_data(p_user_data jsonb)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_registration_id integer;
BEGIN
    v_registration_id := (p_user_data->>'registration_id')::integer;

    IF v_registration_id IS NULL THEN
        RAISE EXCEPTION 'registration_id is required in the JSON parameter';
    END IF;

    UPDATE ova2.tbl_registration
    SET
        first_name = COALESCE(p_user_data->>'first_name', first_name),
        last_name = COALESCE(p_user_data->>'last_name', last_name),
        email = COALESCE(p_user_data->>'email', email),
        phone = COALESCE(p_user_data->>'phone', phone),
        password = COALESCE(p_user_data->>'password', password),
        address = COALESCE(p_user_data->>'address', address),
        role_id = COALESCE((p_user_data->>'role_id')::integer, role_id),
        registration_type_id = COALESCE((p_user_data->>'registration_type_id')::integer, registration_type_id),
        modified_date = NOW(),
        is_active = COALESCE((p_user_data->>'is_active')::boolean, is_active),
        is_deleted = COALESCE((p_user_data->>'is_deleted')::boolean, is_deleted),
        current_location = COALESCE(p_user_data->>'current_location', current_location),
        experience_in_years = COALESCE((p_user_data->>'experience_in_years')::integer, experience_in_years)
    WHERE registration_id = v_registration_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'User with registration_id % not found', v_registration_id;
    END IF;

    RETURN 'User updated successfully';
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

-- DROP FUNCTION ova2.udf_update_user_technologies(int4, text);

CREATE OR REPLACE FUNCTION ova2.udf_update_user_technologies(_registration_id integer, _technology_ids text)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
DECLARE
    updated_tech_array INT[]; -- Declare an array to hold parsed technology IDs
BEGIN
    -- Step 1: Delete existing mappings for the given registration_id if they exist
    DELETE FROM ova2.tbl_technology_mapping
    WHERE registration_id = _registration_id;
    

    -- Step 2: Convert the technology_ids (comma-separated) into an array
    updated_tech_array := string_to_array(_technology_ids, ',')::INT[];

    -- Step 3: Loop through the array and insert new mappings if they don't exist
    FOR i IN 1 .. array_length(updated_tech_array, 1) LOOP
        -- Insert only if the mapping doesn't already exist
        IF NOT EXISTS (
            SELECT 1 FROM ova2.tbl_technology_mapping
            WHERE registration_id = _registration_id
            AND technology_id = updated_tech_array[i]
        ) THEN
            INSERT INTO ova2.tbl_technology_mapping (registration_id, technology_id)
            VALUES (_registration_id, updated_tech_array[i]);
        END IF;
    END LOOP;

    -- Return a success message
    RETURN 'User technologies updated successfully.';
EXCEPTION
    WHEN OTHERS THEN
        -- Capture and return detailed error message
        RETURN 'An error occurred while updating user technologies: ' || SQLERRM;
END;
$function$
;