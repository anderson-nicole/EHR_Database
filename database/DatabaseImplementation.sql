/* Create Database and Set as Default */
	DROP DATABASE IF EXISTS oncology_clinic;
	CREATE DATABASE IF NOT EXISTS oncology_clinic ;
	USE oncology_clinic;
    
########################################################
#                Reference Tables        			   #
########################################################
	
    -- Specialty Table will be used to reference to what specialty a provider is. 
	CREATE TABLE Specialty(
		specialty_id INT PRIMARY KEY AUTO_INCREMENT,
		specialty_name VARCHAR(50)
	);
    
    INSERT INTO Specialty (specialty_name)
	VALUES
		('Allergy and Immunology'),
		('Anesthesiology'), 
		('Dermatology'), 
		('Diagnostic Radiology'), 
		('Emergency Medicine'), 
		('Family Medicine'), 
		('Internal Medicine'), 
		('Medical Genetics'), 
		('Neurology'), 
		('Nuclear Medicine'),
		('Obstetrics and Gynecology'), 
		('Ophthalmology'), 
		('Pathology'), 
		('Pediatrics'), 
		('Physical Medicine and Rehabilitation'), 
		('Preventive Medicine'), 
		('Psychiatry'), 
		('Radiation Oncology'),
		('Surgery Urology')
	;
    
    -- What do the standardized codes utilized mean    
	CREATE TABLE BillingCodes(
		code_type ENUM("ICD-9","ICD-10","CPT-4"), -- save space by referring to abbreviations. What type of code is is such as ICD, CPT, etc. 
		specified_code VARCHAR(20), -- Actual code 
		short_description VARCHAR(100), -- What is the code referring to. 
        long_description varchar(150),
        CONSTRAINT PRIMARY KEY(code_type,specified_code)
	);
    
    INSERT INTO BillingCodes(code_type, specified_code, short_description, long_description)
    VALUES 
		('ICD-9', '250.00', 'Diabetes mellitus without mention of complication', 'Diabetes mellitus without mention of complication, type II or unspecified type, not stated as uncontrolled'),
		('ICD-9', '401.9', 'Essential hypertension, unspecified', 'Essential hypertension, unspecified'),
		('ICD-9', '530.81', 'Esophageal reflux', 'Esophageal reflux (GERD)'),
		('ICD-9', '414.01', 'Coronary atherosclerosis', 'Coronary atherosclerosis of native coronary artery'),
		('ICD-9', '486', 'Pneumonia, organism unspecified', 'Pneumonia, organism unspecified'),
		('ICD-9', '715.90', 'Osteoarthritis, unspecified', 'Osteoarthritis of unspecified site'),
		('ICD-9', '733.00', 'Osteoporosis, unspecified', 'Osteoporosis, unspecified'),
		('ICD-9', '780.79', 'Other malaise and fatigue', 'Other malaise and fatigue'),
		('ICD-9', '530.11', 'Reflux esophagitis', 'Reflux esophagitis'),
		('ICD-9', '250.60', 'Diabetes with neurological manifestations', 'Diabetes with neurological manifestations, type II or unspecified type, not stated as uncontrolled'),
        ('ICD-9', '174.9', 'Malignant neoplasm of breast', 'Malignant neoplasm of female breast, unspecified site'),
		('ICD-9', '162.9', 'Malignant neoplasm of lung', 'Malignant neoplasm of bronchus and lung, unspecified'),
		('ICD-9', '153.9', 'Malignant neoplasm of colon', 'Malignant neoplasm of colon, unspecified'),
		('ICD-9', '188.9', 'Malignant neoplasm of bladder', 'Malignant neoplasm of bladder, part unspecified'),
		('ICD-9', '198.5', 'Secondary malignant neoplasm of bone and bone marrow', 'Secondary malignant neoplasm of bone and bone marrow'),
		('ICD-9', '208.90', 'Leukemia, unspecified, without mention of remission', 'Unspecified leukemia without mention of remission'),
		('ICD-9', '185', 'Malignant neoplasm of prostate', 'Malignant neoplasm of prostate'),
		('ICD-9', '191.9', 'Malignant neoplasm of brain, unspecified', 'Malignant neoplasm of brain, unspecified'),
		('ICD-9', '180.9', 'Malignant neoplasm of cervix uteri', 'Malignant neoplasm of cervix uteri, unspecified'),
		('ICD-9', '200.20', 'Burkitt’s lymphoma', 'Burkitt’s tumor or lymphoma, unspecified sites'),
		('ICD-10', 'E11.9', 'Type 2 diabetes mellitus without complications', 'Type 2 diabetes mellitus without complications'),
		('ICD-10', 'I10', 'Essential (primary) hypertension', 'Essential (primary) hypertension'),
		('ICD-10', 'K21.9', 'Gastro-esophageal reflux disease without esophagitis', 'Gastro-esophageal reflux disease without esophagitis'),
		('ICD-10', 'I25.10', 'Atherosclerotic heart disease', 'Atherosclerotic heart disease of native coronary artery without angina pectoris'),
		('ICD-10', 'J18.9', 'Pneumonia, unspecified organism', 'Pneumonia, unspecified organism'),
		('ICD-10', 'M19.90', 'Osteoarthritis, unspecified site', 'Osteoarthritis, unspecified site'),
		('ICD-10', 'M81.0', 'Osteoporosis without current pathological fracture', 'Age-related osteoporosis without current pathological fracture'),
		('ICD-10', 'R53.83', 'Other fatigue', 'Other fatigue'),
		('ICD-10', 'K21.0', 'Gastro-esophageal reflux disease with esophagitis', 'Gastro-esophageal reflux disease with esophagitis'),
		('ICD-10', 'E11.42', 'Type 2 diabetes mellitus with polyneuropathy', 'Type 2 diabetes mellitus with diabetic polyneuropathy'),
		('ICD-10', 'C50.919', 'Malignant neoplasm of unspecified site of female breast', 'Malignant neoplasm of unspecified site of unspecified female breast'),
		('ICD-10', 'C34.90', 'Malignant neoplasm of unspecified part of bronchus or lung', 'Malignant neoplasm of unspecified part of bronchus or lung, unspecified side'),
		('ICD-10', 'C18.9', 'Malignant neoplasm of colon, unspecified', 'Malignant neoplasm of colon, unspecified'),
		('ICD-10', 'C67.9', 'Malignant neoplasm of bladder, unspecified', 'Malignant neoplasm of bladder, unspecified'),
		('ICD-10', 'C79.51', 'Secondary malignant neoplasm of bone', 'Secondary malignant neoplasm of bone'),
		('ICD-10', 'C95.90', 'Leukemia, unspecified, not having achieved remission', 'Leukemia, unspecified, not having achieved remission'),
		('ICD-10', 'C61', 'Malignant neoplasm of prostate', 'Malignant neoplasm of prostate'),
		('ICD-10', 'C71.9', 'Malignant neoplasm of brain, unspecified', 'Malignant neoplasm of brain, unspecified'),
		('ICD-10', 'C53.9', 'Malignant neoplasm of cervix uteri, unspecified', 'Malignant neoplasm of cervix uteri, unspecified'),
		('ICD-10', 'C83.79', 'Burkitt lymphoma, unspecified site', 'Burkitt lymphoma, unspecified site'),
		('CPT-4', '96413', 'Chemotherapy administration, intravenous infusion', 'Chemotherapy administration, intravenous infusion, up to 1 hour'),
		('CPT-4', '77385', 'Radiation therapy, intensity modulated', 'Intensity modulated radiation treatment delivery (IMRT), includes guidance'),
		('CPT-4', '77014', 'CT guidance for placement of radiation therapy fields', 'Computed tomography guidance for placement of radiation therapy fields'),
		('CPT-4', '77261', 'Radiation therapy treatment planning, simple', 'Therapeutic radiology treatment planning; simple'),
		('CPT-4', '88305', 'Level IV surgical pathology, gross and microscopic examination', 'Level IV surgical pathology, including gross and microscopic examination'),
		('CPT-4', '96409', 'Chemotherapy administration, IV push, single drug', 'Chemotherapy administration, intravenous push technique, single drug'),
		('CPT-4', '77336', 'Radiation physics consultation', 'Continuing medical physics consultation, radiation therapy'),
		('CPT-4', '77049', 'Breast MRI with and without contrast', 'Magnetic resonance imaging (MRI) of breast with and without contrast'),
		('CPT-4', '96367', 'Intravenous infusion for therapy, additional sequential', 'Intravenous infusion, for therapy or prophylaxis, additional sequential infusion of a new drug or substance'),
		('CPT-4', '38792', 'Injection procedure for identification of sentinel node', 'Injection procedure for identification of sentinel node, includes injection of non-radioactive dye'),
		('CPT-4', '99213', 'Office or other outpatient visit', 'Office or other outpatient visit for the evaluation and management of an established patient'),
		('CPT-4', '99214', 'Office visit, established patient, moderate complexity', 'Office or other outpatient visit for the evaluation and management of an established patient, moderate complexity'),
		('CPT-4', '99395', 'Periodic comprehensive preventive evaluation', 'Periodic comprehensive preventive evaluation and management, established patient'),
		('CPT-4', '99441', 'Telephone evaluation and management service', 'Telephone evaluation and management service provided by a physician to an established patient, 5-10 minutes'),
		('CPT-4', '93000', 'Electrocardiogram, routine', 'Electrocardiogram, routine ECG with at least 12 leads; interpretation and report only'),
		('CPT-4', '80053', 'Comprehensive metabolic panel', 'Comprehensive metabolic panel'),
		('CPT-4', '81001', 'Urinalysis, automated', 'Urinalysis, automated, with microscopy'),
		('CPT-4', '84443', 'Thyroid stimulating hormone test', 'Thyroid stimulating hormone (TSH) test'),
		('CPT-4', '82947', 'Glucose, quantitative', 'Glucose; quantitative, blood'),
		('CPT-4', '85025', 'Complete blood count', 'Complete blood count with differential white blood cell count');
    
    -- What NDC goes with what drug
    CREATE TABLE NDC(
		ndc VARCHAR(20) PRIMARY KEY,
        brand_name VARCHAR(50), -- can be null if its only the generic name
        generic_name VARCHAR(50) NOT NULL,
        form VARCHAR(25) NOT NULL,
        strength VARCHAR(25) NOT NULL,
        route VARCHAR(25),
        dea_class VARCHAR(25)
    ); 
    
    INSERT INTO NDC(ndc, brand_name, generic_name, form, strength, route, dea_class) 
    VALUES
		('50242-060-01', 'Avastin', 'Bevacizumab', 'Injection', '100 mg/4 mL', 'Intravenous', NULL),
		('0703-3645-01', NULL, 'Cisplatin', 'Injection', '1 mg/mL', 'Intravenous', NULL),
		('0075-8001-01', 'Taxotere', 'Docetaxel', 'Injection', '20 mg/2 mL', 'Intravenous', NULL),
		('0013-7286-01', 'Adriamycin', 'Doxorubicin', 'Injection', '50 mg/25 mL', 'Intravenous', NULL),
		('0006-3026-02', 'Keytruda', 'Pembrolizumab', 'Injection', '100 mg/4 mL', 'Intravenous', NULL),
		('0015-3464-11', 'Taxol', 'Paclitaxel', 'Injection', '30 mg/5 mL', 'Intravenous', NULL),
		('50242-013-01', 'Herceptin', 'Trastuzumab', 'Injection', '150 mg', 'Intravenous', NULL),
		('0015-3201-11', NULL, 'Cyclophosphamide', 'Injection', '500 mg', 'Intravenous', NULL),
		('223-344-556', 'Zestril', 'Lisinopril', 'Tablet', '10 mg', 'Oral', NULL),
		('334-455-667', 'Glucophage', 'Metformin', 'Tablet', '500 mg', 'Oral', NULL),
		('445-566-778', 'Lipitor', 'Atorvastatin', 'Tablet', '20 mg', 'Oral', NULL),
		('556-677-889', 'Advil', 'Ibuprofen', 'Tablet', '600 mg', 'Oral', NULL),
		('667-788-990', 'Zyrtec', 'Cetirizine', 'Tablet', '10 mg', 'Oral', NULL),
		('778-899-001', 'Prilosec', 'Omeprazole', 'Capsule', '20 mg', 'Oral', NULL),
		('889-900-112', 'Zoloft', 'Sertraline', 'Tablet', '50 mg', 'Oral', NULL),
		('990-011-223', 'Synthroid', 'Levothyroxine', 'Tablet', '100 mcg', 'Oral', NULL),
		('101-112-223', 'Amoxil', 'Amoxicillin', 'Capsule', '500 mg', 'Oral', NULL),
		('121-314-225', 'Aleve', 'Naproxen', 'Tablet', '250 mg', 'Oral', NULL);
        
###############################################################
#                        Basic Tables                         #
###############################################################
	
    -- Facilities that may be related to paitent care 
	CREATE Table Facilities(
		facility_id INT PRIMARY KEY AUTO_INCREMENT,
		facility_name VARCHAR(100),
        facility_type VARCHAR(50), 
		address_line1 VARCHAR(100),
        address_line2 VARCHAR(100),
		city VARCHAR(50),
		state VARCHAR(2),
		zipcode VARCHAR(6),
		phone_number VARCHAR(15),
		fax_number VARCHAR(15),
		email VARCHAR(255)
	);
    
	INSERT INTO Facilities( facility_id, facility_name,facility_type, address_line1, address_line2, city,state,zipcode,phone_number,fax_number,email)
    VALUES (1,'Johns, Veum and Kuvalis', 'Primary Care', '1709 Gerald Hill', '19th Floor', 'Omaha', 'NE', '68105', '402-974-0377', '901-825-3119', 'rgorsse0@tuttocitta.it'),
		   (2,'Yundt, Balistreri and Jacobi', 'ENT', '44 Dayton Road', '3rd Floor', 'Atlanta', 'GA', '31136', '404-836-9323', '785-761-4288', 'rruppelin1@istockphoto.com'),
           (3,'Crist, Gerhold and Wolf', 'Gastroenterology', '68 Forest Road', 'Suite 32', 'Lubbock', 'TX', '79405', '806-371-3234', '312-171-1792', 'jzanre2@wsj.com'),
		   (4,'Walker Inc', 'Dermatology', '0 Macpherson Alley', '9th Floor', 'Santa Monica', 'CA', '90405', '310-624-6959', '323-399-7466', 'hprugel3@youku.com'),
           (5,'Schmitt Group', 'Orthopedics', '097 Clarendon Pass', 'Apt 512', 'Dallas', 'TX', '75265', '214-128-3860', '602-236-0749', 'mianitti4@cbsnews.com'),
           (6,'Lowe, Schmitt and Leffler', 'Cardiology', '23609 Mallard Parkway', '16th Floor', 'Sarasota', 'FL', '34233', '941-714-7746', '205-150-1271', 'mskuse5@slideshare.net'),
           (7,'Hermann LLC', 'Pediatrics', '23336 Bluejay Hill', '9th Floor', 'Flint', 'MI', '48555', '810-713-6852', '215-754-9287', 'ltschirschky6@senate.gov'),
           (8,'Kunze-Donnelly', 'Ophthalmology', '56846 Corscot Hill', 'PO Box 36765', 'Chula Vista', 'CA', '91913', '619-662-0134', '208-214-9008', 'mkillgus7@umich.edu'),
           (9,'Klein and Sons', 'Urology', '04 Gerald Plaza', 'Apt 160', 'Pittsburgh', 'PA', '15220', '412-361-8505', '646-643-8935', 'vadamski8@sphinn.com'),
           (10,'Hahn-O''Keefe', 'Neurology', '0375 Claremont Junction', 'Room 600', 'Arlington', 'VA', '22244', '571-551-7750', '716-161-0257', 'grudeforth9@ucsd.edu');
	
    CREATE TABLE Pharmacies(
		pharmacy_id INT PRIMARY KEY AUTO_INCREMENT,
		pharmacy_name VARCHAR(100),
		address_line1 VARCHAR(100),
        address_line2 VARCHAR(100),
		city VARCHAR(50),
		state VARCHAR(2),
		zipcode VARCHAR(6),
		phone_number VARCHAR(15),
		fax_number VARCHAR(15),
		email VARCHAR(255)
	);
    
	INSERT INTO Pharmacies(pharmacy_id, pharmacy_name, address_line1, address_line2, city, state, zipcode,phone_number, fax_number,email)
    VALUES
		(11,'CVS Store 22', '0377 Claremont Junction', NULL, 'Arlington', 'VA', '75391', '159-753-4862', '285-698-4325', 'location22@cvs.com'),
        (12,'Walgreens', '0379 Claremont Junction', NULL, 'Arlington', 'VA', '46825', '589-654-9514', '165-1658-5698', 'location48@walgreens.com');
        
    -- Patients: Table to store basic patient information
    CREATE TABLE Patients(
		mrn INT PRIMARY KEY AUTO_INCREMENT, -- Unique patient identification number
		first_name VARCHAR(50) NOT NULL, -- Reqired as its one of the main question you ask paitents to ensure you have the right person 
		middle_name VARCHAR(50),
		last_name VARCHAR(50) NOT NULL, -- Reqired as its one of the main question you ask paitents to ensure you have the right person 
		dob DATE NOT NULL, -- Date of Birth. Reqired as its one of the main question you ask paitents to ensure you have the right person 
		sex ENUM("Male","Female"), -- Biological Sex of the paitent
		gender VARCHAR(10), -- Gender orientation of the patient
		address_line1 VARCHAR(100),
        address_line2 VARCHAR(100),
		city VARCHAR(50),
		state VARCHAR(13),
		zipcode VARCHAR(20),
		home_number VARCHAR(15),
		cell_number VARCHAR(15),
		work_number VARCHAR(15),
		email VARCHAR(255), 
		emergency_contact VARCHAR(50),
		emergency_contact_number VARCHAR(15),
        primary_language VARCHAR(255),
        perferred_pharmacy_id INT, -- pharmacy they will want presciptions sent to usually
		living_status ENUM("Alive","Deceased"), -- Is the patient alive or deceased. Can't/Shouldn't delete records so would be good to keep if using for aggregation to know you are looking at only living patients or deceased 
        dnr ENUM("Yes","No"), -- Do Not Resuscitate status
        blood_type ENUM("A+","B+","AB+","O+","A-","B-","AB-","O-"),
        
        FOREIGN KEY (perferred_pharmacy_id) REFERENCES Pharmacies(pharmacy_id)
    );
    
	INSERT INTO Patients(first_name, middle_name, last_name, dob, sex, gender, address_line1, address_line2, city, state, zipcode, home_number, cell_number, work_number, email, emergency_contact, emergency_contact_number, primary_language, perferred_pharmacy_id, living_status, dnr, blood_type) 
	VALUES
		('Madison', null, 'Karlicek', '1969-9-16', 'Male', 'Male', '7011 Nelson Avenue', null, 'Des Moines', 'IA', '50362', '515-999-3305', '682-288-7997', null, 'mkarlicek0@walmart.com', 'Madison Karlicek', '502-702-0159', 'English', 12, 'Alive', 'Yes', 'A+'),
        ('Tera', null, 'Parrott', '1969-6-9', 'Female', null, '485 Prentice Street', '14th Floor', 'Phoenix', 'AZ', '85083', '602-468-4764', '859-840-9734', '714-716-7089', 'tparrott1@cmu.edu', 'Tera Parrott', '520-299-9062', 'English', 11, 'Alive', 'Yes', 'A+'),
        ('Patrice', null, 'Antrag', '1993-5-17', 'Female', null, '104 Kennedy Trail', null, 'Sioux Falls', 'SD', '57110', '605-900-8324', '952-888-5345', '413-328-9404', 'pantrag2@drupal.org', 'Patrice Antrag', '516-758-1263', 'English', 11, 'Alive', 'No', 'B-'),
        ('Eliza', null, 'Allington', '1977-3-28', 'Female', 'Bigender', '67 Nova Avenue', null, 'Lexington', 'KY', '40515', '859-730-8608', '850-553-7068', null, 'eallington3@odnoklassniki.ru', 'Eliza Allington', '901-324-8973', 'Spanish', 11, 'Alive', 'No', 'O+'),
        ('Annabelle', null, 'Mulberry', '1975-12-19', 'Female', 'Female', '74339 Miller Park', 'Room 1299', 'Young America', 'MN', '55564', '952-472-2407', '512-268-8429', null, 'amulberry4@google.nl', 'Annabelle Mulberry', '214-774-5827', 'English', 11, 'Alive', 'No', 'A+'),
        ('Chlo', null, 'Alcock', '1969-6-9', 'Male', 'Female', '5 Pennsylvania Plaza', null, 'Kansas City', 'MO', '64101', '816-396-5456', null, null, 'calcock6@bluehost.com', 'Chlo Alcock', '805-136-6007', 'English', 12, 'Deceased', 'Yes', 'A+'),
        ('Myrna', null, 'Hyslop', '1969-6-9', 'Female', 'Female', '1 Hovde Lane', null, 'Shawnee Mission', 'KS', '66276', '913-638-2305', '336-346-8445', null, 'mhyslop8@loc.gov', 'Myrna Hyslop', '941-887-7771', 'English', 12, 'Alive', 'No', 'A+'),
        ('Jemimah', null, 'Toppin', '1970-8-22', 'Female', 'Female', '8044 Schurz Junction', 'Apt 1269', 'San Luis Obispo', 'CA', '93407', '805-262-1990', '512-475-8755', '972-761-8661', 'jtoppin9@constantcontact.com', 'Jemimah Toppin', '916-193-3772', 'English', 12, 'Alive', 'No', 'A+'),
        ('Bridie', null, 'Bebb', '1975-12-19', 'Male', 'Male', '0747 Mallory Crossing', null, 'Salem', 'OR', '97306', '503-336-1056', '214-668-6113', '605-480-9531', 'bbebba@example.com', 'Bridie Bebb', '904-664-0892', 'English', 12, 'Alive', 'No', 'AB-'),
		('Ethe', null, 'Dybald', '1970-3-23', 'Female', 'Female', '17988 Magdeline Junction', null, 'Lincoln', 'NE', '68524', '402-232-5615', '405-536-3797', null, 'edybaldb@wired.com', 'Ethe Dybald', '337-566-7311', 'English', 12, 'Alive', 'No', 'AB+'),
		('Winslow', null, 'Waywell', '1969-6-9', 'Female', 'Female', '59 Nova Junction', null, 'Phoenix', 'AZ', '85077', '602-144-3903', '508-861-4509', null, 'wwaywellc@cam.ac.uk', 'Winslow Waywell', '334-429-8938', 'English', 12, 'Alive', 'No', 'B+'),
		('Brianna', null, 'Edgson', '1985-12-24', 'Male', 'Female', '5175 Warbler Terrace', null, 'Dallas', 'TX', '75260', '214-864-0969', '706-487-6342', null, 'bedgsond@geocities.com', 'Brianna Edgson', '540-743-3923', 'English', 11, 'Alive', null, 'A+'),
		('Dulce', 'R', 'Enevoldsen', '1969-6-9', 'Female', 'Female', '0567 Lake View Crossing', 'PO Box 79578', 'Sacramento', 'CA', '94250', '916-148-2500', '469-385-2269', null, 'denevoldsene@mayoclinic.com', 'Dulce Enevoldsen', '786-276-7309', 'English', 12, 'Alive', 'No', 'A+'),
		('Fifi', null, 'Clyant', '1979-7-5', 'Female', 'Female', '459 Walton Point', 'PO Box 86661', 'Atlanta', 'GA', '30380', '404-573-9141', '225-398-0729', null, 'fclyantf@sourceforge.net', 'Fifi Clyant', '608-310-1650', 'English', 11, 'Alive', 'Yes', 'A+'),
		('Cristin', null, 'Bester', '1969-6-9', 'Male', 'Male', '7603 Charing Cross Terrace', null, 'Kansas City', 'MO', '64144', '816-700-4328', null, '903-106-4847', 'cbesterh@purevolume.com', 'Cristin Bester', '314-686-8542', 'English', 12, 'Alive', 'Yes', 'A-'),
		('Kacy', 'C', 'Churchyard', '1993-5-31', 'Female', 'Female', '05741 Quincy Road', null, 'Miami', 'FL', '33196', '305-737-6670', '225-167-4809', '515-182-6723', 'kchurchyardi@flavors.me', 'Kacy Churchyard', '865-170-9733', 'English', 11, 'Alive', 'No', 'B+'),
		('Carmina', null, 'Mackro', '1969-6-9', 'Female', null, '4 Roth Parkway', 'Suite 3', 'Paterson', 'NJ', '07522', '973-507-0035', '678-758-5971', null, 'cmackroj@disqus.com', 'Carmina Mackro', '212-481-7638', 'Spanish', 11, 'Alive', 'Yes', 'A+');


	-- Providers: Providers that do not work within the clinic but would be needed for reference in patient charts such as who their PCP is or recieved past cancer treatment from. 
	CREATE TABLE Providers( 
		provider_id INT PRIMARY KEY AUTO_INCREMENT, -- NPI's not required for all providers so if that is the case, this is the main id for the clinic to use
        onsite BOOl, -- Does this provider practice in the clinic or not
        npi CHAR(10) UNIQUE, -- National Provider Identifier. Standardized way to identify providers no matter the system but not required to practice
		first_Name VARCHAR(50),
		middle_Name VARCHAR(50),
		last_name VARCHAR(50),
        suffix VARCHAR(10),
		specialty_id INT, -- To save space have specialty coded as an integer and refer to specialty table
		phone_number VARCHAR(15),
		email VARCHAR(50),
		fax_number VARCHAR(15),
		primary_location INT, -- What Facility do they predominantly work at
        
        CHECK (npi IS NULL OR npi BETWEEN 0000000000 AND 9999999999), -- Ensure the NPI is only 10 numerical digits
        
        FOREIGN KEY (specialty_id) REFERENCES Specialty(specialty_id),  -- Ensure SpecialtyID exists
		FOREIGN KEY (primary_location) REFERENCES Facilities(facility_id) -- Ensure Facility Exists
	);
    
    INSERT INTO Providers (onsite, npi, first_name, middle_name, last_name, suffix, specialty_id, phone_number, email, fax_number, primary_location) 
    VALUES 
		(false, NULL, 'Salvador', NULL, 'Gussie', 'PA', 1, '593-987-8498', 'sgussie0@nifty.com', '719-459-0642', 5),
        (true, 5253170415, 'Addy', null, 'Da Costa', 'PA-C', 2, '475-241-1253', 'adacosta1@foxnews.com', '657-398-1672', 5),
		(false, 8705906676, 'Winnifred', null, 'Hulson', 'NP', 3, '236-193-7994', 'whulson2@pen.io', '620-607-6810', 4),
        (false, 6362618018, 'Stanley', null, 'Leal', 'PA', 4, '264-405-7875', 'sleal3@tamu.edu', '220-459-1657', 4),
        (false, 6659944773, 'Charley', 'B', 'Illing', 'PA-C', 5, '980-103-9685', 'cilling4@senate.gov', '814-191-3698', 3),
		(true, 0472507390, 'Delcina', null, 'Grzeszczyk', 'MD', 6, '363-991-4210', 'dgrzeszczyk5@issuu.com', '803-669-2987', 3),
		(false, 3918139208, 'Kristyn', null, 'Dahlberg', 'MD', 1, '826-532-6946', 'kdahlberg6@theglobeandmail.com', '994-583-4289', 2),
		(true, 4500189483, 'Noella', 'J', 'Alesi', 'NP', 2, '142-325-0557', 'nalesi7@squarespace.com', '771-371-8328',2),
		(false, NULL, 'Cyrillus', null, 'Fearey', 'NP', 3, '154-722-0336', 'cfearey8@last.fm', '257-762-4904', 1),
		(true, 4963866129, 'Miguel', null, 'Housego', 'PA', 4, '705-155-6147', 'mhousego9@wp.com', '577-520-9247', 1),
		(true, 5296469220, 'Eada', null, 'Britner', 'MD', 5, '104-842-5655', 'ebritnera@google.de', '188-541-8438',6),
		(false, 0244407367, 'Timmy', null, 'Waples', 'NP', 6, '819-812-7533', 'twaplesb@npr.org', '785-812-8705', 6),
		(false, 7858818095, 'Sheila', null, 'Thorbon', 'MD', 7, '696-673-2646', 'sthorbonc@oaic.gov.au', '804-296-8317',7),
		(false, 0932769171, 'Elianore', 'D', 'Brobeck', 'MD', 7, '516-186-8673', 'ebrobeckd@webs.com', '878-425-3426',7),
		(false, 6891843740, 'Annaliese', 'C', 'Gorton', 'NP', 7, '859-815-2678', 'agortone@imdb.com', '358-982-1359', 8),
		(true, 4092540143, 'Genni', null, 'Dodgshun', 'NP', 8, '251-694-8623', 'gdodgshunf@ftc.gov', '334-937-5768', 1),
		(true, 2436781422, 'Pat', null, 'Sawle', 'PA-C', 8, '979-633-7620', 'psawleg@guardian.co.uk', '869-478-4213', 8),
		(true, 4555685217, 'Walden', 'J', 'Killiner', 'MD', 5, '896-980-8472', 'wkillinerh@mysql.com', '881-527-0581',9),
		(false, 1700398811, 'Sophey', 'E', 'Cicchitello', 'MD', 8, '504-728-9359', 'scicchitelloi@marketwatch.com', '193-376-6531',9),
        (true, 3320230946, 'Michele', 'H', 'Foucar', 'NP', 6, '864-215-5037', 'mfoucarj@businessweek.com', '177-655-2580', 10);

	-- Needed for general admin tasks
	CREATE TABLE Staff (
		employee_id VARCHAR(20)PRIMARY KEY,
        first_name VARCHAR(50),
		middle_name VARCHAR(50),
		last_name VARCHAR(50),
        address_line1 VARCHAR(100),
        address_line2 VARCHAR(100),
		city VARCHAR(50),
		state VARCHAR(13),
		zipcode VARCHAR(20),
        personal_email VARCHAR(255),
        work_email VARCHAR(255),
        phone_number VARCHAR(15),
        staff_position VARCHAR(50), -- Are they a nurse, receptionist, tech,
        department VARCHAR(50), -- Are they Hematology, Radiology, Infusion? 
        ssn VARCHAR(11) UNIQUE NOT NULL,
        dob DATE, 
        employment_start DATE, -- When did they first work at the clinic
        employment_end DATE -- When did they stop working at the clinic
	);
    
    INSERT INTO Staff(employee_id, first_name, middle_name, last_name, address_line1, address_line2, city, state, zipcode, personal_email, work_email, phone_number, staff_position, department, ssn, dob, employment_start, employment_end)
	VALUES 
		(488841664919, 'Jess', 'M' , 'Reap', '93086 Burning Wood Road', null, 'Charlotte', 'NC', '28230', 'jreap0@chron.com', 'jreap0@homestead.com', '704-695-6481', 'Radiology Nurse', 'Infusion', '535-90-7063', '1979-8-6', null, null)  ,
		(813853331205, 'Jade', null, 'Snazle', '097 Chinook Lane', null, 'Raleigh', 'NC', '27690', 'jsnazle1@desdev.cn', 'jsnazle1@jugem.jp', '919-267-1135', 'Nurse Manager', 'Triage', '444-02-2894', '1974-12-17', '2017-2-5', null)  ,
		(003706405251, 'Saunderson', null, 'Arnely', '1896 Farwell Place', null, 'El Paso', 'TX', '79945', 'sarnely2@unc.edu', 'sarnely2@boston.com', '915-766-9722', 'Oncology Nurse', 'Infusion', '421-09-4845', '1972-5-7', null, '2012-5-6')  ,
		(795979463849, 'Dixie', null, 'Prose', '9 Sullivan Pass', null, 'Daytona Beach', 'FL', '32118', 'dprose3@indiatimes.com', 'dprose3@github.com', '407-567-3968', 'RN', NULL, '712-87-0117', '1996-2-6', null, null)  ,
		(597300199429, 'De', null, 'Reven', '90 Rieder Park', '5th Floor', 'Miami', 'FL', '33261', 'dreven4@diigo.com', 'dreven4@fastcompany.com', '305-103-4510', 'Radiology Tech', NULL, '747-15-2598', '1992-5-8', null, null)  ,
		(918851332013, 'Elianore', null, 'Petche', '17037 Fulton Center', '14th Floor', 'Jeffersonville', 'IN', '47134', 'epetche5@reddit.com', 'epetche5@wunderground.com', '812-716-8099', 'Nurse Manager', 'Training', '388-83-7121', '1981-6-9', '2011-7-25', null)  ,
		(529351527623, 'Eugenia', null, 'Gritland', '9816 Washington Lane', null, 'Ogden', 'UT', '84403', 'egritland6@bravesites.com', 'egritland6@prlog.org', '801-454-9320', 'Radiology Tech', 'Radiology', '112-52-9767', '1976-2-5', null, null)  ,
		(524044016466, 'Jessica', 'A', 'Licas', '05231 Elgar Circle', null, 'Canton', 'OH', '44705', 'mlicas7@google.com.au', 'mlicas7@bloglovin.com', '330-710-1418', 'RN', NULL, '512-97-3285', '1996-3-4', null, null)  ,
		(769685257068, 'Mari', null, 'McCuaig', '25 Pawling Junction', null, 'Topeka', 'KS', '66667', 'mmccuaigd@army.mil', 'mmccuaigd@nasa.gov', '785-728-7243', 'RN', 'Triage', '581-97-7091', '1990-12-6', '2014-6-9', null)  ,
		(630313821349, 'Cortney', null, 'Hembrow', '59564 High Crossing Trail', null, 'Waco', 'TX', '76796', 'chembrowe@etsy.com', 'chembrowe@amazon.de', '254-488-8419', 'Med-Surg', 'Triage', '203-83-2068', '2000-9-4', null, null)  ,
		(599642188087, 'Julianna', null, 'Payle', '82 Randy Junction', null, 'Spokane', 'WA', '99210', 'jpaylef@marriott.com', 'jpaylef@mail.ru', '509-990-4280', 'Radiology Tech', 'Radiation', '159-64-2860', '2000-12-8', '2015-1-1', null),
		(437512218596, 'Indira', null, 'Elletson', '5 Jackson Center', 'PO Box 6437', 'Colorado Springs', 'CO', '80945', 'ielletsong@issuu.com', 'ielletsong@wsj.com', '719-788-7701', 'CNA', NULL, '485-54-1478', '1996-3-4', null, null),
		(284097827385, 'Porter', 'J', 'Yezafovich', '9001 Mallard Crossing', null, 'San Jose', 'CA', '95108', 'pyezafovichh@jigsy.com', 'pyezafovichh@bluehost.com', '408-603-7834', 'RN', NULL, '133-51-0637', '1969-5-8', null, null),
		(123257334357, 'Danya', null, 'Bene', '993 Mcbride Trail', 'Apt 905', 'Hartford', 'CT', '06160', 'dbenei@wikispaces.com', 'dbenei@mail.ru', '860-669-6700', 'Radiology Tech', 'Radiology', '389-80-2924', '1985-7-9', '1996-3-4', null),
		(494069308462, 'Oneida', null, 'Pree', '98 Spaight Park', null, 'Portsmouth', 'NH', '03804', 'opreej@etsy.com', 'opreej@msu.edu', '603-690-7019', 'Nurse Manager', 'Infusion', '246-74-3843', '1996-3-4', '2021-7-3', null),
        (738519058416, 'Carleigh', "D", 'Sokol', '98 Spaight Park', null, 'Portsmouth', 'NH', '03804', 'csokolj@etsy.com', 'csokolj@msu.edu', '603-690-7019', 'Reception', NULL, '246-09-7845', '1996-3-4', '2021-7-3', null);
    

########################################################
#           Administrative Relating Tables        	   #
########################################################
	
    CREATE TABLE Appointments (
		mrn INT,
		appt_id INT PRIMARY KEY AUTO_INCREMENT,
		provider_id INT, -- Onsite provider Who the paitent is scheduled with. May be null for appointments like Infusion where they do not meet with a specific person, just a nurse type visit 
		appt_datetime DATETIME,
		reason VARCHAR(100),
		notes VARCHAR(255), 
		FOREIGN KEY (mrn) REFERENCES Patients(mrn),
		FOREIGN KEY (provider_id) REFERENCES Providers(provider_id),
        
        INDEX idx_apt_mrn (mrn)
	);
    
    INSERT INTO Appointments(mrn,provider_id, appt_datetime,reason,notes)
    VALUES 
		(1, 2, '2024-10-18 09:30:00', 'Routine check-up', NULL),
		(2, NULL, '2024-10-18 11:00:00', 'Chemotherapy Infusion', 'Scheduled for 3-hour infusion'),
		(3, 6, '2024-10-19 10:15:00', 'Follow-up for test results', 'Discuss results of recent MRI scan'),
		(4, 10, '2024-10-20 08:45:00', 'Pre-surgery consultation', 'Pre-op discussion for surgery on 2024-11-01'),
		(5, NULL, '2024-10-21 13:00:00', 'Infusion therapy', 'Scheduled for a blood transfusion'),
		(6, 8, '2024-10-23 14:30:00', 'Post-operation follow-up', 'Evaluate recovery progress post-surgery'),
		(7, 2, '2024-10-23 15:45:00', 'Initial consultation', 'New patient who was referred due to mass found during an x-ray'),
		(8, NULL, '2024-10-23 10:00:00', 'Radiation therapy', 'Scheduled for first session of radiation therapy');

	CREATE TABLE Encounters(
		encounter_id INT PRIMARY KEY AUTO_INCREMENT,
		mrn INT NOT NULL,
		encounter_datetime DATETIME,
		chief_concern VARCHAR(255), -- Can be a repeat of the reason for appt, but an appointment may lead to an encounter but not all encounters are related to appointments. 
        encounter_status ENUM("Open","Closed"), -- Is the encounter open or closed
        location VARCHAR(30), -- Where encounter took place (Clinic, phone, telemed, etc.)
        notes VARCHAR(255),
		
        FOREIGN KEY (mrn) REFERENCES Patients(mrn),
        INDEX idx_encounter_mrn (mrn)        
	);
    
    INSERT INTO Encounters(mrn, encounter_datetime, chief_concern,encounter_status,location,notes)
    VALUES
		(5,'2024-10-24', 'Port disconnected', 'Closed','Phone', 'Patient advised checking to ensure the port dislodged and did not break. Will need to be scheduled to have port re-placed'),
		(1, '2023-01-20 09:00:00', 'Annual physical examination', 'Closed', 'Clinic', 'Routine check-up; referred to oncology for further evaluation.'),
		(2, '2023-02-15 10:30:00', 'Persistent cough and weight loss', 'Closed', 'Clinic', 'Chest X-ray ordered; follow-up in 2 weeks.'),
		(3, '2023-03-01 14:15:00', 'Abdominal pain', 'Closed', 'Clinic', 'Colonoscopy scheduled; dietary changes discussed.'),
		(4, '2023-01-20 08:45:00', 'Difficulty urinating', 'Closed', 'Clinic', 'Urology consult scheduled; medication prescribed.'),
		(5, '2023-03-15 11:00:00', 'Skin lesion evaluation', 'Closed', 'Clinic', 'Surgical excision recommended; pathology pending.'),
		(6, '2023-04-01 09:30:00', 'Bone pain and fatigue', 'Open', 'Telemed', 'Chemotherapy regimen started; labs to be monitored.'),
		(7, '2023-02-20 10:00:00', 'Abdominal bloating', 'Closed', 'Clinic', 'Gynecologic oncology referral made; imaging ordered.'),
		(8, '2023-05-10 11:45:00', 'Jaundice', 'Closed', 'Clinic', 'Hepatology consult scheduled; lab tests ordered.'),
		(9, '2023-04-15 13:30:00', 'Flank pain', 'Open', 'Telemed', 'Nephrology consult scheduled; imaging pending.'),
		(10, '2023-01-30 09:15:00', 'Neck swelling', 'Closed', 'Clinic', 'Endocrinology follow-up scheduled; ultrasound ordered.'),
		(11, '2023-03-25 14:00:00', 'Blood in urine', 'Closed', 'Clinic', 'BCG therapy initiated; monitoring scheduled.'),
		(12, '2023-02-05 08:30:00', 'Sore throat', 'Closed', 'Clinic', 'Radiation therapy completed; follow-up imaging required.'),
		(13, '2023-02-15 10:00:00', 'Abdominal pain', 'Open', 'Telemed', 'Discussing hospice options; pain management emphasized.'),
		(14, '2023-03-18 12:00:00', 'Difficulty swallowing', 'Closed', 'Clinic', 'Palliative care involvement; nutritional support discussed.'),
		(15, '2023-04-20 09:45:00', 'Lymph node swelling', 'Closed', 'Clinic', 'Chemotherapy regimen initiated; side effects monitored.'),
		(16, '2023-05-05 11:00:00', 'Fever and night sweats', 'Open', 'Telemed', 'Radiation therapy recommended after chemotherapy; follow-up needed.'),
		(17, '2023-01-10 09:30:00', 'Abnormal bleeding', 'Closed', 'Clinic', 'Colposcopy scheduled; results pending.');
    
   CREATE TABLE Referrals (
		referral_id INT PRIMARY KEY AUTO_INCREMENT,
		mrn INT NOT NULL, -- Patient being referred 
		referring_provider INT NOT NULL, -- Who is making the referral. Would be an Employee ID
		referred_provider INT NOT NULL, -- Who is the referral going to
		referral_date DATETIME NOT NULL, -- Date referral was made
		reason VARCHAR(255), -- Reason for the referral (ex. consultation, diagnostics)
		referral_status ENUM('Sent','Pending','Accepted','Denied') DEFAULT 'Sent', -- Current status of the referral such as is it pending, accepted or denied
		notes VARCHAR(255), -- Any Additional notes
		FOREIGN KEY (mrn) REFERENCES Patients(mrn),       
		FOREIGN KEY (referring_provider) REFERENCES Providers(provider_id),
        FOREIGN KEY (referred_provider) REFERENCES Providers(provider_id),
        
        INDEX idx_referral_mrn (mrn)
	);
    
    INSERT INTO Referrals(mrn,referring_provider,referred_provider,referral_date,reason,referral_status,notes)
    VALUES 
     (2,4,3,'2024-10-24','Needs to have tumor removed','Accepted',NULL);
    
    CREATE TABLE BayAvailability(
		bay_id INT PRIMARY KEY, 
        occupancy INT #put in the mrn for the paitent thats in the bay/room, null if room is available.
        -- IF mrn is used, check that it exists
    );
    
    INSERT INTO BayAvailability(bay_id, occupancy)
    VALUES
		(1,NULL),
        (2,NULL),
        (3,NULL),
        (4,NULL),
        (5,NULL),
        (6,NULL);
    
    -- Track important equipment such as mobile x-ray machines or ultrasounds
    CREATE TABLE EquipmentInventory( 
		equipment_id INT PRIMARY KEY AUTO_INCREMENT,
		serial_number VARCHAR(50) UNIQUE NOT NULL,
        item_description VARCHAR(100),
        location VARCHAR(50), -- Where is the equipment currently located 
        use_status ENUM('Available','Unavailable'), -- Is it in or not in use
        notes VARCHAR(255) -- Notes any issues that may be occuring or special requirements to keep in mind. 
    );
    
    INSERT INTO EquipmentInventory(serial_number,item_description,location,use_status,notes)
    VALUES
		('masndqwijbqwi14234', 'Portable X-Ray Machine', 'Radiology Department', 'Unavailable', 'Needs Maintainence'),
        ('andajfnbsbdfiugdy56', 'Ultrasound Machine',  'Infusion Storage Room', 'Available', NULL);
    
    
    -- Manage medical supplied such as syringes, dressings, tubing, etc
    CREATE TABLE SuppliesInventory( -- Will be basing this off a Barcode system rather than RFID
		item_code INT PRIMARY KEY, -- Barcode
        mfr_id VARCHAR(20), -- Code given by manufacturer if looking to buy same product again on restock
        item_description VARCHAR(50), -- Describes what it is (ex. 5 mL Syringe)  
        instock INT, -- Amount in stock
        location VARCHAR(25), -- Is it in a certain supply closet or a specific bin. 
        price DECIMAL(10,2) -- Track the price of items so when it comes to billing it can get pulled. 
    );
    
    INSERT INTO SuppliesInventory(item_code,mfr_id,item_description,instock,location,price)
    VALUES
        (125135146,NULL, 'Medline IV Start Kits with Chlorascrub',100,'Supply Closet C',0.95),
        (233521351,NULL, '20Ga 1 Inch Sterile Disposable Injection Needle',63,'Supply Closet B',0.10 ),
        (852106411,'qwnjd90', '18Ga 1 Inch Sterile Disposable Injection Needle',543,'Supply Closet A',0.10 ),
        (213456789,'p790-6','1ml Syringe with 30Ga 1/2in Needle',250,'Supply Closet A',0.60);
    
	CREATE TABLE Billing (
		billing_id INT PRIMARY KEY AUTO_INCREMENT,
        mrn INT NOT NULL, -- Patient bill is for
        encounter_id INT, -- Encounter this may be associated with 
        description_of_services VARCHAR(255), -- What this is relating to such as recent visit or lab
        total_amount DECIMAL(10,2), -- Total amount owed
        covered_by_insurance DECIMAL(10,2), -- Amount covered by the insurance
        patient_bill_amount DECIMAL(10,2), -- Amount left that patient will pay
        payment_status VARCHAR(50), -- Is it still waiting for insurance or patient to pay, is it partially paid or is it paid in full. 
		FOREIGN KEY (encounter_iD) REFERENCES Encounters(encounter_id),
        FOREIGN KEY (mrn) REFERENCES Patients(mrn),
        INDEX idx_billing_mrn (mrn)
	);
    
    INSERT INTO Billing(mrn,encounter_id,description_of_services,total_amount,covered_by_insurance,patient_bill_amount,payment_status)
    VALUES 
		(5,1,'Treatment for port',50.00,25.00,25.00, 'Patient payed, waiting on insurance');
        	
    CREATE TABLE Users(
		acct_id INT PRIMARY KEY AUTO_INCREMENT, -- account_id for the account itself
        acct_username VARCHAR(25) UNIQUE NOT NULL, -- account username
        acct_password VARCHAR(25) NOT NULL, -- account password
        linked_id VARCHAR(100), -- employee_id or mrn of the account. Can be null in cases where an account may be made for someone who isn't an employee or isn't a patient yet so they haven't gotten an EHR yet. 
        acct_role ENUM("role_doctor","role_patient","role_tech","role_receptionist") -- Real world would have way more but limiting to the roles I have currently
    );
                
###############################################################
#                   Patient Care Information                  #
###############################################################
    
    -- Insurance: Patient Insurance Information
    CREATE TABLE Insurance (
		mrn INT NOT NULL, 
        is_primary BOOL, -- Track what insurance is considered the primary insurance to bill to. Bool for yes primary or no meaning its the secondatry/tertiary insurance. 
        provider VARCHAR(150) NOT NULL, -- Who the insurance is under (ex. BCBS, Medicare/Medicaid, Aetna, etc.)
        plan_type VARCHAR(10), -- Type of plan such as HMO, PPO, FFS etc. 
		subscriber_id VARCHAR(50),                          
		member_id VARCHAR(50),
		group_number VARCHAR(50),
		subscriber_first_name VARCHAR(150),
        subscriber_last_name VARCHAR(150),
		subscriber_relation VARCHAR(25),
        copay DECIMAL(10,2), -- Typically they gotta look this up everytime the paitent comes but if their insurance is the same, this should stay the same saving time. 
        FOREIGN KEY (mrn) REFERENCES Patients(mrn),  
        INDEX idx_insurance_mrn (mrn),
        CONSTRAINT PRIMARY KEY(mrn,subscriber_id)
	);
    
    INSERT INTO Insurance(mrn,is_primary,provider,plan_type, subscriber_id,member_id,group_number,subscriber_first_name,subscriber_last_name, subscriber_relation, copay)
    VALUES
		(1, TRUE, 'Blue Cross Blue Shield', 'PPO', 'SUB123456789', 'MEM123456789', 'GRP12345', NULL, NULL, 'Self', 25.00),
        (1, FALSE, 'Aetna', 'HMO', 'SUB987654321', 'MEM987654321', 'GRP54321', 'John', 'Karlicek', 'Spouse', 20.00),
        (2, TRUE, 'Cigna', 'PPO', 'SUB1122334455', 'MEM1122334455', 'GRP67890', NULL, NULL, 'Self', 30.00),
        (3, FALSE, 'UnitedHealthcare', 'HMO', 'SUB2233445566', 'MEM2233445566', 'GRP12345', 'Jane', 'Marks', 'Spouse', 15.00),
        (4, TRUE, 'Kaiser Permanente', 'POS', 'SUB3344556677', 'MEM3344556677', 'GRP67891', NULL, NULL, 'Self', 40.00);
   
    
    -- Social History: SDoH relating information along with other "social" activities like smoking and drinking
    CREATE TABLE SocialHistory(
		mrn INT PRIMARY KEY,
        alcohol_use VARCHAR(255),
        tobacco_use VARCHAR(255),
        recreational_drug_use VARCHAR(255),
        military_service VARCHAR(255),
        occupation VARCHAR(255),
        marital_status VARCHAR(255),
        housing VARCHAR(255),
        financial_resources VARCHAR(255),
        education VARCHAR(255),
        social_isolation VARCHAR(255),
        stress VARCHAR(255),
        physical_activity VARCHAR(255),
        nutrition VARCHAR(255),
        exposure_violence VARCHAR(255),
        exposure_carcinagens VARCHAR(255),
        FOREIGN KEY (mrn) REFERENCES Patients(mrn),
        INDEX idx_sdoh_mrn (mrn)
    );
    
   INSERT INTO SocialHistory(mrn, alcohol_use, tobacco_use, recreational_drug_use, military_service, occupation, marital_status, housing, financial_resources, education, social_isolation, stress, physical_activity, nutrition, exposure_violence, exposure_carcinagens)
   VALUES
		(1, 'Occasional', 'Former smoker', 'None', 'No', 'Software Engineer', 'Married', 'Stable housing', 'Adequate', 'Bachelor Degree', 'No', 'Moderate', 'Regular exercise', 'Balanced diet', 'No', 'No'),
		(2, 'None', 'Never used', 'None', 'Yes', 'Retired', 'Divorced', 'Stable housing', 'Limited', 'High School Diploma', 'Yes', 'High', 'Minimal', 'Poor diet', 'No', 'Yes'),
		(5, 'Frequent', 'Current smoker', 'Occasional', 'No', 'Teacher', 'Single', 'Homeless', 'Limited', 'Master Degree', 'Yes', 'High', 'Low physical activity', 'Unbalanced diet', 'Yes', 'Yes'),
		(6, 'None', 'Never used', 'None', 'No', 'Nurse', 'Married', 'Stable housing', 'Adequate', 'Associate Degree', 'No', 'Low', 'Regular physical activity', 'Healthy diet', 'No', 'No'),
		(8, 'Occasional', 'Former smoker', 'Former recreational drug use', 'No', 'Construction Worker', 'Married', 'Stable housing', 'Adequate', 'High School Diploma', 'No', 'Moderate', 'Moderate physical activity', 'Moderate diet', 'No', 'Yes');
		
    -- Relevant family medical history 
    CREATE TABLE FamilyHistory(
		mrn INT PRIMARY KEY, 
        mother VARCHAR(255),
        father VARCHAR(255),
        brother VARCHAR(255),
        sister VARCHAR(255),
        grandmother VARCHAR(255),
        grandfather VARCHAR(255),
        notes VARCHAR(255),
        FOREIGN KEY (mrn) REFERENCES Patients(mrn),
        INDEX idx_famhistory_mrn (mrn)
    );
    
    INSERT INTO FamilyHistory(mrn,mother, father, brother, sister, grandmother, grandfather, notes)
    VALUES
		(1, 'Breast cancer, diagnosed at 55', 'No known cancer history', NULL, NULL, 'Ovarian cancer, died at 70', 'Prostate cancer, diagnosed at 72', 'Strong family history of cancer.'),
        (2, 'No known cancer history', 'Lung cancer, died at 68', NULL, NULL, 'Breast cancer, died at 74', 'No known cancer history', 'Family history of lung and breast cancer.'),
        (3, 'No known cancer history', 'Colon cancer, diagnosed at 60', NULL, NULL, 'Breast cancer, died at 68', 'Pancreatic cancer, died at 75', 'No significant family history of cancer.'),
        (4, 'No known cancer history', NULL, 'Leukemia, died at 40', NULL, 'Breast cancer, diagnosed at 62', 'Colon cancer, died at 70', 'Concern about genetic predisposition.'),
        (5, 'No known cancer history', 'Melanoma, diagnosed at 65', NULL, NULL, 'No known cancer history', 'Prostate cancer, died at 77', 'Family history of skin and prostate cancer.'),
		(6, 'No known cancer history', 'Liver cancer, died at 66', NULL, NULL, NULL, 'Lung cancer, died at 80', 'Family history of liver and lung cancer.'),
		(7, 'No known cancer history', NULL, NULL, NULL, 'Breast cancer, died at 60', NULL, 'Mother had significant health issues.'),
        (8, 'Breast cancer, diagnosed at 58', 'No known cancer history', NULL, NULL, NULL, 'Lung cancer, died at 72', 'Family history of breast cancer.'),
        (9, NULL, 'Colon cancer, diagnosed at 61', NULL, NULL, 'No known cancer history', 'Stomach cancer, died at 75', 'Family history of colon cancer.'),
        (10, 'No known cancer history', NULL, 'Melanoma, diagnosed at 40', NULL, 'Breast cancer, died at 50', NULL, 'Family history of melanoma and breast cancer.');
   
    -- Section of the Problem-Oriented Medical Record and the standard to how EMR management/organization
    CREATE TABLE ProblemList(
		mrn INT NOT NULL,
        problem_id INT,
        problem_icd VARCHAR(5), 
        problem_code VARCHAR(255), -- Short description of the problem as it may not have a full diagnosis yet to get a diagnostic code
        problem_symptoms VARCHAR(100), -- Symptoms associated
        onset DATE, -- Date in which symptoms started
        importance INT, -- Will give it a triaging level of importance which is on a numeric scale to save space rather than strings. Important for sort order
        problem_status VARCHAR(20), -- Is it getting better, worse, staying the same or been resolved
        current_plan INT, -- if a new problem, it will be the initial plan but as progress notes are taken, this updates to the most recent plan
        additional_notes VARCHAR(500),
        FOREIGN KEY (mrn) REFERENCES Patients(mrn),
        CONSTRAINT PRIMARY KEY(problem_id,mrn),
        INDEX idx_problemlist_mrn (mrn)
    );
    
	INSERT INTO ProblemList (mrn, problem_id, problem_icd, problem_code, onset, importance, problem_status, current_plan, additional_notes) 
	VALUES
		(1, 1, 10, 'C50.919', '2023-01-15', 1, 'Getting worse', 201, 'Referral to oncology needed; staging required.'),
		(2, 2, 10, 'C34.90', '2023-02-10', 1, 'Staying the same', 202, 'Palliative care discussed; imaging scheduled.'),
		(3, 3, 10, 'C18.9', '2023-03-05', 1, 'Getting better', 203, 'Follow-up colonoscopy planned.'),
		(4, 4, 10, 'C61', '2023-01-20', 1, 'Getting worse', 204, 'Hormonal therapy initiated; urology consult needed.'),
		(5, 5, 10, 'C44.91', '2023-03-15', 2, 'Resolved', 205, 'Surgical excision completed; pathology pending.'),
		(6, 6, 10, 'C90.00',  '2023-04-01', 1, 'Getting worse', 206, 'Chemotherapy regimen started; monitoring labs regularly.'),
		(7, 7, 10, 'C56.9',  '2023-02-20', 1, 'Getting worse', 207, 'Referral to gynecologic oncology made; imaging scheduled.'),
		(8, 8, 10, 'C22.9',  '2023-05-10', 1, 'Staying the same', 208, 'Discussion of transplant options; consult hepatology.'),
		(9, 9, 10, 'C64.9','2023-04-15', 1, 'Getting better', 209, 'Surgical options being explored; nephrology consult scheduled.'),
		(10, 10, 10, 'C73',  '2023-01-30', 2, 'Getting worse', 210, 'Surgical intervention planned; endocrinology follow-up required.'),
		(11, 11, 10, 'C67.9', '2023-03-25', 1, 'Getting better', 211, 'Treatment with BCG therapy started; monitoring needed.'),
		(12, 12, 10, 'C14.0',  '2023-02-05', 1, 'Resolved', 212, 'Radiation therapy completed; follow-up imaging required.'),
		(13, 13, 10, 'C25.9',  '2023-02-15', 1, 'Getting worse', 213, 'Discussing hospice options; pain management important.'),
		(14, 14, 10, 'C15.9',  '2023-03-18', 1, 'Staying the same', 214, 'Palliative care involvement; nutritional support discussed.'),
		(15, 15, 10, 'C85.90',  '2023-04-20', 1, 'Getting better', 215, 'Chemotherapy regimen initiated; monitoring symptoms closely.'),
		(16, 16, 10, 'C81.90',  '2023-05-05', 1, 'Getting better', 216, 'Radiation therapy recommended after chemo; follow-up needed.'),
		(17, 17, 10, 'C53.9',  '2023-01-10', 1, 'Staying the same', 217, 'Colposcopy scheduled');
        
        
    -- Manage other notes that may be unrelated other tables
    -- An example is a nurse making a note about a patients care preferences that may be related to religion
    -- Another is so a nurse can quickly see that they need to get in contact with a case manager.
    CREATE TABLE Notes(
		mrn INT NOT NULL,
        note_id INT PRIMARY KEY AUTO_INCREMENT,
        note_description VARCHAR(50),
        note_content VARCHAR(500),
        FOREIGN KEY (mrn) REFERENCES Patients(mrn),
        INDEX idx_notes_mrn (mrn)
    );
    

    CREATE TABLE Allergies(
		mrn INT NOT NULL,
        allergy_id INT PRIMARY KEY AUTO_INCREMENT,
		allergen VARCHAR(255), -- What are they allergic to
		reaction VARCHAR(255), -- What reactions do they experiance? Hives, difficulty breathing and/or swallowing, etc. 
		severity VARCHAR(50), -- How sever is it, is it minor and just mentioned so it can be avoided if possible or do 
		FOREIGN KEY (mrn) REFERENCES Patients(mrn),
        INDEX idx_allergies_mrn (mrn)
    );
    
    INSERT INTO Allergies (mrn, allergen, reaction, severity)
    VALUES
		(1, 'Penicillin', 'Hives, difficulty breathing', 'Severe'),
		(1, 'Ibuprofen', 'Stomach pain', 'Moderate'),
		(2, 'Sulfa Drugs', 'Rash, fever', 'Severe'),
		(3, 'Aspirin', 'Anaphylaxis', 'Severe'),
		(4, 'Latex', 'Hives, swelling', 'Severe'),
		(5, 'Peanuts', 'Hives, shortness of breath', 'Severe'),
		(6, 'Shellfish', 'Nausea, vomiting', 'Moderate'),
		(7, 'Dust Mites', 'Sneezing, nasal congestion', 'Mild'),
		(8, 'Soy', 'Abdominal cramps', 'Moderate'),
		(9, 'Pollen', 'Itchy eyes, runny nose', 'Mild'),
		(10, 'Milk', 'Hives, digestive issues', 'Moderate'),
		(11, 'Wheat', 'Skin rash, fatigue', 'Moderate'),
		(12, 'Eggs', 'Swelling, breathing difficulties', 'Severe'),
		(13, 'Bee Stings', 'Swelling, anaphylaxis', 'Severe'),
		(14, 'Citrus Fruits', 'Mouth itching', 'Mild'),
		(15, 'Poppy Seeds', 'Nausea', 'Moderate'),
		(16, 'Nickel', 'Skin rash', 'Moderate');
    
    -- Progress Notes: Another Part of the POMR. Notes related to the care of the paitents that follow a SOAP format. 
    CREATE TABLE ProgressNote(
		mrn INT NOT NULL,
        progress_note_id INT PRIMARY KEY AUTO_INCREMENT,
        problem_id INT, -- What problem was this progress note for
        creation_date DATETIME, -- When was the note made
        assessment_by INT, -- If brought in from another clinic, this may be another provider.
		subjective VARCHAR(255), 
        objective VARCHAR(255),
        assessment VARCHAR(255),
        treatment_plan VARCHAR(255),
        FOREIGN KEY (mrn) REFERENCES Patients(mrn),
        INDEX idx_progress_mrn (mrn)
    );
    
    INSERT INTO ProgressNote (mrn, problem_id, creation_date, assessment_by, subjective, objective, assessment, treatment_plan) 
    VALUES
		(1, 1, '2024-01-20 10:30:00', 101, 'Patient reports increased pain in the left breast.', 'Breast lump palpable, no lymphadenopathy.', 'Breast cancer staging needed; pain management is important.', 'Referral to oncology; consider palliative care.'),
		(1, 2, '2024-02-10 14:00:00', 101, 'Patient mentions nausea after recent chemotherapy.', 'No signs of dehydration; weight stable.', 'Adverse effects from chemotherapy.', 'Adjust antiemetics; monitor closely.'),
		(2, 1, '2024-02-15 14:00:00', 102, 'Patient states cough has worsened and is now producing blood.', 'Weight loss noted, chest auscultation reveals wheezing.', 'Progressing; imaging results pending.', 'Schedule CT scan and refer to pulmonology.'),
		(2, 2, '2024-03-05 09:45:00', 102, 'Patient reports fatigue and shortness of breath.', 'Breathing slightly labored; oxygen saturation 92%.', 'Possible progression of lung cancer.', 'Consider bronchoscopy; initiate oxygen therapy.'),
		(3, 1, '2024-03-05 09:45:00', 103, 'Abdominal discomfort has improved slightly, but bowel habits remain irregular.', 'Abdominal exam shows mild tenderness in the left quadrant.', 'Stable; continue monitoring.', 'Follow up in 6 weeks for repeat colonoscopy.'),
		(3, 2, '2024-04-10 12:00:00', 103, 'Patient expresses concern about weight loss.', 'Nutritional assessment shows low intake.', 'Consider re-evaluation of dietary needs.', 'Referral to nutritionist; increase caloric intake.'),
		(4, 1, '2024-01-25 11:00:00', 104, 'Patient expresses concern about increased urinary urgency.', 'Pelvic exam reveals prostate enlargement.', 'Prostate cancer is stable; hormonal therapy ongoing.', 'Continue current medication; schedule urology follow-up.'),
		(4, 2, '2024-03-15 13:30:00', 104, 'Patient reports improvement in urinary symptoms.', 'Recent labs show stable PSA levels.', 'Good response to treatment noted.', 'Continue monitoring; follow-up in 3 months.'),
		(5, 1, '2024-03-22 15:15:00', 105, 'Patient states they feel well after surgery.', 'Incision healing well; no signs of infection.', 'Skin cancer excision successful.', 'Monitor pathology results; schedule follow-up in one month.'),
		(5, 2, '2024-04-18 10:00:00', 105, 'Patient inquires about sunscreen use post-surgery.', 'Skin examination shows no new lesions.', 'Post-operative care is adequate.', 'Discuss skin protection; provide educational materials.'),
		(6, 1, '2024-04-10 10:00:00', 106, 'Patient reports fatigue and increased pain.', 'Bone tenderness upon exam; labs show elevated calcium.', 'Multiple myeloma is stable but concerning symptoms persist.', 'Adjust chemotherapy regimen; manage pain actively.'),
		(6, 2, '2024-05-05 09:00:00', 106, 'Patient states they are experiencing night sweats.', 'Review of systems shows increased fatigue.', 'Possible symptom progression.', 'Re-evaluate treatment plan; consider imaging studies.'),
		(7, 1, '2024-02-18 09:30:00', 107, 'Patient mentions persistent abdominal bloating.', 'Imaging shows ovarian mass; CA-125 levels elevated.', 'Possible progression of ovarian cancer.', 'Refer to gynecologic oncology; discuss treatment options.'),
		(7, 2, '2024-03-12 14:45:00', 107, 'Patient reports pain radiating to the back.', 'Pelvic exam shows tenderness.', 'Symptoms indicate need for further evaluation.', 'Schedule MRI and follow up with oncology team.'),
		(8, 1, '2024-05-05 12:00:00', 108, 'Patient reports jaundice worsening.', 'Abdominal exam shows significant hepatomegaly.', 'Liver cancer is progressing; need for palliative care is evident.', 'Discuss hospice options with patient and family.'),
		(8, 2, '2024-06-10 10:15:00', 108, 'Patient feels tired and is experiencing loss of appetite.', 'Labs show elevated bilirubin levels.', 'Progression of liver cancer noted.', 'Adjust care plan to focus on comfort; initiate palliative care.'),
		(9, 1, '2024-04-20 13:00:00', 109, 'Patient states flank pain has decreased.', 'Hematuria noted on urinalysis.', 'Kidney cancer response to treatment is positive.', 'Surgical options discussed; nephrology consult scheduled.'),
		(9, 2, '2024-05-15 11:30:00', 109, 'Patient is concerned about upcoming surgery.', 'Physical exam is stable; no new complaints.', 'Patient is anxious about treatment.', 'Provide reassurance; discuss surgical procedure in detail.'),
		(10, 1, '2024-01-31 14:00:00', 110, 'Patient feels swelling in neck has increased.', 'Thyroid exam reveals enlarged gland; ultrasound pending.', 'Thyroid cancer staging needed.', 'Endocrinology referral; consider fine needle aspiration.'),
		(10, 2, '2024-03-30 10:00:00', 110, 'Patient reports some difficulty swallowing.', 'Physical exam shows thyroid mass.', 'Monitoring for changes in symptoms.', 'Follow up after ultrasound results; consider biopsy.'),
		(11, 1, '2024-03-28 11:30:00', 111, 'Patient reports improvement in urinary symptoms.', 'Follow-up exam shows decreased lymphadenopathy.', 'Bladder cancer treatment appears effective.', 'Continue BCG therapy; monitor for side effects.'),
		(11, 2, '2024-04-20 09:00:00', 111, 'Patient feels fatigued but overall stable.', 'No new findings on exam.', 'Stable post-treatment phase.', 'Continue monitoring; follow up in 2 months.'),
		(12, 1, '2024-02-12 16:00:00', 112, 'Patient reports sore throat persists.', 'Neck exam shows enlarged lymph nodes; needs follow-up.', 'Head and neck cancer treatment ongoing.', 'Radiation therapy regimen adjusted; follow up in 2 weeks.'),
		(12, 2, '2024-03-28 15:30:00', 112, 'Patient expresses concern about swallowing difficulties.', 'Physical exam shows no new lesions.', 'Ongoing monitoring needed.', 'Re-evaluate treatment options; consider nutrition support.'),
		(13, 1, '2024-02-27 14:30:00', 113, 'Patient expresses fatigue and loss of appetite.', 'Weight loss noted; jaundice worsening.', 'Pancreatic cancer is stable but concerning.', 'Consult with palliative care; pain management plan in place.'),
		(13, 2, '2024-04-14 12:45:00', 113, 'Patient states increased abdominal pain.', 'Imaging reveals possible metastasis.', 'Ongoing assessment required.', 'Discuss options for palliative care; supportive services available.'),
		(14, 1, '2024-03-14 15:00:00', 114, 'Patient has difficulty swallowing.', 'Imaging shows esophageal narrowing.', 'Esophageal cancer is stable; consider feeding tube.', 'Palliative care discussion; nutrition consult referred.'),
		(14, 2, '2024-04-08 11:00:00', 114, 'Patient reports increased discomfort while eating.', 'No signs of aspiration noted.', 'Monitoring for nutrition intake.', 'Adjust feeding plan; follow up with dietitian.'),
		(15, 1, '2024-04-15 09:15:00', 115, 'Patient reports less fatigue and improved energy.', 'Lymph nodes palpably reduced in size.', 'Non-Hodgkin lymphoma response to treatment noted.', 'Continue chemotherapy; monitor labs closely.'),
		(15, 2, '2024-06-05 14:30:00', 115, 'Patient mentions some hair loss.', 'Overall condition stable; no new complaints.', 'Common side effect of treatment.', 'Discuss hair loss management options; support services available.'),
		(16, 1, '2024-03-05 10:00:00', 116, 'Patient complains of night sweats and weight loss.', 'Physical exam shows cervical lymphadenopathy.', 'Hodgkin lymphoma is under control; treatment ongoing.', 'Adjust treatment plan as needed; follow-up in 1 month.'),
		(16, 2, '2024-04-10 11:30:00', 116, 'Patient expresses anxiety about future treatments.', 'Mental health support recommended.', 'Ongoing mental health assessment needed.', 'Refer to counseling services; discuss coping strategies');

    -- Intake Form Responses
	CREATE TABLE ReviewOfSystems( -- Subjective to the patient
		mrn INT NOT NULL,
        encounter_id INT, -- What enounter was this information collected from.
        heent VARCHAR(255), 
        cardiovascular VARCHAR(255),
        gastrointestinal VARCHAR(255),
        genitourinary VARCHAR(255),
        musculoskeletal VARCHAR(255),
        neurological VARCHAR(255),
        FOREIGN KEY (mrn) REFERENCES Patients(mrn),
        INDEX idx_ros_mrn (mrn)
	); 
    
    INSERT INTO ReviewOfSystems (mrn, encounter_id, heent, cardiovascular, gastrointestinal, genitourinary, musculoskeletal, neurological) VALUES
		(1, 101, 'No complaints', 'No chest pain or palpitations', 'Nausea, loss of appetite', 'No dysuria', 'No joint pain', 'No headaches or dizziness'),
		(2, 102, 'Difficulty swallowing', 'Mild hypertension', 'Bloating, occasional diarrhea', 'Frequent urination', 'Muscle cramps', 'No seizures or fainting'),
		(3, 103, 'Dry eyes', 'Normal heart rhythm', 'Constipation', 'No issues', 'Chronic back pain', 'No neurological deficits'),
		(4, 104, 'No issues reported', 'Chest discomfort during exertion', 'Heartburn', 'Hematuria', 'No muscle weakness', 'Occasional migraines'),
		(5, 105, 'No significant findings', 'Palpitations noted', 'Diarrhea', 'No abnormalities', 'Joint stiffness', 'No recent memory loss'),
		(6, 106, 'Hearing loss in right ear', 'Normal', 'Weight loss, no other GI symptoms', 'Dysuria', 'Knee pain', 'No symptoms'),
		(7, 107, 'Sore throat', 'Mild arrhythmia', 'Bloating', 'Incontinence', 'No pain', 'No tremors'),
		(8, 108, 'No complaints', 'Normal', 'Occasional indigestion', 'No issues', 'No back pain', 'No dizziness'),
		(9, 109, 'Nasal congestion', 'No history of heart disease', 'No changes', 'No complaints', 'No pain or swelling', 'Occasional headaches'),
		(10, 110, 'Vision changes', 'Murmur noted', 'Stable', 'No issues', 'No complaints', 'No neurological concerns'),
		(11, 111, 'No issues', 'No complaints', 'Occasional heartburn', 'No changes', 'No pain', 'No history of strokes'),
		(12, 112, 'Sore throat', 'No chest pain', 'Stable', 'No issues', 'No symptoms', 'No neurological issues'),
		(13, 113, 'No complaints', 'No history of heart disease', 'Weight gain', 'Stable', 'No joint issues', 'No headaches');

	CREATE TABLE Basics(
		mrn INT NOT NULL,
        encounter_id INT, 
        weight INT,
        height INT,
        bmi INT, 
		temp DECIMAL(4,1),
        temp_method VARCHAR(50),
        diastolic INT,
        systolic INT,
        pulse INT,
        respiration_rate INT,
        oxygen_saturation INT,
        pain_scale INT,
        notes VARCHAR(255),
        FOREIGN KEY (mrn) REFERENCES Patients(mrn),
        INDEX idx_basics_mrn (mrn)
	);
    
    INSERT INTO Basics (mrn, encounter_id, weight, height, bmi, temp, temp_method, diastolic, systolic, pulse, respiration_rate, oxygen_saturation, pain_scale, notes) 
    VALUES
		(1, 1, 150, 65, 24, 98.6, 'Oral', 70, 120, 75, 16, 98, 0, 'Normal vital signs.'),
		(1, 2, 152, 65, 24.5, 99.1, 'Oral', 72, 118, 77, 18, 97, 1, 'Slightly elevated temperature.'),
		(2, 1, 180, 70, 25.8, 98.4, 'Oral', 68, 125, 80, 14, 95, 2, 'Patient reported mild headache.'),
		(2, 2, 178, 70, 25.5, 98.7, 'Oral', 69, 122, 78, 15, 96, 1, 'All readings stable.'),
		(3, 1, 140, 62, 25.8, 97.5, 'Axillary', 60, 110, 72, 15, 99, 0, 'Routine checkup.'),
		(3, 2, 138, 62, 25.5, 98.0, 'Axillary', 62, 112, 74, 16, 98, 0, 'No complaints.'),
		(4, 1, 200, 68, 30.4, 100.3, 'Oral', 80, 135, 85, 20, 94, 3, 'Fever and fatigue reported.'),
		(4, 2, 198, 68, 30.1, 100.1, 'Oral', 78, 130, 82, 19, 93, 2, 'Patient feels better today.'),
		(5, 1, 130, 64, 22.4, 98.2, 'Oral', 65, 115, 70, 14, 97, 0, 'Normal checkup.'),
		(5, 2, 132, 64, 22.7, 98.4, 'Oral', 66, 116, 71, 15, 98, 1, 'Patient feels well.'),
		(6, 1, 155, 66, 25.0, 99.0, 'Oral', 74, 122, 76, 17, 96, 1, 'Mild cough noted.'),
		(6, 2, 157, 66, 25.2, 98.5, 'Oral', 75, 121, 77, 16, 95, 0, 'Stable condition.');
    
	-- Physical Exam made by physician
	CREATE TABLE PhysicalExams(
		mrn INT NOT NULL,
		date_done DATE NOT NULL,
		general_assessment VARCHAR(500) NOT NULL,
        heent VARCHAR(500) NOT NULL,
        neck VARCHAR(500) NOT NULL,
        chest VARCHAR(500),
        abdomen VARCHAR(500), 
        extremities VARCHAR(500),
        nodes VARCHAR(500), 
        genital_rectal VARCHAR(500),
        neurological VARCHAR(500),
        FOREIGN KEY (mrn) REFERENCES Patients(mrn),
        INDEX idx_physical_mrn (mrn)
    );
    
    INSERT INTO PhysicalExams (mrn, date_done, general_assessment, heent, neck, chest, abdomen, extremities, nodes, genital_rectal, neurological) 
	VALUES
		(1, '2023-01-15', 'Patient appears well-nourished; no distress.', 'No signs of conjunctival pallor; pupils equal and reactive.', 'No lymphadenopathy; trachea midline.', 'Clear breath sounds bilaterally; no wheezing.', 'Soft, non-tender; no masses.', 'Normal range of motion; no cyanosis.', 'No palpable lymphadenopathy.', 'Normal genital examination; no abnormalities noted.', 'Cranial nerves intact; reflexes normal.'),
		(2, '2023-02-20', 'Patient fatigued; appears anxious.', 'Mild conjunctival injection; no discharge.', 'Right cervical lymphadenopathy present.', 'Diminished breath sounds on the right; slight wheezing.', 'Tenderness in the right upper quadrant.', 'Full range of motion; slight edema in the left ankle.', 'Right supraclavicular lymphadenopathy noted.', 'Normal rectal examination; no masses.', 'Sluggish reflexes; sensory examination normal.'),
		(3, '2023-03-10', 'Patient in mild distress due to pain.', 'Pupils equal, reactive; slight swelling in eyelids.', 'No lymphadenopathy.', 'Normal breath sounds; slight cough present.', 'Distended abdomen; bowel sounds diminished.', 'Good range of motion; no pain reported.', 'No palpable nodes.', 'Normal genital exam; no abnormalities.', 'Cranial nerves intact; coordination slightly impaired.'),
		(4, '2023-04-01', 'Patient appears comfortable; alert and oriented.', 'No signs of infection; vision intact.', 'No abnormalities detected.', 'Lungs clear; no signs of respiratory distress.', 'Soft, non-tender; no palpable masses.', 'Normal strength; no edema.', 'No cervical or axillary lymphadenopathy.', 'Normal genital examination; no lesions.', 'Neurological exam normal; gait steady.'),
		(5, '2023-05-05', 'Patient shows signs of dehydration; slightly lethargic.', 'Dry mucous membranes; pupils reactive but sluggish.', 'Mild lymphadenopathy noted on the left.', 'Decreased breath sounds; patient appears to have cough.', 'Soft but tender to palpation in the lower quadrants.', 'Full range of motion; slight weakness in the right leg.', 'Right inguinal lymphadenopathy present.', 'Normal rectal examination; no signs of bleeding.', 'Neurological examination reveals diminished reflexes.'),
		(6, '2023-06-12', 'Patient in no acute distress; smiling and cooperative.', 'Eyes clear; hearing normal.', 'No lymph nodes palpable.', 'Lungs clear to auscultation; no wheezes or crackles.', 'Normal abdominal exam; no tenderness.', 'Normal strength; full range of motion.', 'No significant lymphadenopathy.', 'Normal genital examination; no issues noted.', 'Neurological exam within normal limits; cranial nerves intact.'),
		(7, '2023-07-20', 'Patient appears anxious; speaks in short sentences.', 'Normal findings in HEENT; some nasal congestion.', 'No abnormalities; neck supple.', 'Clear breath sounds bilaterally; no crackles.', 'Abdomen soft; some tenderness in the left flank.', 'Mild swelling of the left ankle; otherwise normal.', 'Left axillary lymph nodes palpable.', 'Normal genital examination; no lesions.', 'Slight tremor in hands; otherwise neurological findings normal.'),
		(8, '2023-08-15', 'Patient well-nourished; no signs of distress.', 'Pupils equal and reactive; visual acuity normal.', 'No lymphadenopathy; neck supple.', 'Lungs clear; patient breathing comfortably.', 'Soft; non-tender; bowel sounds present.', 'Good range of motion; no joint issues.', 'No significant nodes palpated.', 'Normal genital examination; no abnormalities.', 'Cranial nerves intact; reflexes within normal limits.');

    # Surgical History
	CREATE TABLE SurgicalHistory(
		mrn INT,
        occurrence_year YEAR, 
        procedure_done VARCHAR(255) NOT NULL, 
        location VARCHAR(255), -- Part of the body operated on
        complications VARCHAR(255), -- Were there any problems
        outcomes VARCHAR(255), -- What was the final outcome of the procedure
        notes VARCHAR(500),
        FOREIGN KEY (mrn) REFERENCES Patients(mrn),
        INDEX idx_surgical_mrn (mrn)
    );
    
    INSERT INTO SurgicalHistory (mrn, occurrence_year, procedure_done, location, complications, outcomes, notes) 
	VALUES
		(1, 2021, 'Lumpectomy', 'Right breast', 'Minor infection; treated with antibiotics.', 'Successful removal of tumor; margins clear.', 'Follow-up imaging scheduled in six months.'),
		(2, 2022, 'Lobectomy', 'Left lung', 'None.', 'Successful removal; no further treatment needed.', 'Patient is currently cancer-free.'),
		(3, 2020, 'Colectomy', 'Colon', 'Post-operative ileus; resolved within days.', 'Tumor successfully removed; no recurrence at follow-up.', 'Patient requires regular surveillance.'),
		(4, 2021, 'Radical prostatectomy', 'Prostate', 'Nerve damage; erectile dysfunction.', 'Cancer successfully removed; patient started ED therapy.', 'Routine monitoring for PSA levels needed.'),
		(5, 2023, 'Mohs surgery', 'Right forearm', 'None.', 'Complete excision of skin cancer; no signs of recurrence.', 'Follow-up appointment in three months.'),
		(6, 2021, 'Chemotherapy port placement', 'Chest', 'Infection at port site; treated successfully.', 'Port functioning well; chemotherapy ongoing.', 'Regular port site care emphasized to patient.'),
		(7, 2020, 'Whipple procedure', 'Pancreas', 'Delayed gastric emptying; managed with diet changes.', 'Tumor removed; patient under surveillance.', 'Nutritional support recommended post-surgery.'),
		(8, 2023, 'Oophorectomy', 'Ovaries', 'None.', 'Surgery successful; no complications.', 'Hormonal therapy discussed with oncology team.'),
		(9, 2022, 'Hernia repair', 'Abdomen', 'None.', 'Surgery successful; patient recovered well.', 'Routine post-operative check-up scheduled.'),
		(10, 2023, 'Thyroidectomy', 'Thyroid gland', 'Temporary hoarseness; improved over time.', 'Cancer removed; normal thyroid function tests.', 'Endocrinology follow-up needed in three months.');
    
    CREATE TABLE Prescriptions(
		mrn INT,
        rx_id INT PRIMARY KEY,
        ndc VARCHAR(20) NOT NULL,
        date_prescribed DATE NOT NULL,
        reason VARCHAR(255),
        dosage VARCHAR(255) NOT NULL,
        frequency VARCHAR(50) NOT NULL,
		start_date DATE NOT NULL, 
        end_date DATE,
        notes VARCHAR(255), -- used to point out reported experienced side effects, additional instructions. can be null
        FOREIGN KEY (mrn) REFERENCES Patients(mrn),
        FOREIGN KEY (ndc) REFERENCES ndc(ndc),
        INDEX idx_rx_mrn (mrn),
        INDEX idx_rx_ndc (ndc)
    );
    
    INSERT INTO Prescriptions (mrn, rx_id, ndc, date_prescribed, reason, dosage, frequency, start_date, end_date, notes) 
	VALUES
	(1, 118, '223-344-556' , '2023-01-20', 'Hypertension management', 'Lisinopril 10mg', 'Once daily', '2023-01-21', NULL, 'Monitor blood pressure regularly.'),
	(2, 119, '334-455-667', '2023-02-15', 'Diabetes management', 'Metformin 500mg', 'Twice daily', '2023-02-16', NULL, 'Take with meals to minimize GI upset.'),
	(3, 120, '445-566-778', '2023-03-01', 'Cholesterol management', 'Atorvastatin 20mg', 'Once daily', '2023-03-02', NULL, 'Monitor lipid levels in 3 months.'),
	(4, 121, '556-677-889', '2023-01-28', 'Pain relief', 'Ibuprofen 600mg', 'Every 8 hours as needed', '2023-01-29', '2023-04-29', 'Caution with GI upset; take with food.'),
	(5, 122, '667-788-990', '2023-02-10', 'Allergy relief', 'Cetirizine 10mg', 'Once daily', '2023-02-11', NULL, 'Take at night to reduce drowsiness.'),
	(6, 123, '778-899-001', '2023-03-05', 'Acid reflux', 'Omeprazole 20mg', 'Once daily', '2023-03-06', NULL, 'Take 30 minutes before meals.'),
	(7, 124, '889-900-112', '2023-04-20', 'Anxiety management', 'Sertraline 50mg', 'Once daily', '2023-04-21', NULL, 'Monitor for mood changes and side effects.'),
	(8, 125, '990-011-223', '2023-05-15', 'Thyroid replacement', 'Levothyroxine 100mcg', 'Once daily', '2023-05-16', NULL, 'Check TSH levels every 6 months.'),
	(9, 126, '101-112-223', '2023-06-01', 'Infection', 'Amoxicillin 500mg', 'Every 8 hours for 10 days', '2023-06-02', '2023-06-12', 'Complete full course; watch for allergic reactions.'),
	(10, 127, '121-314-225', '2023-06-10', 'Arthritis pain', 'Naproxen 250mg', 'Twice daily', '2023-06-11', '2023-09-11', 'Monitor for stomach irritation; take with food.');
 
        
    
    -- Used to record things that are important to track such as supplements or OtC medications taken reguarly
    CREATE TABLE NonPrescribedMedications(
		mrn INT NOT NULL,
        medication_name VARCHAR(100),
        dosage VARCHAR(50),
        frequency VARCHAR(50),
        route VARCHAR(50), 
		start_date DATE, 
        end_date DATE,
        reason_started VARCHAR(100), 
        CHECK(start_date < end_date), -- ensure that the start/end was entered correctly
        FOREIGN KEY (mrn) REFERENCES Patients(mrn),
        INDEX idx_nonrx_mrn (mrn)
    );
    
    INSERT INTO NonPrescribedMedications (mrn, medication_name, dosage, frequency, route, start_date, end_date, reason_started) 
	VALUES
		(1, 'Fish Oil', '1000 mg', 'Once daily', 'Oral', '2023-01-01', NULL, 'General health'),
		(2, 'Vitamin D3', '2000 IU', 'Once daily', 'Oral', '2023-02-01', NULL, 'Vitamin deficiency'),
		(3, 'Probiotic', '10 billion CFU', 'Once daily', 'Oral', '2023-03-01', NULL, 'Digestive health');
        
    CREATE TABLE Orders(
		order_id INT AUTO_INCREMENT PRIMARY KEY,
        mrn INT, -- mrn for patients results are for
        ordered_by INT NOT NULL, -- the provider who put in the order
        entry_date DATETIME, -- When was order made, will track when samples were taken as well to reference in reports instead of
        last_update DATETIME, -- When was order last updated, useful for getting to know status such as has it been inprogress for 10 min or 10 days
        completion_date DATETIME, -- When the order was completed
        priority INT, -- On a scale of 1-4, how important is this. For example, a Stat would be a 1 but a general work-up that is just being done for monitoring may be a 4. 
        order_type INT, -- Refers to what the order is to identify what deparment its for such as radiology, lab
        results_id INT, -- Link to what the results of the order were if needed (only would be for lab/test results and not pharmacy)
        order_status INT, -- Keep track of if it has been completed 
        notes VARCHAR(255), -- Additional notes as needed
        FOREIGN KEY (mrn) REFERENCES Patients(mrn),
        FOREIGN KEY (ordered_by) REFERENCES Providers(provider_id),
        INDEX idx_orders_mrn (mrn)
    ); 
    
    INSERT INTO Orders (order_id, mrn, ordered_by, entry_date, last_update, completion_date, priority, order_type, results_id, order_status, notes) 
	VALUES
		(1, 1, 2, '2023-01-15 08:30:00', '2023-01-15 09:00:00', '2023-01-15 12:00:00', 1, 1, 201, 1, 'Urgent blood draw for CBC.'),
		(2, 2, 2, '2023-02-10 10:15:00', '2023-02-10 10:45:00', NULL, 2, 2, 202, 2, 'Chest X-ray requested; follow-up in radiology.'),
		(3, 3, 8, '2023-03-05 11:00:00', '2023-03-05 11:30:00', '2023-03-05 15:00:00', 3, 1, 203, 1, 'Urine analysis ordered for suspected UTI.'),
		(4, 4, 8, '2023-01-20 14:00:00', '2023-01-20 14:15:00', NULL, 4, 3, NULL, 2, 'MRI of the brain requested; patient to schedule.'),
		(5, 5, 6, '2023-02-12 09:30:00', '2023-02-12 09:45:00', '2023-02-12 10:00:00', 1, 1, 204, 1, 'Blood culture ordered for suspected sepsis.'),
		(6, 6, 10, '2023-04-01 13:00:00', '2023-04-01 13:30:00', NULL, 2, 2, 205, 2, 'Referral to cardiology for echocardiogram.'),
		(7, 7, 11, '2023-03-22 08:00:00', '2023-03-22 08:30:00', '2023-03-22 09:30:00', 3, 3, 206, 1, 'CT scan of the abdomen ordered.'),
		(8, 8, 11, '2023-05-10 10:00:00', '2023-05-10 10:15:00', NULL, 4, 2, NULL, 2, 'Follow-up labs ordered for thyroid function tests.'),
		(9, 9, 16, '2023-06-01 15:00:00', '2023-06-01 15:30:00', '2023-06-01 16:00:00', 1, 1, 207, 1, 'Pulmonary function test requested.'),
		(10, 10, 16, '2023-06-15 09:00:00', '2023-06-15 09:20:00', NULL, 3, 3, 208, 2, 'Colonoscopy scheduled for routine screening.');
    
    CREATE TABLE TreatmentHistory(
		treatment_id INT PRIMARY KEY AUTO_INCREMENT,
        mrn INT,
        treatment_type VARCHAR(100), -- Chemo, Radiation, Immunotherapy
        treatment_summary VARCHAR(500), -- Document a summary of a course of treatment 
        FOREIGN KEY (mrn) REFERENCES Patients(mrn),
        INDEX idx_treatment_mrn (mrn)
    );
    
    INSERT INTO TreatmentHistory (mrn, treatment_type, treatment_summary) 
	VALUES
		(1, 'Chemotherapy', 'Patient received a total of 6 cycles of AC regimen. Side effects included nausea and fatigue.'),
		(2, 'Radiation', 'Patient underwent 30 sessions of external beam radiation to the thoracic region with minimal side effects.'),
		(3, 'Immunotherapy', 'Started on Pembrolizumab, with infusion every 3 weeks. Tolerated well with mild fatigue.'),
		(4, 'Chemotherapy', 'Patient received 4 cycles of carboplatin and paclitaxel. Managed side effects with antiemetics.'),
		(5, 'Radiation', 'Patient completed a 7-week course of radiation therapy for localized prostate cancer.'),
		(6, 'Immunotherapy', 'Administered Nivolumab every 2 weeks. Patient reported mild rash and fatigue.'),
		(7, 'Chemotherapy', 'Patient completed 12 cycles of FOLFOX for colorectal cancer. Significant neuropathy managed with medications.'),
		(8, 'Radiation', 'Radiation therapy was provided for palliative care to alleviate pain from metastatic disease.'),
		(9, 'Immunotherapy', 'Started on Atezolizumab for lung cancer, with infusion every 3 weeks. Mild side effects observed.'),
		(10,'Chemotherapy', 'Patient received targeted therapy for breast cancer, tolerated well with no major side effects.');

########################################################
#               Labs/Tests Results                     #
########################################################
	
    
    CREATE TABLE PathologyReport(
		mrn INT,
        report_id INT PRIMARY KEY AUTO_INCREMENT, -- Specific ID of the report
        collection_date DATETIME,
        received_date DATETIME,
        report_date DATETIME NOT NULL,
        reporting_facility INT, 
        gross_description VARCHAR(1000),
        microscope_exam VARCHAR(1000),
        final_diagnosis VARCHAR(50),
        comments VARCHAR(500),
        summary VARCHAR(100),

        FOREIGN KEY (mrn) REFERENCES Patients(mrn),
        INDEX idx_path_mrn (mrn)
    );
    
    INSERT INTO PathologyReport (mrn, collection_date, received_date, report_date, reporting_facility, gross_description, microscope_exam, final_diagnosis, comments, summary) 
	VALUES
		(1, '2023-01-15 08:00:00', '2023-01-16 09:30:00', '2023-01-17 10:00:00', 1, 'Single mass, well-circumscribed', 'No significant abnormalities noted', 'Invasive ductal carcinoma', 'Margins are clear', 'Breast cancer'),
		(2, '2023-02-05 08:30:00', '2023-02-06 10:00:00', '2023-02-07 11:00:00', 2, 'Multiple nodules observed', 'Atypical cells present', 'Adenocarcinoma', 'Consider follow-up imaging', 'Lung cancer'),
		(3, '2023-03-10 09:00:00', '2023-03-11 09:45:00', '2023-03-12 10:30:00', 1, 'Large polyp with irregular borders', 'Dysplastic changes noted', 'High-grade dysplasia', 'Resection recommended', 'Colon cancer'),
		(4, '2023-01-25 09:30:00', '2023-01-26 10:15:00', '2023-01-27 11:00:00', 3, 'Enlarged prostate observed', 'Benign hyperplasia noted', 'Benign prostatic hyperplasia', 'No malignant cells identified', 'Prostate health'),
		(5, '2023-03-20 10:00:00', '2023-03-21 11:00:00', '2023-03-22 12:00:00', 2, 'Irregular skin lesion', 'Atypical melanocytes observed', 'Malignant melanoma', 'Surgical excision advised', 'Skin cancer'),
		(6, '2023-04-15 08:15:00', '2023-04-16 09:00:00', '2023-04-17 10:30:00', 1, 'Lytic bone lesions', 'Plasma cells abundant', 'Multiple myeloma', 'Chemotherapy initiated', 'Multiple myeloma'),
		(7, '2023-02-18 09:45:00', '2023-02-19 10:30:00', '2023-02-20 11:00:00', 3, 'Pelvic mass identified', 'Epithelial cells noted', 'Serous cystadenocarcinoma', 'Referral to oncology recommended', 'Ovarian cancer'),
		(8, '2023-05-05 10:30:00', '2023-05-06 11:15:00', '2023-05-07 12:00:00', 2, 'Enlarged liver', 'Focal lesions present', 'Hepatocellular carcinoma', 'Liver transplant evaluation suggested', 'Liver cancer'),
		(9, '2023-04-10 08:30:00', '2023-04-11 09:15:00', '2023-04-12 10:00:00', 1, 'Hematuria noted', 'Glomeruli appear normal', 'Renal cell carcinoma', 'Surgical options discussed', 'Kidney cancer'),
		(10,'2023-01-30 08:00:00', '2023-01-31 09:00:00', '2023-02-01 10:00:00', 3, 'Thyroid enlargement', 'Follicular cells noted', 'Follicular carcinoma', 'Endocrinology consult needed', 'Thyroid cancer');
        
   
    CREATE TABLE RadiologyReport(
		mrn INT, 
        report_id INT PRIMARY KEY AUTO_INCREMENT, 
        exam_date DATETIME,
        exam_facility INT, -- Link to where it was done previously
        reason VARCHAR(100), -- Why was it needed as all radiology reports are good but not all of them may be related to cancer diagnostic
        exam_type VARCHAR(25), -- Was it a CT, MRI, X-Ray?
        technique VARCHAR(255), -- With or without contrast for example
        findings VARCHAR(255), 
        impression VARCHAR(500), -- Diagnosis and Recommendations
        INDEX idx_rad_mrn (mrn),
        FOREIGN KEY (mrn) REFERENCES Patients(mrn)   
    );
    
    INSERT INTO RadiologyReport (mrn, report_id, exam_date, exam_facility, reason, exam_type, technique, findings, impression) 
	VALUES
		(1, 2001, '2023-01-15 09:00:00', 1, 'Routine check-up', 'MRI',  'With contrast', 'No abnormalities detected', 'Normal MRI of the brain. No lesions or masses.'),
		(2, 2002, '2023-02-20 10:30:00', 2, 'Chest pain evaluation', 'CT Chest',  'Without contrast', 'Mild pleural effusion noted', 'Suggest follow-up imaging to assess the effusion.'),
		(3, 2003, '2023-03-05 11:15:00', 1, 'Back pain assessment', 'X-Ray',  'Standard', 'Mild degenerative changes in the lumbar spine', 'Continue conservative management and follow-up if symptoms persist.'),
		(4, 2004, '2023-04-12 08:45:00', 3, 'Lung cancer screening', 'Low-dose CT',  'Without contrast', 'No significant nodules observed', 'Screening negative for lung cancer.'),
		(5, 2005, '2023-05-25 14:00:00', 2, 'Abdominal pain', 'CT Abdomen', 'With contrast', 'Appendix appears normal, no free fluid', 'No acute abdominal pathology detected.'),
		(6, 2006, '2023-06-10 09:30:00', 3, 'Knee pain', 'MRI', 'With contrast', 'Mild effusion, no ligament tears', 'Consider physical therapy for pain management.'),
		(7, 2007, '2023-07-15 11:00:00', 1, 'Follow-up on previous findings', 'Ultrasound', 'Standard', 'Thickened gallbladder wall', 'Recommend surgical consult for possible cholecystectomy.'),
		(8, 2008, '2023-08-22 10:30:00', 2, 'Headaches', 'CT Head', 'Without contrast', 'No acute intracranial abnormalities', 'Normal CT, follow up with neurologist if symptoms persist.'),
		(9, 2009, '2023-09-18 14:15:00', 3, 'Joint pain', 'MRI',  'Without contrast', 'Mild joint effusion, no tears detected', 'Physical therapy recommended for joint pain.'),
		(10, 2010, '2023-10-01 10:00:00', 1, 'Follow-up for cancer treatment', 'PET Scan', 'With contrast', 'Increased metabolic activity in the lung', 'Suggest oncological evaluation for further management.');
        
   -- Catch all for additional reporting things that don't have its own table due to following the same format
    CREATE TABLE AdditionalReports(
		mrn INT,
        report_id INT PRIMARY KEY AUTO_INCREMENT, 
        report_type VARCHAR(20) NOT NULL,
        report_date DATETIME,
        report_notes VARCHAR(500),
        INDEX idx_additional_mrn (mrn),
        FOREIGN KEY (mrn) REFERENCES Patients(mrn)   
        
    );
########################################################
# 		  Pharmaceutical Relating Information  		   #
########################################################
	-- Inventory of Medications
	CREATE TABLE DrugInventory(
		drug_inventory_id INT PRIMARY KEY AUTO_INCREMENT,
		ndc VARCHAR(20) NOT NULL,
        lot INT UNIQUE NOT NULL,
        instock INT NOT NULL,
        FOREIGN KEY (ndc) REFERENCES NDC(ndc),
        INDEX idx_druginv_ndc (ndc)
    );
    
    INSERT INTO DrugInventory (drug_inventory_id, ndc, lot, instock) 
	VALUES
		(1, '0703-3645-01', 2001, 50),  
		(2, '0075-8001-01', 2002, 30),  
		(3, '0075-8001-01', 2003, 20),  
		(4, '0013-7286-01', 2004, 40),  
		(5, '0006-3026-02', 2005, 25),  
		(6, '0015-3201-11', 2006, 15),  
		(7, '0015-3201-11', 2007, 35),  
		(8, '0015-3201-11', 2008, 60), 
		(9, '0006-3026-02', 2009, 45),  
		(10, '0013-7286-01', 2010, 55);
		
###############################################################
#                   		Logs							  #
###############################################################

	-- Primary Logs
	CREATE TABLE AuditLog(
		log_id INT PRIMARY KEY AUTO_INCREMENT,
		action_date DATETIME NOT NULL, -- Date and Time the changes were made
		mrn INT, -- If it was patient relating data, what paitent was changes made on. Null if it wa
		actor VARCHAR(20), -- Employee ID of who made the change
		action_taken VARCHAR(50), -- What was done such as an insertion, update or delete
		action_table VARCHAR(50), -- Table name to what action was taken on
        action_field VARCHAR(50), -- Table column the change was made to
		old_data VARCHAR(255), -- What was originally there if an update or delete. Null on insertion
		new_data VARCHAR(255), -- What was imputed if the action was an update or insertion. Null on delete
		FOREIGN KEY (mrn) REFERENCES Patients(mrn),
		FOREIGN KEY (actor) REFERENCES Staff(employee_id),
        INDEX idx_audit_mrn (mrn),
        INDEX idx_audit_actor (actor)       
	);
    
	-- Log when someone gets a medication from supplies 
	CREATE TABLE MedicationDispensingLog (
		dispense_id INT PRIMARY KEY AUTO_INCREMENT,
		mrn INT NOT NULL, -- who is recieving the medication
		drug_inventory_id INT NOT NULL, -- The medication being dispensed
		dispense_datetime DATETIME NOT NULL, -- Date and time of dispensing
		dispensed_by VARCHAR(20), -- The employee who dispensed the medication 
		quantity_dispensed INT NOT NULL, -- How much of the drug was dispensed
		notes VARCHAR(255), 
		FOREIGN KEY (mrn) REFERENCES Patients(mrn),        
		FOREIGN KEY (drug_inventory_id) REFERENCES DrugInventory(drug_inventory_id),
		FOREIGN KEY (dispensed_by) REFERENCES Staff(employee_id),
        INDEX idx_dispensing_mrn (mrn),
        INDEX idx_dispensing_actor (dispensed_by)
	);
    
    
    
    

