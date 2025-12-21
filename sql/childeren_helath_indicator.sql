CREATE DATABASE HealthData2017_18

USE HealthData2017_18

CREATE TABLE BirthAndImmunizationData(
	sl_no INT,
	district_name NVARCHAR(255),	
	total_live_births	INT,
	total_still_births INT,	
	newborn_weighet_birth INT,
	newborn_lessthan_two_and_half_kg INT,
	newborn_breastfed_within_1hour	INT,
	sex_ratio_at_birth	INT															
)

BULK INSERT BirthAndImmunizationData
FROM 'C:\Users\sneha\Desktop\project1\health_data\BirthandImmunizationData.CSV'
WITH (
	
	FIELDTERMINATOR = ',',
	FIRSTROW=2
)

SELECT *
FROM BirthAndImmunizationData

CREATE TABLE ImmunizationData(
	sl_no INT,	
	district_name NVARCHAR(255),
	infants_given_OPV_zero INT,
	infants_given_BCG INT,
	infants_given_Hep_B0 INT,
	infants_given_DPT1	INT,
	infants_given_DPT2	INT,
	infants_given_DPT3	INT,
	infants_given_Pentavalent1 INT,
	infants_given_Pentavalent2 INT,
	infants_given_Pentavalent3 INT,	
	infants_given_measles INT,
	infants_given_MR	INT,
	FullyImmunizedChildren_9_11Months int										
)

BULK INSERT ImmunizationData
FROM 'C:\Users\sneha\Desktop\project1\health_data\ImmunizationData.CSV'
WITH(
	FIELDTERMINATOR = ',',
	FIRSTROW =2	
)


CREATE TABLE ChildHealthData (
    sl_no INT,  
    district_name NVARCHAR(255),  
    pneumonia_in_children_0_5_years INT,
    asthma_in_children_0_5_years INT,  
    sepsis_in_children_0_5_years INT,  
    diphtheria_in_children_0_5_years INT,  
    tb_in_children_0_5_years INT,  
    measles_in_children_0_5_years INT,  
    malaria_in_children_0_5_years INT, 
    diarrhoea_in_children_0_5_years INT,  
    diarrhoea_treated_in_inpatients_0_5_years INT,
    infants_given_measles_rubella_vaccine_1st_dose INT,
    infants_received_rotavirus_vaccine_1st_dose INT,  
    infants_received_rotavirus_vaccine_2nd_dose INT, 
    infants_received_rotavirus_vaccine_3rd_dose INT,  
    children_16_24_months_given_measles_2nd_dose INT,  
    children_16_24_months_given_measles_rubella_vaccine_2nd_dose INT 
);

BULK INSERT ChildHealthData
FROM 'C:\Users\sneha\Desktop\project1\health_data\ChildHealthData.CSV'
WITH(
	FIELDTERMINATOR = ',',
	FIRSTROW = 2
)


--1. Verify Data Insertion

SELECT COUNT(*) AS Total_row
FROM BirthAndImmunizationData

--1. Handle Missing Values: Replace or Remove NULL Values
SELECT * 
FROM BirthAndImmunizationData
WHERE total_live_births IS NULL
   OR total_still_births IS NULL
   OR new_borns_weighed_at_birth IS NULL
   OR new_borns_less_than_2_5kg IS NULL
   OR new_borns_breastfed_within_1hour IS NULL
   OR sex_ratio_at_birth IS NULL;


select district_name
FROM BirthAndImmunizationData
WHERE TRIM(district_name) != district_name

SELECT *
FROM BirthAndImmunizationData
WHERE total_live_births IS NULL
	OR total_still_births IS NULL
	OR newborn_weighet_birth IS NULL
	OR newborn_lessthan_two_and_half_kg IS NULL
	OR newborn_breastfed_within_1hour IS NULL
	OR sex_ratio_at_birth IS NULL

SELECT 
	COUNT(*) AS TotalRow,
	COUNT(DISTINCT district_name) AS TotalDistricts,
	SUM(CASE WHEN total_live_births IS NULL THEN 1 ELSE 0 END) AS  Missing_total_live_births,
	SUM(CASE WHEN total_still_births IS NULL THEN 1 ELSE 0 END) AS Missing_total_still_births,
	SUM(CASE WHEN newborn_weighet_birth IS NULL THEN 1 ELSE 0 END) AS Missing_newborn_weighet_birth,
	SUM(CASE WHEN newborn_lessthan_two_and_half_kg IS NULL THEN 1 ELSE 0 END) AS Missing_newborn_lessthan_two_and_half_kg,
	SUM(CASE WHEN newborn_breastfed_within_1hour IS NULL THEN 1 ELSE 0 END) AS Missing_newborn_breastfed_within_1hour,
	SUM(CASE WHEN sex_ratio_at_birth IS NULL THEN 1 ELSE 0 END) AS sex_ratio_at_birth
FROM BirthAndImmunizationData


-- Total Number of Live Births Per District
SELECT 
	district_name,
	SUM(total_live_births) AS total_live_births
FROM BirthAndImmunizationData
GROUP BY district_name
ORDER BY SUM(total_live_births) DESC

--Percentage of Newborns Weighed at Birth Per District

SELECT district_name,
(SUM(newborn_weighet_birth) * 100 / SUM(total_live_births)) AS newborn_weighed_percentage
FROM BirthAndImmunizationData
GROUP BY district_name


--What is the total number of live births and stillbirths reported across districts?

SELECT 
	district_name,
	SUM(total_live_births) AS total_live_births,
	SUM(total_still_births) AS total_still_births
FROM BirthAndImmunizationData
GROUP BY district_name

--Which districts have TOP 5  highest rates of  HIGH AND low birth weight (newborns under 2.5 kg)?

SELECT TOP 5
district_name,
newborn_lessthan_two_and_half_kg
FROM BirthAndImmunizationData
ORDER BY newborn_lessthan_two_and_half_kg DESC


SELECT TOP 5
district_name,
newborn_lessthan_two_and_half_kg
FROM BirthAndImmunizationData
ORDER BY newborn_lessthan_two_and_half_kg 

--top 5 cities of live births
SELECT TOP 5
	district_name,
	total_live_births
FROM BirthAndImmunizationData
ORDER BY total_live_births DESC
 
 -- Combined query for highest and lowest total live births
-- District with the highest total live births
SELECT TOP 1 
    district_name,
    SUM(total_live_births) AS  Highest_total_live_births
FROM BirthAndImmunizationData
GROUP BY district_name
ORDER BY Highest_total_live_births DESC;

-- District with the lowest total live births
SELECT TOP 1 
    district_name,
    SUM(total_live_births) AS Lowest_total_live_births
FROM BirthAndImmunizationData
GROUP BY district_name
ORDER BY Lowest_total_live_births ASC;


SELECT *
FROM BirthAndImmunizationData


SELECT TOP 5
district_name,
total_still_births
FROM BirthAndImmunizationData
ORDER BY total_still_births DESC


SELECT TOP 5
district_name,
total_still_births
FROM BirthAndImmunizationData
ORDER BY total_still_births ASC

--Number of Underweight Newborns by District:
SELECT TOP 5 
    district_name, 
    SUM(newborn_lessthan_two_and_half_kg) AS underweight_newborns
FROM BirthAndImmunizationData
GROUP BY district_name
ORDER BY underweight_newborns DESC;

--Breastfeeding Rate Within 1 Hour by District:

SELECT TOP 5 district_name, 
       SUM(newborn_breastfed_within_1hour) AS breastfed_within_1hour
FROM BirthAndImmunizationData
GROUP BY district_name
ORDER BY breastfed_within_1hour DESC;

SELECT district_name, 
       SUM(total_live_births) AS total_live_births, 
       SUM(total_still_births) AS total_still_births,
       SUM(newborn_lessthan_two_and_half_kg) AS underweight_newborns
FROM BirthAndImmunizationData
GROUP BY district_name;


SELECT *
FROM ImmunizationData

ALTER TABLE ImmunizationData
ADD  total_live_births INT

UPDATE i
SET i.total_live_births = b.total_live_births
FROM ImmunizationData i
JOIN BirthAndImmunizationData b
    ON i.district_name = b.district_name;

--What percentage of infants received each vaccine (OPV, BCG, DPT, Pentavalent, Measles, etc.) in each district?
SELECT 
    district_name,
    SUM(infants_given_OPV_zero) * 100 / SUM(total_live_births) AS OPV_zero_percentage,
    SUM(infants_given_BCG) * 100 / SUM(total_live_births) AS BCG_percentage,
    SUM(infants_given_Hep_B0) * 100 / SUM(total_live_births) AS Hep_B0_percentage,
    SUM(infants_given_DPT1) * 100 / SUM(total_live_births) AS DPT1_percentage,
    SUM(infants_given_DPT2) * 100 / SUM(total_live_births) AS DPT2_percentage,
    SUM(infants_given_DPT3) * 100 / SUM(total_live_births) AS DPT3_percentage,
    SUM(infants_given_Pentavalent1) * 100 / SUM(total_live_births) AS Pentavalent1_percentage,
    SUM(infants_given_Pentavalent2) * 100 / SUM(total_live_births) AS Pentavalent2_percentage,
    SUM(infants_given_Pentavalent3) * 100 / SUM(total_live_births) AS Pentavalent3_percentage,
    SUM(infants_given_measles) * 100 / SUM(total_live_births) AS Measles_percentage,
    SUM(infants_given_MR) * 100 / SUM(total_live_births) AS MR_percentage
FROM 
    ImmunizationData
GROUP BY 
    district_name;


--Which districts have the highest and lowest immunization coverage for each vaccine?\
SELECT TOP 5 
    district_name,
    SUM(infants_given_OPV_zero) * 100 / SUM(total_live_births) AS OPV_zero_percentage
FROM 
    ImmunizationData
GROUP BY 
    district_name
ORDER BY OPV_zero_percentage DESC;

--What is the overall immunization rate for infants by 9-11 months across all districts?
SELECT 
    SUM(FullyImmunizedChildren_9_11Months) * 100 / SUM(total_live_births) AS Overall_Immunization_Rate
FROM 
    ImmunizationData;

--Are there any districts where immunization coverage for key vaccines (OPV, BCG, DPT) is significantly lower than others?
SELECT 
    district_name,
    SUM(total_live_births) - SUM(infants_given_OPV_zero) AS OPV_zero_gap,
    SUM(total_live_births) - SUM(infants_given_BCG) AS BCG_gap,
    SUM(total_live_births) - SUM(infants_given_DPT1) AS DPT1_gap
FROM 
    ImmunizationData
GROUP BY 
    district_name
ORDER BY 
    OPV_zero_gap DESC;


--Which vaccines have the largest coverage gaps in each district?
SELECT 
    district_name,
    CASE 
        WHEN (SUM(total_live_births) - SUM(infants_given_OPV_zero)) > 
             (SUM(total_live_births) - SUM(infants_given_BCG)) 
             AND (SUM(total_live_births) - SUM(infants_given_OPV_zero)) > 
             (SUM(total_live_births) - SUM(infants_given_DPT1)) 
        THEN 'OPV'
        WHEN (SUM(total_live_births) - SUM(infants_given_BCG)) > 
             (SUM(total_live_births) - SUM(infants_given_OPV_zero)) 
             AND (SUM(total_live_births) - SUM(infants_given_BCG)) > 
             (SUM(total_live_births) - SUM(infants_given_DPT1)) 
        THEN 'BCG'
        ELSE 'DPT'
    END AS Largest_Gap_Vaccine
FROM 
    ImmunizationData
GROUP BY 
    district_name;


--What percentage of children are fully immunized by 9-11 months across different districts?
SELECT 
    district_name,
    SUM(FullyImmunizedChildren_9_11Months) * 100 / SUM(total_live_births) AS FullyImmunizedPercentage
FROM 
    ImmunizationData
GROUP BY 
    district_name;

SELECT
	district_name,
	infants_given_DPT1,
	infants_given_DPT2,
	infants_given_DPT3
FROM ImmunizationData


CREATE TABLE #infants_given_DPT(

	infants_given_DPT1 INT,
	infants_given_DPT2 INT,
	infants_given_DPT3 INT,
	Total_infants_given_DPT INT
)

ALTER TABLE #infants_given_DPT
ADD Total_infants_given_DPT INT;

ALTER TABLE #infants_given_DPT
ADD district_name NVARCHAR(255)

INSERT INTO #infants_given_DPT(district_name, infants_given_DPT1, infants_given_DPT2, infants_given_DPT3, Total_infants_given_DPT)
SELECT
	district_name,
	infants_given_DPT1, infants_given_DPT2, infants_given_DPT3,
	(infants_given_DPT1+infants_given_DPT2+ infants_given_DPT3)as Total_infants_given_DPT
FROM ImmunizationData

SELECT TOP 5
    district_name,
    Total_infants_given_DPT
FROM #infants_given_DPT
ORDER BY Total_infants_given_DPT DESC;



SELECT  
	district_name,
	Total_infants_given_DPT

FROM #infants_given_DPT
WHERE Total_infants_given_DPT =0

SELECT *
FROM ImmunizationData

SELECT 
    district_name,
    SUM(infants_given_DPT1 + infants_given_DPT2 + infants_given_DPT3) AS total_infants_given_DPT)
FROM ImmunizationData
GROUP BY district_name;

-- Step 1: Create Temporary Table
CREATE TABLE #vaccination_totals (
    district_name NVARCHAR(255),
    total_live_births INT,
    total_dpt_vaccinated INT,
    total_pentavalent_vaccinated INT
);

-- Step 2: Insert Data into Temporary Table (Aggregated Data)
INSERT INTO #vaccination_totals (district_name, total_live_births, total_dpt_vaccinated, total_pentavalent_vaccinated)
SELECT
    district_name,
    SUM(total_live_births) AS total_live_births,
    SUM(infants_given_DPT1 + infants_given_DPT2 + infants_given_DPT3) AS total_dpt_vaccinated,
    SUM(infants_given_Pentavalent1 + infants_given_Pentavalent2 + infants_given_Pentavalent3) AS total_pentavalent_vaccinated
FROM ImmunizationData
GROUP BY district_name;

-- Step 3: Identify Vaccination Gaps
SELECT 
    district_name,
    total_live_births,
    total_dpt_vaccinated,
    total_pentavalent_vaccinated,
    (total_live_births - total_dpt_vaccinated) AS gap_in_dpt_vaccination,
    (total_live_births - total_pentavalent_vaccinated) AS gap_in_pentavalent_vaccination
FROM #vaccination_totals
WHERE total_live_births > 0;

-- Step 1: Create Temporary Table for Aggregated Data
CREATE TABLE #vaccination_stage (
    district_name NVARCHAR(255),
    total_live_births INT,
    total_dpt_vaccinated INT,
    total_pentavalent_vaccinated INT,
    dpt_coverage_percentage DECIMAL(5, 2),
    pentavalent_coverage_percentage DECIMAL(5, 2),
    vaccination_difference INT
);

-- Step 2: Aggregate Data
INSERT INTO #vaccination_stage (district_name, total_live_births, total_dpt_vaccinated, total_pentavalent_vaccinated)
SELECT
    district_name,
    SUM(total_live_births),
    SUM(infants_given_DPT1 + infants_given_DPT2 + infants_given_DPT3),
    SUM(infants_given_Pentavalent1 + infants_given_Pentavalent2 + infants_given_Pentavalent3)
FROM ImmunizationData
GROUP BY district_name;

-- Step 3: Calculate Coverage Percentages
UPDATE #vaccination_stage
SET 
    dpt_coverage_percentage = (total_dpt_vaccinated * 100.0 / total_live_births),
    pentavalent_coverage_percentage = (total_pentavalent_vaccinated * 100.0 / total_live_births);

-- Step 4: Calculate the Difference Between Vaccinated and Total Infants (Vaccination Gap)
UPDATE #vaccination_stage
SET vaccination_difference = total_live_births - total_dpt_vaccinated;

-- Step 5: Query the Results
SELECT 
    district_name,
    dpt_coverage_percentage,
    pentavalent_coverage_percentage,
    vaccination_difference
FROM #vaccination_stage
ORDER BY vaccination_difference DESC;


SELECT *
FROM ChildHealthData

ALTER TABLE ChildHealthData
ADD total_live_births INT

UPDATE c
SET c.total_live_births = i.total_live_births
FROM ChildHealthData c
JOIN ImmunizationData i
	ON c.district_name = i.district_name

SELECT 
    district_name,
	total_live_births,
	pneumonia_in_children_0_5_years,
	asthma_in_children_0_5_years,
	sepsis_in_children_0_5_years,
	diphtheria_in_children_0_5_years,
	tb_in_children_0_5_years,
	measles_in_children_0_5_years,
	malaria_in_children_0_5_years,
	diarrhoea_in_children_0_5_years
FROM ChildHealthData

SELECT 
	district_name,
	total_live_births,
	diarrhoea_in_children_0_5_years,
	diarrhoea_treated_in_inpatients_0_5_years,
	(diarrhoea_in_children_0_5_years -diarrhoea_treated_in_inpatients_0_5_years) AS Not_treated_diarrhoea_in_children_0_5_years,
	(diarrhoea_treated_in_inpatients_0_5_years * 100.0 / diarrhoea_in_children_0_5_years) AS Treatment_coverage_percentage
FROM ChildHealthData


SELECT
	district_name,
    infants_received_rotavirus_vaccine_1st_dose AS total_rotavirus_1st_dose,
    infants_received_rotavirus_vaccine_2nd_dose AS total_rotavirus_2nd_dose,
    infants_received_rotavirus_vaccine_3rd_dose AS total_rotavirus_3rd_dose,
	    -- Measles-Rubella 1st dose for children 
	 infants_given_measles_rubella_vaccine_1st_dose AS total_measles_rubella_1st_dose,
    -- Measles-Rubella 2nd dose for children aged 16-24 months
    children_16_24_months_given_measles_rubella_vaccine_2nd_dose AS total_measles_rubella_2nd_dose
FROM ChildHealthData;

SELECT 
    district_name,
    total_live_births,
    diarrhoea_in_children_0_5_years,
    infants_received_rotavirus_vaccine_1st_dose,
    (diarrhoea_in_children_0_5_years - infants_received_rotavirus_vaccine_1st_dose) AS gap_in_rotavirus_vaccine,
    (diarrhoea_in_children_0_5_years * 100.0 / total_live_births) AS diarrhoea_rate_percentage
FROM ChildHealthData
WHERE (diarrhoea_in_children_0_5_years - infants_received_rotavirus_vaccine_1st_dose) > 0  -- Gap in vaccination
ORDER BY gap_in_rotavirus_vaccine DESC;


SELECT 
    district_name,
    pneumonia_in_children_0_5_years,
    measles_in_children_0_5_years,
    (infants_given_measles_rubella_vaccine_1st_dose * 100.0 / total_live_births) AS measles_rubella_1st_dose_coverage_percentage,
    (diarrhoea_in_children_0_5_years * 100.0 / total_live_births) AS diarrhoea_rate_percentage
FROM ChildHealthData
WHERE pneumonia_in_children_0_5_years > 100  -- Example condition: pneumonia cases > 100
ORDER BY measles_rubella_1st_dose_coverage_percentage DESC;
