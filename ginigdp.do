clear all
set more off

/* Set working directory */
cd "C:\Users\Admin\Desktop\Data Science"

/* Create log file */
capture log close
log using "1.ginigdp.log", replace

/* Import excel file */
import excel using "NY.GDP.PCAP.PP.CD.xlsx", firstrow clear

drop A

/* Save cleaned data */
save 1.ginigdp.clean.dta, replace

///////////////// merging the variables /////////////////

/* Import excel file */
import excel using "SI.POV.GINI.xlsx", firstrow clear

drop A

/* Merging Gini and GDPPC by country and year */
merge 1:1 country year using 1.ginigdp.clean.dta

/* Cleaning dataset, drop missing values */
drop _merge
drop if gini==.
drop if gdppc==.

/* Save cleaned data */
save 1.ginigdp.clean.dta, replace

/* Create scatter plot and best fit line */
tw (scatter gdppc gini) (lfit gdppc gini)

/* Export dataset */

/* In Excel, 2 recent observations is used as the final dataset */


log close