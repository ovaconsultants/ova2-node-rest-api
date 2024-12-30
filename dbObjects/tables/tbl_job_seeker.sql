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