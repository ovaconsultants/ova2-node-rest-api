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