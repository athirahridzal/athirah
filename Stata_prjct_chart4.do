clear all
set more off

/* Set working directory */
cd "C:\Users\Admin\Desktop\Data Science"

/* Create log file */
capture log close
log using "1.taxburden.log", replace

/* Import excel file */
import excel using "GC.TAX.TOTL.GD.ZS.xlsx", firstrow clear

drop A

/* Save cleaned data */
save 1.taxburden.clean.dta, replace

///////////////// merging the variables /////////////////

/* Import excel file */
import excel using "NY.GDP.PCAP.PP.CD.xlsx", firstrow clear

drop A

/* Merging tax revenue % of gdp and GDPPC by country and year */
merge 1:1 country year using 1.taxburden.clean.dta

/* Cleaning dataset, drop missing values */
drop _merge
drop if gdppc==.
drop if taxrev==.

/* Generate tax revenue per capita */
gen taxrpc = taxrev*gdppc

/* Save merged, cleaned data */
save 1.taxburden.clean.dta, replace

///////////////// merging adding another variable - Fiscal Freedom /////////////////

/* Import excel file */
import excel using "Fiscal Freedom.xlsx", firstrow clear

/* Cleaning dataset, renaming column/variable names */
keep if Indicator=="Fiscal freedom score"
drop CountryISO3 IndicatorId SubindicatorType Indicator J K
rename CountryName country
rename F Y2013
rename G Y2014
rename H Y2015
rename I Y2016

/* Save cleaned data */
save 2.taxburden.clean.dta, replace

///////////////// Fiscal Freedom for 2017 - 2019 is downloaded separately /////////////////

/* Import excel file */
import excel using "index2017_data.xlsx", firstrow clear

/* Cleaning dataset, renaming column/variable names */
keep CountryName TaxBurden
rename TaxBurden Y2017
rename CountryName country

/* Merging fiscal freedom, more years by country */
merge m:1 country using 2.taxburden.clean.dta

/* Save merged, cleaned data */
save 2.taxburden.clean.dta, replace

/* Import excel file */
import excel using "index2018_data.xlsx", firstrow clear

/* Cleaning dataset, renaming column/variable names */
keep CountryName TaxBurden
rename TaxBurden Y2018
rename CountryName country

/* Merging fiscal freedom, more years by country */
merge m:m country using 2.taxburden.clean.dta, generate(_merge2)

/* Save merged, cleaned data */
save 2.taxburden.clean.dta, replace

/* Import excel file */
import excel using "index2019_data.xlsx", firstrow clear

/* Cleaning dataset, renaming column/variable names */
keep CountryName TaxBurden
rename TaxBurden Y2019
rename CountryName country

/* Merging fiscal freedom, more years by country */
merge m:m country using 2.taxburden.clean.dta, generate(_merge3)

/* Save merged, cleaned data */
save 2.taxburden.clean.dta, replace

/* Cleaning dataset,  */
drop _merge _merge2 _merge3
destring Y2019, replace force
destring Y2018, replace force
destring Y2017, replace force
drop if country==""

/* Save cleaned data */
save 2.taxburden.clean.dta, replace

/* Export fiscal freedom dataset, and rearrange dataset in Excel into 1 column */

///////////////// merging all the variables /////////////////

/* Import excel file */
import excel using "taxburdenstata.xlsx", firstrow clear

/* Merging tax revenue per capita, GDPPC and fiscal freedom by country and year */
merge 1:1 country year using 1.taxburden.clean.dta

/* Cleaning dataset, drop missing values */
drop _merge
drop if gdppc==.
drop if taxrev==.

/* Save cleaned data */
save 1.taxburden.clean.dta, replace

/* Export final dataset */

log close
