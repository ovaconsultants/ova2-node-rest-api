-- ova2.tbl_employee_salary definition

-- Drop table

-- DROP TABLE ova2.tbl_employee_salary;

CREATE TABLE ova2.tbl_employee_salary (
	id serial4 NOT NULL,
	employee_id int4 NULL,
	basic_salary int4 NOT NULL,
	da int4 NULL,
	ta int4 NULL,
	hra int4 NULL,
	gross_salary int4 GENERATED ALWAYS AS (basic_salary + COALESCE(da, 0) + COALESCE(ta, 0) + COALESCE(hra, 0)) STORED NULL,
	provident_fund int4 NULL,
	esi int4 NULL,
	tax int4 NULL,
	loan int4 NULL,
	total_deduction int4 GENERATED ALWAYS AS (COALESCE(provident_fund, 0) + COALESCE(esi, 0) + COALESCE(tax, 0) + COALESCE(loan, 0)) STORED NULL,
	net_salary int4 GENERATED ALWAYS AS (basic_salary + COALESCE(da, 0) + COALESCE(ta, 0) + COALESCE(hra, 0) - (COALESCE(provident_fund, 0) + COALESCE(esi, 0) + COALESCE(tax, 0) + COALESCE(loan, 0))) STORED NULL,
	pay_month varchar(20) NULL,
	bank_name varchar(100) NULL,
	bank_transaction varchar(100) NULL,
	created_date date DEFAULT CURRENT_DATE NOT NULL,
	CONSTRAINT tbl_employee_salary_pkey PRIMARY KEY (id),
	CONSTRAINT tbl_employee_salary_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES ova2.tbl_registration(registration_id)
);