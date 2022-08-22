CREATE DATABASE medical_clinic;

CREATE TABLE patients (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth date
);

CREATE TABLE medical_histories (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    admitted_at TIMESTAMP NOT NULL,
    patient_id INT NOT NULL,
    status VARCHAR(50) NOT NULL,
    CONSTRAINT patient_fk FOREIGN KEY(patient_id) REFERENCES patients(id)
);

CREATE TABLE treatments (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    type VARCHAR(100),
    name VARCHAR(100) NOT NULL
);

CREATE TABLE treatment_histories (
    medical_history_id INT NOT NULL,
    treatment_id INT NOT NULL,
    CONSTRAINT medical_history_fk FOREIGN KEY(medical_history_id) REFERENCES medical_histories(id),
    CONSTRAINT treatment_fk FOREIGN KEY(treatment_id) REFERENCES treatments(id)
);

CREATE INDEX medical_history_idx ON treatment_histories(medical_history_id);
CREATE INDEX treatment_idx ON treatment_histories(treatment_id);

CREATE TABLE invoices(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    total_amount DECIMAL NOT NULL,
    generated_at TIMESTAMP NOT NULL,
    payed_at TIMESTAMP,
    medical_history_id INT NOT NULL,
    CONSTRAINT medical_history_fk FOREIGN KEY(medical_history_id) REFERENCES medical_histories(id)
);

CREATE TABLE invoice_items(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    unit_price DECIMAL NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL NOT NULL,
    invoice_id INT NOT NULL,
    treatment_id INT NOT NULL,
    CONSTRAINT invoice_fk FOREIGN KEY(invoice_id) REFERENCES invoices(id),
    CONSTRAINT treatment_fk FOREIGN KEY(treatment_id) REFERENCES treatments(id)
);

