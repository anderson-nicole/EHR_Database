USE oncology_clinic;

######################################################
#               Editing Functionalities				 # 
######################################################

-- when inserting a new progress note set the new one as the current plan in the problem record
DELIMITER |
CREATE TRIGGER current_plan_update
AFTER INSERT ON ProgressNote
FOR EACH ROW
BEGIN
    UPDATE ProblemList
    SET current_plan = NEW.progress_note_id 
    WHERE problem_id = NEW.problem_id;
END;

-- When dispensing medication, update the drug inventory as well to better monitor
CREATE TRIGGER update_drug_inventory
AFTER INSERT ON MedicationDispensingLog
FOR EACH ROW
BEGIN
    UPDATE DrugInventory
    SET instock = instock - NEW.quantity_dispensed
    WHERE drug_inventory_id = NEW.drug_inventory_id;
END;

DELIMITER ;

-- Test the triggers
INSERT INTO ProgressNote (mrn, problem_id, creation_date, assessment_by, subjective, objective, assessment, treatment_plan)
VALUES (1, 1, NOW(),2, 'Patient reports mild fatigue.',  'Vital signs stable; slight pallor observed.', 'Possible anemia; further tests recommended.', 'Start iron supplementation and schedule follow-up in 2 weeks.'
);

SELECT * FROM ProblemList WHERE problem_id = 1;


INSERT INTO MedicationDispensingLog (drug_inventory_id, quantity_dispensed, dispense_datetime, mrn)
VALUES (1, 5, NOW(), 1);

SELECT * FROM DrugInventory WHERE drug_inventory_id = 1;

######################################################
#				Searching Functions                  #							
######################################################

-- search by name
SELECT *
FROM Patients 
WHERE first_name = 'Madison' AND last_name = 'Karlicek' AND dob = '1969-9-16';

######################################################
#				Reporting Functions                  #							
######################################################

-- Get report of how may paitents have certain conditions
SELECT b.short_description AS diagnosed_conditions, COUNT(DISTINCT p.mrn) AS patient_count
FROM ProblemList l
JOIN Patients p 
	ON l.mrn = p.mrn
JOIN BillingCodes b
	ON b.specified_code = l.problem_code AND b.code_type = CONCAT('ICD-',l.problem_icd)
GROUP BY b.short_description
ORDER BY patient_count DESC; 

-- Get report of what appointments are for the day that need providers
SELECT a.appt_id, CONCAT(p.first_name,' ', p.last_name) as patient_name, CONCAT(d.first_name,' ',d.last_name, ' ',d.suffix) as provider_name, TIME(a.appt_datetime) AS appt_time, a.notes
FROM  Appointments a
	JOIN Patients p 
		ON a.mrn = p.mrn
	JOIN Providers d
		ON d.provider_id = a.provider_id
WHERE DATE(a.appt_datetime) = '2024-10-23'