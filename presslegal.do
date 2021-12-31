clear all
set more off

/* Set working directory */
cd "C:\Users\Admin\Desktop\Data Science"

/* Create log file */
capture log close
log using "1.presslegal.log", replace

/* Import excel file */
import excel using "IC.LGL.CRED.XQ.xlsx", firstrow clear

drop A

/* Save cleaned data */
save 1.presslegal.clean.dta, replace

///////////////// adding another variable /////////////////

/* Import excel file */
import excel using "PFI.xlsx", firstrow clear

/* Cleaning dataset, renaming column/variable names */
drop if Indicator=="Press Freedom Rank"
drop IndicatorId SubindicatorType Indicator
rename CountryName country
rename CountryISO3 code
rename P Y2013
rename Q Y2014
rename R Y2015
rename S Y2016
rename T Y2017
rename U Y2018
rename V Y2019

/* Dropping years before 2013 and after 2019, as data on legal rights index is available for 2013 - 2019 */
drop F G H I J K L M N O X W 

/* Keep countries needed for visualisation */
keep if code == "RUS" | code == "EST" | code == "LVA"| code == "LTU"| code == "BLR"| code == "UKR"| code == "ARM"| code == "KGZ"| code == "GEO" | code == "MDA" | code == "KAZ"| code == "TJK"| code == "UZB"| code == "AZE"| code == "GBR"| code == "MLT"| code == "SGP" | code == "IRL" | code == "IND"| code == "MYS"| code == "ZAF"| code == "FJI"| code == "EGY"| code == "ZWE"| code == "MMR" | code == "JAM" | code == "IRQ"| code == "LKA"| code == "ESP"| code == "LUX"| code == "ITA"| code == "NLD"| code == "MEX" | code == "PER" | code == "MAR"| code == "ARG"| code == "GTM"| code == "NIC"| code == "COL"| code == "VEN"| code == "URY" | code == "PRY"

/* Save cleaned data */
save 2.presslegal.clean.dta, replace

/* Export PFI dataset, and rearrange dataset in Excel into 1 column */

///////////////// merging the variables /////////////////

/* Import excel file */
import excel using "PFIstata.xlsx", firstrow clear

/* Merging PFI and legal rights index by country and year */
merge 1:1 country year using 1.presslegal.clean.dta

/* Cleaning dataset, drop missing values */
drop _merge
drop if legalrights==.
drop if pressindex==.

/* Save cleaned data */
save 1.presslegal.clean.dta, replace

/* Export final dataset */


log close