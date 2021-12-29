clear all
set more off

/* Set working directory */
cd "C:\Users\Admin\Desktop\Data Science"

/* Create log file */
capture log close
log using "1.corrupt.log", replace

/* Import excel file */
import excel using "NY.GDP.PCAP.PP.CD.2.xlsx", firstrow clear

drop A

/* Save cleaned data */
save 1.corrupt.clean.dta, replace

///////////////// adding another variable /////////////////

/* Import excel file */
import excel using "CPI.xlsx", firstrow clear

/* Cleaning dataset, renaming column/variable names */
drop if Indicator=="Rank"
drop IndicatorId SubindicatorType Indicator
rename CountryName country
rename CountryISO3 code
rename F Y2012
rename G Y2013
rename H Y2014
rename I Y2015
rename J Y2016
rename K Y2017
rename L Y2018
rename M Y2019
rename N Y2020

/* Keep countries needed for visualisation */
keep if code == "RUS" | code == "EST" | code == "LVA"| code == "LTU"| code == "BLR"| code == "UKR"| code == "ARM"| code == "KGZ"| code == "GEO" | code == "MDA" | code == "KAZ"| code == "TJK"| code == "UZB"| code == "AZE"| code == "GBR"| code == "MLT"| code == "SGP" | code == "IRL" | code == "IND"| code == "MYS"| code == "ZAF"| code == "FJI"| code == "EGY"| code == "ZWE"| code == "MMR" | code == "JAM" | code == "IRQ"| code == "LKA"| code == "ESP"| code == "LUX"| code == "ITA"| code == "NLD"| code == "MEX" | code == "PER" | code == "MAR"| code == "ARG"| code == "GTM"| code == "NIC"| code == "COL"| code == "VEN"| code == "URY" | code == "PRY"

/* Save cleaned data */
save 2.corrupt.clean.dta, replace

/* Export CPI dataset, and rearrange dataset in Excel into 1 column */

///////////////// merging the variables /////////////////

/* Import excel file */
import excel using "CPI.3.xlsx", firstrow clear

/* Merging CPI and GDPPC by country and year */
merge 1:1 country year using 1.corrupt.clean.dta

/* Cleaning dataset, drop missing values */
drop _merge
drop if cpi==.
drop if gdppc==.

/* Save cleaned data */
save 3.corrupt.clean.dta, replace

/* Create scatter plot and best fit line */
tw (scatter gdppc cpi) (lfit gdppc cpi)

/* Export final dataset */

/* Actual regression is made in Python in Colab Notebook */

log close
