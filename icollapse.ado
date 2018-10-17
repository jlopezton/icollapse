
/********************************************************************************
icollapse
*                                                                              	
Usage is exactly as in collapse, but the "by" variables can be divided in
by() and byinclusive(). Variables in by() will devide the collapse by exclusive
groups, while the byi() will divide by exclusive groups but also will give provide
the collapse for all the population.
For example, if the option provided is byi(area sex), and the variables have two values (rural/urban
and male/female), the final collapse will be divided by 9 groups, defined by the following duples:
1)male-rural, 2)male-urban, 3)female-rural, 4)female-urban, 5)both sexes-urban, 6)both sexes-rural, 
7)male-both areas, 8)female-both areas, 9)both sexes-both areas.

However, if you specify by(rural) byi(sex) you'd get 1)female-urban, 2) female-rural
3)male-rural 4)male-rural, 5)both sexes-urban, 6)both sexes-rural. That is, there's no collapse by both areas.
*                                                                              	
* Authors:		
     ___ _____ _____ 
 __ |  |  _  |   __|
|  |  |     |__   |
|_____|__|__|_____|															   	
*	Jorge Soler Lopez
* 	4:56 PM Tuesday, May 09, 2017
*	World Bank																	
*******************************************************************************/
qui cap program drop icollapse

program define icollapse, rclass
version 13.0

syntax [anything(name=clist id=clist equalok)] 	///
[if] [in] [aw fw iw pw] 						///
[, BY(varlist) 									///regular by
BYInclusive(varlist)							 ///inclusive by
CW												///
FAST											///
CLABEL									 		///
]


qui{
	*Collapses
	tempfile currentDB
	save `currentDB', replace empty
	tempfile fullcollapse
	qui cap ssc install tuples
	*All
	if `"`byinclusive'"' != ""  local byiw = "by(`by' `byinclusive')"  
	if `"`by'"' != ""  local byw = "by(`by')" 
	collapse `clist' `if' `in' [`weight' `exp'], `byw' `cw' `fast' `clabel' 
	save `fullcollapse', replace empty
	*by tuple
	use `currentDB', clear
	tuples `byinclusive'
	qui forval i = 1/`ntuples' {
		preserve
		local byiw = "by(`by' `tuple`i'')"
		collapse `clist' `if' `in' [`weight' `exp'], `byiw' `cw' `fast' `clabel' 
		gen aux_collapse = "`tuple`i''"
		append using `fullcollapse', force
		*noi list
		save `fullcollapse', replace 
		restore
	}
	
	use `fullcollapse', clear
	
}
end


