

use hh.dta, clear

* Check the data
desc
sum 
ta hhh_educ

* Exercise 4.1 *
*******************
* 2. Base scatter plot
twoway (scatter logpccd land)


* 3. Restrict land (0,200)
twoway (scatter logpccd land) if land>0 & land<=200

* 4. Formatting
twoway (scatter logpccd land, mlcolor(purple) mfcolor(purple%10) ///
		mlwidth(*0.5) msize(*0.7)) ///
		if land>0 & land<=200, ///
		ylabel(0(2)10)
		
* 5. 6. 7. 8. Add polynomial fit		
twoway (scatter logpccd land, mlcolor(purple) mfcolor(purple%10) ///
		mlwidth(*0.5) msize(*0.7)) ///
	   (lpolyci logpccd land, bwidth(7) clcolor(green) fcolor(green%10) ///
	   alwidth(0)) ///
		if land>0 & land<=200, ///
		ylabel(0(2)10) ///
		legend(order(1 "Observed" 2 "95% CI" 3 "Polynomial fit") rows(1) size(*0.8)) ///
		xtitle("Area of land owned") ytitle("Log per capita consumption") ///
		title("Consumption and land ownership") ///
		note("Source: Tajikistan LSMS 2007")
