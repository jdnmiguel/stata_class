

*** Data Importing - Ex. 1.1 ****
cd "C:\Users\jdnmiguel\Dropbox\Teaching\stata\s1"
pwd

import delimited hh.csv, clear varnames(1)
save hh.dta, replace

import excel commdist.xls, clear first
save commdist.dta, replace



*** Data cleaning - Ex. 1.2 ****
use hh.dta, clear

rename v001 pccd
rename v002 hhsize
rename v003 nchild
rename v004 nelder
rename v005 nmigrant
rename v006 nempl
rename v007a hhh_female
rename v007b hhh_age
rename v007c hhh_educ
rename v008 land


label var pccd "Per capita daily consumption" 


replace hhh_age = . if hhh_age>90 & hhh_age!=.

drop if nchild>6 & nchild!=.

gen urban = (loc=="urban") if !missing(loc)
drop urban
gen urban = 0 if loc=="rural"
replace urban = 1 if loc=="urban"

gen logpccd = log(pccd)
*gen logpccd = ln(pccd) 
gen log10pccd = log10(pccd)

gen emplrat = nempl/hhsize


save hh_clean.dta, replace


