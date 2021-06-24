use cars89,clear

**** 1. Sample mean and Std dev of variables****
sum price weight horsepower seating displacement

**** 2. Hypothesis test Population mean price = 19000 ****
sum price
*** Calculate t-stat ***
di (r(mean)-19000)/(r(sd)/sqrt(r(N)))
*** Calculate p-value ***
di 2*ttail(106,2.3877)
*** Verified with test ***
ttest price==19000
*** t-stat = -2.3877, p-value = 0.0187, Reject in 90% and 95%, Fail to reject 
*** in 99%.

**** 3. Generate new variable imported 1=imported; 0=not imported****
gen imported=1 if make=="Audi"
replace imported=0 if make=="Acura"
replace imported=0 if make=="BMW"
replace imported=0 if make=="Buick"
replace imported=0 if make=="Volkswagen"
replace imported=0 if make=="Toyota"
replace imported=0 if make=="Subaru"
replace imported=0 if make=="Nissan"
replace imported=0 if make=="Mercedes"
replace imported=0 if make=="Lincoln"
replace imported=0 if make=="Hyundai"
replace imported=0 if make=="Honda"
replace imported=0 if make=="Ford"
replace imported=0 if make=="Dodge"
replace imported=0 if make=="Chevrolet"
replace imported=0 if make=="Cadillac"
replace imported=1 if make=="Volvo"
replace imported=1 if make=="Sterling"
replace imported=1 if make=="Saab"
replace imported=1 if make=="Pontiac"
replace imported=1 if make=="Peugot"
replace imported=1 if make=="Oldsmobile"
replace imported=1 if make=="Mitsubishi"
replace imported=1 if make=="Merkur"
replace imported=1 if make=="Mercury"
replace imported=1 if make=="Mazda"
replace imported=1 if make=="Isuzu"
replace imported=1 if make=="Geo"
replace imported=1 if make=="Eagle"
replace imported=1 if make=="Daihatsu"
replace imported=1 if make=="Chrysler"
****Calculate ATE ****
sum price if imported==1
sum price if imported==0
di 15247.17-17588.31
*** ATE = -2341.14 ***

**** 4. Hypothesis test, ****
*** Calculate t-stat from summary statistic obtained in Q.3 ****
di ((15247.17-17588.31)-0)/sqrt((5491.535)^2/36+(10978.25)^2/71)
*** t-stat = -1.47 < 1.65,1.96 or 2.58- Fail to reject in 90%, 95% or 99%
*** Verify **
ttest price, by(imported) unequal

**** 5. Estimate price on weight horsepower ****
reg price weight horsepower

**** 6. Hypothesis test ****
*** Calculate t-stat ***
di (111.4845-70)/22.50706
*** t-stat = 1.84 > 1.65 , but < 1.96 and 2.58 - Reject in 90%, but fail to 
*** reject in 95% and 99%
*** Calculate p-value ***
di 2*ttail(107,1.8431772)
*** p-value = .0681 < 0.10, but > 0.05 and 0.01,Reject in 90%, but fail to 
*** reject in 95% and 99%

**** 7. Estimate
reg price weight horsepower displacement seating imported

**** 8. Price prediction ***
di -13533.69+(3131*14.75433)+(178*94.77561)+(180.8*(-66.10356))+(5*(-2456.172))+(0*(-880.0065))
**** Price = $25,299.792 ***

*** 9. 
*** Endogenity

