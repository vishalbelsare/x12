**********************************************************************
/*This code is an example of code that will take stata variables and seasonally*/
/*adjust them using x.py.  It uses fred to import some series, but that's really*/
/*not important.  */
*
/*Jeffrey Borowitz*/
/*jborowitz@gmail.com*/
/*1/26/2011*/
**********************************************************************
clear
/*freduse LNU03000000 UNRATENSA*/
/*save fredout.dta, replace*/
/*This code imports two NSA series from fred, with the freduse module*/
use fredout
keep daten LNU03000000 UNRATENSA
rename LNU03000000 num 
rename UNRATENSA urate 
rename daten date
/*clean data*/

format date %tdMon-CCYY
/*Important! format date like Jan-1998.  If you don't do this, you would have to*/
/*modify x.py to accept other date formats.  This isn't hard, but just be sure*/
/*you know what you're doing. Python's date codes can be found here:*/
/*http://docs.python.org/library/datetime.html*/

order date num urate
/*This is not necessary, but makes your .csv look how you might imagine*/

outsheet using unemp.csv, comma replace
/*Export to .csv*/

!/home/jborowitz/python/x.py unemp.csv unemp-sa.csv
* Use x.py as: x.py infile outfile

insheet using unemp-sa.csv, clear
/*Load in seasonally adjusted data.*/

gen date2 = date(date,"YMD")
format date2 %tdMon-CCYY
drop date
rename date2 date
* Turn the date string from the .csv into a stata date

list
