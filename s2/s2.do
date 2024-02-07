
********************************
****** Session 2 - Stata *******
********************************

cd "C:\Users\jdnmiguel\Dropbox\Teaching\stata\s2"

** Exercise 2.1 **
********************
import delimited data2.csv, clear varnames(1)
export excel data2.xls, first(var) replace

import delimited data1.csv, clear varnames(1)
export excel data1.xls, first(var) replace

import delimited data3.csv, clear varnames(1)
export excel data3.xls, first(var) replace

import delimited somedirtydata.csv, clear varnames(1)
export excel somedirtydata.xls, first(var) replace

import delimited cpi_zipcode.csv, clear varnames(1)
export excel cpi_zipcode.xls, first(var) replace

import delimited data2016.csv, clear varnames(1)
export excel data2016.xls, first(var) replace

* Check for duplicates
duplicates drop
duplicates report

* Check for ID variables
isid id year
duplicates report id year

* Declare data structure
xtset id year


save panel.dta, replace

** Exercise 2.2 **
import delimited somedirtydata.csv, clear varnames(1)
duplicates report
isid hhid
duplicates report hhid

* Convert hhcons and zipcode to numeric variables
destring zipcode, replace
destring zipcode, replace ignore(" F-")
destring hhcons, replace ignore(",NA")

* Value labels
label define poorlab 0 "Non-poor" 1 "Poor"
label values poor poorlab

* HH size variable
egen hhsize = rowtotal(nadult nchild)

* Poverty rate by zipcode
bysort zipcode: egen poor_zipcode = mean(poor)

* HH consum by zipcode (max)
bysort zipcode: egen hhcons_zipcodemax = max(hhcons)

save somecleandata.dta, replace


** Exercise 2.3 ***
* Reshaping
import delimited cpi_zipcode.csv, clear varnames(1)
reshape long cpi@, i(zipcode) j(year)
reshape wide cpi, i(zipcode) j(year)

save cpi_zipcode.dta, replace


* Merge
use cpi_zipcode.dta, clear
merge 1:m zipcode using somecleandata.dta













