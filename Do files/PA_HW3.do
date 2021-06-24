***** Problem 1 *****
use minwage,clear

*** 1.a ***
gen totalemploy= empft + (emppt/2) + nmgrs
gen statetime = state*time
reg totalemploy state time statetime

*** 1.b ***
gen mths=02 if time==0
replace mths=11 if time==1
collapse (mean) totalemploy mths, by(time state)
sort state mths

set obs 6
replace totalemploy = totalemploy[3] if _n==5
replace totalemploy = totalemploy[3] + (totalemploy[2] - totalemploy[1]) if _n==6
replace mths = 02 if _n==5
replace mths = 11 if _n==6

twoway (line totalemploy mths if state) (line totalemploy mths if !state) (line totalemploy mths if missing(state)), legend(label(1 "NJ") label(2 "PA") label(3 "Counterfactual")) ytitle("Total Employment") xtitle("Time")


*** 1.c ***
use minwage,clear
gen statetime = state*time

gen fmeal= psoda+ pfry+ pentree
reg fmeal state time statetime

*** 1.d ***
gen mths=02 if time==0
replace mths=11 if time==1
collapse (mean) fmeal mths, by(time state)
sort state mths

set obs 6
replace fmeal = fmeal[3] if _n==5
replace fmeal = fmeal[3] + (fmeal[2] - fmeal[1]) if _n==6
replace mths = 2 if _n==5
replace mths = 11 if _n==6

twoway (line fmeal mths if state) (line fmeal mths if !state) (line fmeal mths if missing(state)), legend(label(1 "NJ") label(2 "PA") label(3 "Counterfactual")) ytitle("Full Meal Price") xtitle("Time-Months") 

***** Problem 2 *****
use airfare,clear

*** create log fare ***
gen logfare=log(fare)

*** Working with dummy variables ***
gen y98=1 if year==1998
replace y98=0 if year!=1998
gen y99=1 if year==1999
replace y99=0 if year!=1999
gen y00=1 if year==2000
replace y00=0 if year!=2000

*** 2.a - Pooled OLS ***
reg logfare concen y98 y99 y00

*** 2.b - Within Estimator ***
xtset id year
xtreg logfare concen i.year,fe

*** 2.c - First Difference ***
gen difflogfare = logfare-l3.logfare
gen diffconcen = concen - l3.concen
reg difflogfare diffconcen


*** Problem 3 ****
use voting,clear

*** Create dummy "win" ***
gen win=1 if voteA>50.00
replace win=0 if voteA<=50.00

*** 3.a ***
reg win expendA prtystrA democA

*** 3.c ***
reg win expendA expendB prtystrA democA

*** 3.d ***
probit win expendA expendB prtystrA democA
predict latent,xb
predict winhat,pr

*** 3.e ***
** Calculate Marginal effect **
sum expendA expendB prtystrA democA
di -1.686781+.006178*310.611-.0080762*305.0885+.0294829*49.75723+.843552*.5549133
di normal(-.29669633)
** Calculate the probability for additional expendA of $50000 **
di -1.686781+.006178*360.611-.0080762*305.0885+.0294829*49.75723+.843552*.5549133
di normal(.01220367)
di .50486844-.38334918
**.12151926 - additiona 12.15% points to the original percentage**

