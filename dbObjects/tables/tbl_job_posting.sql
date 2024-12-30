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