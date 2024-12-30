-- ova2.tbl_employeeallocation definition

-- Drop table

-- DROP TABLE ova2.tbl_employeeallocation;

CREATE TABLE ova2.tbl_employeeallocation (
	id serial4 NOT NULL,
	employeename varchar(250) NOT NULL,
	CONSTRAINT tbl_employeeallocation_pkey PRIMARY KEY (id)
);