
Administrative & Reference Tables
<details> <summary><strong>Specialty</strong></summary>
  
| Column	| Definition |
| -------- | ------- |
| specialty_id |	Unique identifier for each specialty |
| specialty_name |	Name of the medical specialty (e.g., Dermatology, Pediatrics) |

</details>
<details> <summary><strong>Billing Codes</strong></summary>
  
| Column |	Definition |
| -------- | ------- |
| code_type |	Type of billing code (ICD-9, ICD-10, CPT) |
| specified_code |	The actual billing code |
| short_description | 	Brief description of the code |
| long_description	| Detailed explanation of the diagnosis or procedure |

</details>
<details> <summary><strong>NDC</strong></summary>
  
| Column |	Definition |
| -------- | ------- |
|ndc|	National Drug Code identifier|
|brand_name	|Brand name of the drug|
|generic_name|	Generic name|
|strength	|Amount of active ingredient per unit|
|route|	Route of administration (Oral, IV, etc.)|
|dea_class|	DEA controlled substance classification|

</details>
Facilities & Locations
<details> <summary><strong>Facilities</strong></summary>
  
| Column |	Definition |
| -------- | ------- |
|facility_id|	Unique identifier|
|facility_name|	Name of facility|
|facility_type	|Type (Primary Care, ENT, etc.)|
|address_line1	|Address line 1|
|address_line2	|Address line 2|
|city|	City|
|state	|State abbreviation|
|zipcode	|Postal code|
|phone_number	|Phone number|
|fax_number|	Fax number|
|email|	Email address|

</details>
<details> <summary><strong>Pharmacies</strong></summary>
  
| Column |	Definition |
| -------- | ------- |
|pharmacy_id|	Unique identifier|
|pharmacy_name|	Pharmacy name|
|address_line1	|Address line 1|
|address_line2	|Address line 2|
|city	|City|
|state	|State|
|zipcode|	Postal code|
|phone_number	|Phone number|
|fax_number	|Fax number|
|email	|Email address|

</details>
Patient & Demographics
<details> <summary><strong>Patients</strong></summary>
  
| Column |	Definition |
| -------- | ------- |
|mrn|	Unique medical record number|
|first_name	|First name|
|middle_name	|Middle name|
|last_name	|Last name|
|sex	|Biological sex|
|gender	Gender |identity|
|address_line1	|Address line |
|address_line2|	Address line 2|
|city	|City|
|state	|State|
|zipcode|	Postal code|
|home_number|	Home phone|
|cell_number	|Cell phone|
|work_number|	Work phone|
|email	|Email|
|emergency_contact	|Emergency contact name|
|emergency_contact_number|	Emergency contact phone|
|primary_language|	Primary language|
|preferred_pharmacy_id|	Preferred pharmacy|
|living_status|	Alive or deceased|
|dnr|	Do Not Resuscitate status|
|blood_type	|Blood type|

</details>

Providers & Staff
<details> <summary><strong>Providers</strong></summary>
  
| Column |	Definition |
| -------- | ------- |
|provider_id|	Unique identifier|
|onsite	|Practices in clinic (Y/N)|
|npi|	National Provider Identifier|
|first_name	|First name|
|middle_name	|Middle name|
|last_name	|Last name|
|suffix|Name suffix|
|specialty_id	|Reference to Specialty|
|phone_number	|Phone|
|fax_number|	Fax|
|email	|Email|
|primary_location	|Primary facility|

</details>
<details> <summary><strong>Staff</strong></summary>
  
| Column |	Definition |
| -------- | ------- |
|employee_id	|Unique identifier|
|first_name|	First name|
|middle_name	|Middle name|
|last_name|	Last name|
|address_line1	|Address line 1|
|address_line2|	Address line 2|
|city	|City|
|state|	State|
|zipcode|	Postal code|
|personal_email|	Personal email|
|work_email	|Work email|
|phone_number|	Phone|
|staff_position	|Job title|
|department|	Department|
|ssn	|Social Security Number (will need hashing later)|
|dob	|Date of birth|
|employment_start	|Hire date|
|employment_end|	Termination date|
  
</details>
Encounters & Scheduling
<details> <summary><strong>Encounters</strong></summary>
  
| Column |	Definition |
| -------- | ------- |
|encounter_id	|Unique identifier|
|mrn	|Patient MRN|
|encounter_datetime|	Date and time|
|chief_concern|	Reason for visit|
|encounter_status	|Status|
|location	|Clinic, phone, telemedicine, etc.|
|notes|	Additional notes|

</details>
<details> <summary><strong>Appointments</strong></summary>
  
| Column |	Definition |
| -------- | ------- |
|appt_id|	Unique identifier|
|mrn	|Patient MRN|
|appt_datetime|	Date and time|
|reason	|Appointment reason|
|notes|	Additional notes|
|provider_id	|Assigned provider|

</details>
Clinical Data
<details> <summary><strong>Problem List</strong></summary>
  
| Column |	Definition |
| -------- | ------- |
|mrn	|Patient MRN|
|problem_id|	Problem identifier|
|problem_icd	|ICD system used|
|problem_code|	Diagnosis code|
|onset	|Symptom onset date|
|importance	|Priority level|
|problem_status|	Status|
|current_plan	|Treatment plan reference|
|additional_notes|	Notes|

</details>
<details> <summary><strong>Allergies</strong></summary>
  
| Column |	Definition |
| -------- | ------- |
|mrn	|Patient MRN|
|allergy_id|	Unique identifier|
|allergen	|Substance|
|reaction	|Reaction description|
|severity|	Severity level|
</details>
<details> <summary><strong>Vitals (Basics)</strong></summary>
  
| Column |	Definition |
| -------- | ------- |
|mrn|	Patient MRN|
|encounter_id|	Encounter reference|
|weight	|Weight|
|height	|Height|
|bmi|	Body Mass Index|
|temp	|Temperature|
|temp_method|	Measurement method|
|systolic|	Systolic BP|
|diastolic	|Diastolic BP|
|pulse	|Heart rate|
|respiration_rate	|Respiratory rate|
|oxygen_saturation	|O2 saturation|
|pain_scale|	Pain score|
|notes|	Additional notes|
</details>
Medications
<details> <summary><strong>Prescriptions</strong></summary>
  
| Column |	Definition |
| -------- | ------- |
|mrn|	Patient MRN|
|rx_id	|Prescription ID|
|ndc|	Drug code|
|date_prescribed	|Date prescribed|
|reason|	Indication|
|dosage	|Dose|
|frequency	|Frequency|
|start_date|	Start date|
|end_date	|End date|
|notes|Instructions or side effects|

</details>
Billing & Insurance
<details> <summary><strong>Billing</strong></summary>
  
| Column |	Definition |
| -------- | ------- |
|billing_id	|Unique identifier|
|mrn	|Patient MRN|
|encounter_id	|Encounter reference|
|description_of_services|	Services provided|
|total_amount|	Insurance-covered amount|
|patient_bill_amount|	Patient responsibility|
|payment_status	|Payment status|

</details>
<details> <summary><strong>Insurance</strong></summary>
  
| Column |	Definition |
| -------- | ------- |
|mrn|Patient MRN|
|is_primary|Primary or secondary|
|provider	|Insurance company|
|plan_type|	Plan type|
|subscriber_id|Subscriber identifier|
|member_id|	Member identifier|
|group_number|	Group number|
|subscriber_first_name	|Subscriber first name|
|subscriber_last_name	|Subscriber last name|
|subscriber_relation|	Relationship to patient|
|copay|	Copay amount|

</details>
System & Security
<details> <summary><strong>Users</strong></summary>
  
| Column |	Definition |
| -------- | ------- |
|acct_id	|Account ID|
|acct_username	|Username|
|acct_password	|Password |
|linked_id	|Employee ID or MRN|
|acct_role	|Role (provider, nurse, patient, etc.)|

</details>
<details> <summary><strong>Audit Log</strong></summary>
  
| Column |	Definition |
| -------- | ------- |
|log_id|	Unique identifier|
|action_date|	Timestamp|
|mrn|	Patient affected|
|actor|	Employee who made change|
|action_taken|	Description|
|action_table	|Table modified|
|action_field|	Field modified|
|old_data|	Previous value|
|new_data|	New value|
</details>

