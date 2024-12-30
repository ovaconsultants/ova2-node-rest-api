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