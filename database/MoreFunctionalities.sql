USE oncology_clinic;
DROP PROCEDURE IF EXISTS GetPatientRecords;
DROP TRIGGER IF EXISTS audit_patient_insert;
DROP TRIGGER IF EXISTS audit_patient_update;
######################################################
#                  View Creations	     			 # 
######################################################
-- Create or Replace so that way when things refresh, it doesn't break and automaticay replaces it
	CREATE OR REPLACE VIEW AppointmentSchedule AS
	SELECT 
		TIME(a.appt_datetime) AS appointment_time,
		a.reason,
		CONCAT(d.first_name," ", COALESCE(d.middle_name,"")," ", d.last_name, COALESCE(CONCAT(", ",d.suffix),"")) AS provider,
		CONCAT(p.first_name, " ", p.last_name) AS patient,
        p.home_number AS patient_contact
	FROM Appointments a
	JOIN Providers d ON a.provider_id = d.provider_id
	JOIN Patients p ON a.mrn = p.mrn
    WHERE DATE(a.appt_datetime) = "2024-10-23"; -- Will say this is the current day but would use curent date in realtime 
    
    SELECT * FROM AppointmentSchedule;

-- View so that only orders relating to radiology is viewed 
	CREATE OR REPLACE VIEW RadiologyOrders AS
	SELECT
		o.order_id,
		o.mrn,
		CONCAT(p.first_name," ", COALESCE(p.middle_name,"")," ", p.last_name, COALESCE(CONCAT(", ",p.suffix),"")) AS ordered_by_name,  
		o.entry_date,
		o.last_update,
		o.priority,
		o.order_type,
		o.results_id,
		o.notes
	FROM
		Orders o
	JOIN
		Providers p ON o.ordered_by = p.provider_id
	WHERE
		o.order_type = 3 AND o.completion_date IS NULL  -- Radiology here is represented by 3
	ORDER BY o.priority;
    
    SELECT * FROM RadiologyOrders;

######################################################
#                 Stored Procedures  				 # 
######################################################

#REF: https://dev.mysql.com/doc/refman/8.4/en/create-procedure.html

Delimiter ||
CREATE PROCEDURE GetPatientRecords(IN patient_mrn INT) 
BEGIN
    SELECT * FROM Patients WHERE mrn = patient_mrn ;
    SELECT * FROM Insurance WHERE mrn = patient_mrn;
    SELECT * FROM SocialHistory WHERE mrn = patient_mrn;
    SELECT * FROM FamilyHistory WHERE mrn = patient_mrn;
    SELECT * FROM ProblemList WHERE mrn = patient_mrn;
    SELECT * FROM ProgressNote WHERE mrn = patient_mrn;
    SELECT * FROM Notes WHERE mrn = patient_mrn;
    SELECT * FROM TreatmentHistory WHERE mrn = patient_mrn;
    SELECT * FROM ReviewOfSystems WHERE mrn = patient_mrn;
    SELECT * FROM Basics WHERE mrn = patient_mrn;
    SELECT * FROM PhysicalExams WHERE mrn = patient_mrn;
    SELECT * FROM SurgicalHistory WHERE mrn = patient_mrn;
    SELECT * FROM Prescriptions WHERE mrn = patient_mrn;
    SELECT * FROM NonPrescribedMedications WHERE mrn = patient_mrn;
    SELECT * FROM PathologyReport WHERE mrn = patient_mrn;
    SELECT * FROM RadiologyReport WHERE mrn = patient_mrn;
    SELECT * FROM AdditionalReports WHERE mrn = patient_mrn;
END||

Delimiter;

CALL GetPatientRecords(1);

######################################################
#               Auditing Log Triggers				 # 
######################################################
DELIMITER ||
	-- Patient
	CREATE TRIGGER audit_patient_insert
	AFTER INSERT ON Patients
	FOR EACH ROW 
	BEGIN
		INSERT INTO AuditLog (action_date, mrn, actor, action_taken, action_table)
		VALUES (NOW(), NEW.mrn, 524044016466, 'INSERT', 'Patients'); -- no new data as the new data is recored by the MRN and the record itself without any changes is the implied new data. 
	END||
    

	CREATE TRIGGER audit_patient_update
	AFTER UPDATE ON Patients
	FOR EACH ROW
	BEGIN
		IF OLD.first_name <> NEW.first_name THEN
			INSERT INTO AuditLog (
				action_date, 
				mrn, 
				actor, 
				action_taken, 
				action_table, 
				action_field, 
				old_data, 
				new_data
			)
			VALUES (
				NOW(), 
				OLD.mrn, 
				524044016466, 
				'UPDATE', 
				'Patients', 
				'first_name', 
				OLD.first_name, 
				NEW.first_name
			);
		END IF;

		IF OLD.middle_name <> NEW.middle_name THEN
			INSERT INTO AuditLog (
				action_date, 
				mrn, 
				actor, 
				action_taken, 
				action_table, 
				action_field, 
				old_data, 
				new_data
			)
			VALUES (
				NOW(), 
				OLD.mrn, 
				524044016466, 
				'UPDATE', 
				'Patients', 
				'middle_name', 
				OLD.middle_name, 
				NEW.middle_name
			);
		END IF;

		IF OLD.last_name <> NEW.last_name THEN
			INSERT INTO AuditLog (
				action_date, 
				mrn, 
				actor, 
				action_taken, 
				action_table, 
				action_field, 
				old_data, 
				new_data
			)
			VALUES (
				NOW(), 
				OLD.mrn, 
				524044016466, 
				'UPDATE', 
				'Patients', 
				'last_name', 
				OLD.last_name, 
				NEW.last_name
			);
		END IF;

		IF OLD.sex <> NEW.sex THEN
			INSERT INTO AuditLog (
				action_date, 
				mrn, 
				actor, 
				action_taken, 
				action_table, 
				action_field, 
				old_data, 
				new_data
			)
			VALUES (
				NOW(), 
				OLD.mrn, 
				524044016466, 
				'UPDATE', 
				'Patients', 
				'sex', 
				OLD.sex, 
				NEW.sex
			);
		END IF;

		IF OLD.gender <> NEW.gender THEN
			INSERT INTO AuditLog (
				action_date, 
				mrn, 
				actor, 
				action_taken, 
				action_table, 
				action_field, 
				old_data, 
				new_data
			)
			VALUES (
				NOW(), 
				OLD.mrn, 
				524044016466, 
				'UPDATE', 
				'Patients', 
				'gender', 
				OLD.gender, 
				NEW.gender
			);
		END IF;

		IF OLD.address_line1 <> NEW.address_line1 THEN
			INSERT INTO AuditLog (
				action_date, 
				mrn, 
				actor, 
				action_taken, 
				action_table, 
				action_field, 
				old_data, 
				new_data
			)
			VALUES (
				NOW(), 
				OLD.mrn, 
				524044016466, 
				'UPDATE', 
				'Patients', 
				'address_line1', 
				OLD.address_line1, 
				NEW.address_line1
			);
		END IF;

		IF OLD.address_line2 <> NEW.address_line2 THEN
			INSERT INTO AuditLog (
				action_date, 
				mrn, 
				actor, 
				action_taken, 
				action_table, 
				action_field, 
				old_data, 
				new_data
			)
			VALUES (
				NOW(), 
				OLD.mrn, 
				5524044016466, 
				'UPDATE', 
				'Patients', 
				'address_line2', 
				OLD.address_line2, 
				NEW.address_line2
			);
		END IF;

		IF OLD.city <> NEW.city THEN
			INSERT INTO AuditLog (
				action_date, 
				mrn, 
				actor, 
				action_taken, 
				action_table, 
				action_field, 
				old_data, 
				new_data
			)
			VALUES (
				NOW(), 
				OLD.mrn, 
				524044016466, 
				'UPDATE', 
				'Patients', 
				'city', 
				OLD.city, 
				NEW.city
			);
		END IF;

		IF OLD.state <> NEW.state THEN
			INSERT INTO AuditLog (
				action_date, 
				mrn, 
				actor, 
				action_taken, 
				action_table, 
				action_field, 
				old_data, 
				new_data
			)
			VALUES (
				NOW(), 
				OLD.mrn, 
				524044016466, 
				'UPDATE', 
				'Patients', 
				'state', 
				OLD.state, 
				NEW.state
			);
		END IF;

		IF OLD.zipcode <> NEW.zipcode THEN
			INSERT INTO AuditLog (
				action_date, 
				mrn, 
				actor, 
				action_taken, 
				action_table, 
				action_field, 
				old_data, 
				new_data
			)
			VALUES (
				NOW(), 
				OLD.mrn, 
				524044016466, 
				'UPDATE', 
				'Patients', 
				'zipcode', 
				OLD.zipcode, 
				NEW.zipcode
			);
		END IF;

		IF OLD.home_number <> NEW.home_number THEN
			INSERT INTO AuditLog (
				action_date, 
				mrn, 
				actor, 
				action_taken, 
				action_table, 
				action_field, 
				old_data, 
				new_data
			)
			VALUES (
				NOW(), 
				OLD.mrn, 
				524044016466, 
				'UPDATE', 
				'Patients', 
				'home_number', 
				OLD.home_number, 
				NEW.home_number
			);
		END IF;

		IF OLD.cell_number <> NEW.cell_number THEN
			INSERT INTO AuditLog (
				action_date, 
				mrn, 
				actor, 
				action_taken, 
				action_table, 
				action_field, 
				old_data, 
				new_data
			)
			VALUES (
				NOW(), 
				OLD.mrn, 
				524044016466, 
				'UPDATE', 
				'Patients', 
				'cell_number', 
				OLD.cell_number, 
				NEW.cell_number
			);
		END IF;

		IF OLD.work_number <> NEW.work_number THEN
			INSERT INTO AuditLog (
				action_date, 
				mrn, 
				actor, 
				action_taken, 
				action_table, 
				action_field, 
				old_data, 
				new_data
			)
			VALUES (
				NOW(), 
				OLD.mrn, 
				524044016466, 
				'UPDATE', 
				'Patients', 
				'work_number', 
				OLD.work_number, 
				NEW.work_number
			);
		END IF;

		IF OLD.email <> NEW.email THEN
			INSERT INTO AuditLog (
				action_date, 
				mrn, 
				actor, 
				action_taken, 
				action_table, 
				action_field, 
				old_data, 
				new_data
			)
			VALUES (
				NOW(), 
				OLD.mrn, 
				524044016466, 
				'UPDATE', 
				'Patients', 
				'email', 
				OLD.email, 
				NEW.email
			);
		END IF;

		IF OLD.emergency_contact <> NEW.emergency_contact THEN
			INSERT INTO AuditLog (
				action_date, 
				mrn, 
				actor, 
				action_taken, 
				action_table, 
				action_field, 
				old_data, 
				new_data
			)
			VALUES (
				NOW(), 
				OLD.mrn, 
				524044016466, 
				'UPDATE', 
				'Patients', 
				'emergency_contact', 
				OLD.emergency_contact, 
				NEW.emergency_contact
			);
		END IF;

		IF OLD.emergency_contact_number <> NEW.emergency_contact_number THEN
			INSERT INTO AuditLog (
				action_date, 
				mrn, 
				actor, 
				action_taken, 
				action_table, 
				action_field, 
				old_data, 
				new_data
			)
			VALUES (
				NOW(), 
				OLD.mrn, 
				524044016466, 
				'UPDATE', 
				'Patients', 
				'emergency_contact_number', 
				OLD.emergency_contact_number, 
				NEW.emergency_contact_number
			);
		END IF;

		IF OLD.primary_language <> NEW.primary_language THEN
			INSERT INTO AuditLog (
				action_date, 
				mrn, 
				actor, 
				action_taken, 
				action_table, 
				action_field, 
				old_data, 
				new_data
			)
			VALUES (
				NOW(), 
				OLD.mrn, 
				524044016466, 
				'UPDATE', 
				'Patients', 
				'primary_language', 
				OLD.primary_language, 
				NEW.primary_language
			);
		END IF;

		IF OLD.perferred_pharmacy_id <> NEW.perferred_pharmacy_id THEN
			INSERT INTO AuditLog (
				action_date, 
				mrn, 
				actor, 
				action_taken, 
				action_table, 
				action_field, 
				old_data, 
				new_data
			)
			VALUES (
				NOW(), 
				OLD.mrn, 
				524044016466, 
				'UPDATE', 
				'Patients', 
				'perferred_pharmacy_id', 
				OLD.perferred_pharmacy_id, 
				NEW.perferred_pharmacy_id
			);
		END IF;

		IF OLD.living_status <> NEW.living_status THEN
			INSERT INTO AuditLog (
				action_date, 
				mrn, 
				actor, 
				action_taken, 
				action_table, 
				action_field, 
				old_data, 
				new_data
			)
			VALUES (
				NOW(), 
				OLD.mrn, 
				524044016466, 
				'UPDATE', 
				'Patients', 
				'living_status', 
				OLD.living_status, 
				NEW.living_status
			);
		END IF;

		IF OLD.dnr <> NEW.dnr THEN
			INSERT INTO AuditLog (
				action_date, 
				mrn, 
				actor, 
				action_taken, 
				action_table, 
				action_field, 
				old_data, 
				new_data
			)
			VALUES (
				NOW(), 
				OLD.mrn, 
				488841664919, 
				'UPDATE', 
				'Patients', 
				'dnr', 
				OLD.dnr, 
				NEW.dnr
			);
		END IF;

		IF OLD.blood_type <> NEW.blood_type THEN
			INSERT INTO AuditLog (
				action_date, 
				mrn, 
				actor, 
				action_taken, 
				action_table, 
				action_field, 
				old_data, 
				new_data
			)
			VALUES (
				NOW(), 
				OLD.mrn, 
				488841664919, 
				'UPDATE', 
				'Patients', 
				'blood_type', 
				OLD.blood_type, 
				NEW.blood_type
			);
		END IF;

	END;
||
DELIMITER ;


INSERT INTO Patients (first_name, middle_name, last_name, dob, sex, gender, address_line1, address_line2, city, state, zipcode, home_number, cell_number, work_number, email, emergency_contact, emergency_contact_number, primary_language, perferred_pharmacy_id, living_status, dnr, blood_type)
VALUES (
    'John', 'A.', 'Doe', '1980-01-01', 'Male', 'Male', '123 Main St', 'Apt 4B', 'Springfield', 'IL', '62701', '217-555-1234', '217-555-5678', '217-555-8765', 'john.doe@example.com', 'Jane Doe', '217-555-4321', 'English', 12, 'Alive', 'No', 'O+'
);

SELECT * FROM AuditLog;

UPDATE Patients
SET
    address_line1 = '156 Not Main Street',
    address_line2 = NULL,
    city =  "Charlotte",
    state = "NC",
    zipcode = "28262"
WHERE
    mrn = 18;
    
EXPLAIN SELECT * FROM AuditLog;




