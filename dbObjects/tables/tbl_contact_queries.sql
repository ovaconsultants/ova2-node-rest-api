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