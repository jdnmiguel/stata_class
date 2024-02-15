

*** Stata: Session 3 ***
cd "C:\Users\jdnmiguel\Dropbox\Teaching\stata\s3"


** Exercise 3.1 **

* 2. Import data
import excel hh.xls, clear first


* 3. Overview of data
count

describe
describe pccd

codebook pccd
codebook loc

* 4. Count of missing values
count if pccd==.

* 5. Summary stats
sum pccd hhsize nchild nmigrant emplrat hhh_female land urban

* 6. Group-level statistcs
bysort urban: sum pccd hhsize nchild nmigrant emplrat hhh_female

tabstat pccd hhsize nchild nmigrant emplrat hhh_female, by(urban) statistics(mean sd min max count)
tabstat pccd hhsize nchild nmigrant emplrat hhh_female, by(urban) statistics(mean sd min max count) column(statistics)

* 7. One-way tabulation 
tab hhh_educ

* 8. Two-way tabulations
tab hhh_educ hhh_female

* 9. Detailed summary statistics
sum pccd, d
return list

* 10. Standardized variable
gen pccd_st = (pccd-r(mean))/r(sd)
sum pccd_st


* 11. Save data
save hh.dta, replace


*********************************


** Exercise 3.2 **
* 1. Open data
use hh.dta, clear

** 2. Label variables
label var pccd "Per capita consumption"
label var hhsize "HH size" 
label var nmigrant "Number of migrants"
label var emplrat "Employment ratio" 

** 3. Export sum-stats using outreg2
ssc install outreg2
outreg2 using sumtable.xls, sum(detail) keep(pccd hhsize nmigrant emplrat) ///
				   eqkeep(mean p50 min max N) ///
				  label replace excel 

** 4. Collapsing data

collapse (mean) pccd_mean = pccd ///
				hhsize_mean = hhsize ///
				nmigrant_mean = nmigrant ///
				emplrat_mean = emplrat ///
		  (sd)  pccd_sd = pccd ///
				hhsize_sd = hhsize ///
				nmigrant_sd = nmigrant ///
				emplrat_sd = emplrat , by(urban)

export excel collapse_sumstat.xls, replace first(var)


* 
use hh.dta, clear
collapse pccd hhsize nmigrant emplrat








































