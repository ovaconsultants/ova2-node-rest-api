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