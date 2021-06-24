**sysdir set PLUS "I:\STATS Pkges"

***** Problem 1 *****
use HousePrices, clear

**** Working on dummy variables, Change Yes/No variables to 1/0****

gen drivewy=1 if driveway=="yes"
replace drivewy=0 if driveway=="no"

gen recreatroom=1 if recroom=="yes"
replace recreatroom=0 if recroom=="no"

gen combase=1 if fullbase=="yes"
replace combase=0 if fullbase=="no"

gen whgas=1 if gashw=="yes"
replace whgas=0 if gashw=="no"

gen cenair=1 if airco=="yes"
replace cenair=0 if airco=="no"

gen area=1 if prefarea=="yes"
replace area=0 if prefarea=="no"

*** Q.1 ***
reg price lotsize
predict pricehat,xb
sort lotsize
twoway (scatter price lotsize) (line pricehat lotsize)

*** Q.2 ***
gen lotsize2 =lotsize^2
reg price lotsize lotsize2
predict phat, xb
sort lotsize
twoway (scatter price lotsize) (line phat lotsize)

*** Q.3 ***
reg price lotsize bedrooms bathrms

*** Q.4 ***
reg price lotsize bedrooms bathrms stories drivewy recreatroom combase garagepl whgas cenair area

*** Q.5 ***
*** Some Possible omitted variables :- Tax rate, Pools.

*** Q.6 ***
*eststo:reg price lotsize
*eststo:reg price lotsize lotsize2
*eststo:reg price lotsize bedrooms bathrms
*eststo:reg price lotsize bedrooms bathrms stories drivewy recreatroom combase garagepl whgas cenair area
*esttab,se nostar r2 noobs

***** Problem 2 *******
use CARD,clear

*** Q.1- OLS***
reg lwage educ exper expersq black smsa south smsa66 reg662 reg663 reg664 reg665 reg666 reg667 reg668 reg669

*** Q.2 ***
*Valid instrument requirements: Relevance and Exogeneity

*** Q.3 - 1st stage***
reg educ nearc4 exper expersq black smsa south smsa66 reg662 reg663 reg664 reg665 reg666 reg667 reg668 reg669
predict educhat,xb

*** Q.4 -2nd stage, Manual***
reg lwage educhat exper expersq black smsa south smsa66 reg662 reg663 reg664 reg665 reg666 reg667 reg668 reg669

*** Q.5 -2sls***
ivregress 2sls lwage ( educ = nearc4 ) exper expersq black smsa south smsa66 reg662 reg663 reg664 reg665 reg666 reg667 reg668 reg669
