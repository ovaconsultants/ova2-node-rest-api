-- ova2.tbl_communication_mediums definition

-- Drop table

-- DROP TABLE ova2.tbl_communication_mediums;

CREATE TABLE ova2.tbl_communication_mediums (
	id serial4 NOT NULL,
	medium varchar(255) NOT NULL,
	CONSTRAINT tbl_communication_mediums_pkey PRIMARY KEY (id)
);