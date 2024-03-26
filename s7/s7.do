clear all 

* TD Stata - Session 7
****************************************
cd "C:\Users\jdnmiguel\Dropbox\teaching\stata\s7"

* Exercise 7
**************
* 1. Import data
import excel wdi_extract.xlsx, clear first

* 2. Reshape to long format so that years appear in rows
egen cid = group(ccode) // numeric ID variable for each country
egen cid_var = group(ccode variable)
reshape long y, i(cid_var) j(year)

* 3. Reshape to wide by variable (because we have variables/indicators in rows)
egen vid = group(variable) //ID for each variable => check what values are given for each variable
* 1= CO2 emission per capita
* 2= Fertility rate
* 3= GDP per capita
* 4= GDP per capita growth
drop cid_var variable
reshape wide y, i(cid year) j(vid) //this should give new varaibles called y1 y2 y3 y4
rename y1 co2
rename y2 fert
rename y3 gdppc
rename y4 gdppcgr

order cid year ccode country, first

* 4. Set panel data structure
xtset cid year // cid doesnt have label though
encode country, gen(cid2)
xtset cid2 year // now country IDs have labels 

* 5. Trend of CO2 in selected EU countries
xtline co2 if inlist(country, "France", "Germany", "United Kingdom", "Italy", "Netherlands", "Spain")==1
xtline co2 if inlist(country, "France", "Germany", "United Kingdom", "Italy", "Netherlands", "Spain")==1, overlay


* 6. Fixed effects model
xtreg gdppc co2 fert, fe //without year FE
xtreg gdppc co2 fert i.year, fe //with year FE
xtreg gdppc co2 fert i.year, fe cluster(cid) //with year FE and cluster SE

reghdfe gdppc co2 fert, abs(cid2) //without year FE
reghdfe gdppc co2 fert, abs(cid2 year) //with year FE
reghdfe gdppc co2 fert, abs(cid2 year) cluster(cid) //with year FE

















