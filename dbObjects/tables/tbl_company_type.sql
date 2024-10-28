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


-- ova2.tbl_company_type foreign keys