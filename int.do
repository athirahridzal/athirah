clear all
set more off

/* Set working directory */
cd "C:\Users\Admin\Desktop\Data Science"

/* Create log file */
capture log close
log using "1.int.log", replace

/* Import excel file */
import excel using "IT.NET.SECR.P6.xlsx", firstrow clear

drop A

/* Save cleaned data */
save 1.int.clean.dta, replace

/* Create scatter plot and best fit line */
tw (scatter intserver year) (lfit intserver year)

/* Drop developed economies */
drop if country == "Estonia" | country == "Latvia"| country == "Lithuania"| country == "United Kingdom"| country == "Malta"| country == "Singapore" | country == "Ireland" |  country == "Spain"| country == "Luxembourg"| country == "Italy"| country == "Netherlands"

/* Create scatter plot and best fit line only with developing economies */
tw (scatter intserver year) (lfit intserver year)

/* Save cleaned data */
save 2.int.clean.dta, replace

/* Export final dataset */

log close