-- ova2.tbl_company definition

-- Drop table

-- DROP TABLE ova2.tbl_company;

CREATE TABLE ova2.tbl_company (
	id int4 DEFAULT nextval('company_id_seq'::regclass) NOT NULL,
	company_name varchar(255) NOT NULL,
	contact_no varchar(15) NOT NULL,
	email_address varchar(255) NOT NULL,
	company_type_id int4 NULL,
	website_url varchar(255) NULL,
	"location" text NULL,
	established_year int4 NULL,
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
	CONSTRAINT company_pkey PRIMARY KEY (id)
);


-- ova2.tbl_company foreign keys

ALTER TABLE ova2.tbl_company ADD CONSTRAINT company_company_type_id_fkey FOREIGN KEY (company_type_id) REFERENCES ova2.tbl_company_type(id);