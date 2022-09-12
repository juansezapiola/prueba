


cd "/Users/juansegundozapiola/Documents/UdeSA/4to Año/Economía Aplicada/PS1"

global main "/Users/juansegundozapiola/Documents/UdeSA/4to Año/Economía Aplicada/PS1"
global input "$main/input"
global output "$main/output"
**cambio hecho
use "$input/data_russia.dta", clear

browse

sort id

*veo que variables son string*
ds, has(type string)

*string a numeric*
foreach var of varlist sex satecc   cmedin   operat   hipsiz   work0    marsta2 econrk   highsc   hprblm   hattac   hhpres   work1    marsta3 powrnk   belief   hosl3m   smokes   totexpr  work2    marsta4 resprk   monage   wtchng   alclmo   tincm_r  ortho satlif   obese    evalhl   waistc   geo      marsta1 {
destring `var', replace 
} 


foreach var of varlist wtchng work2 work1 work0 waistc totexpr tincm_r smokes site sex satlif satecc resprk powrnk ortho operat obese monage marsta4 marsta3 marsta2 marsta1 inwgt id htself hprblm hosl3m hipsiz highsc hhpres height hattac geo evalhl econrk cmedin belief alclmo {
replace `var' = "." if `var'==".b"
}

mdesc

ds, has(type numeric)
foreach var of varlist id       highsc   hprblm   height   work1    marsta2 site     belief   hosl3m   waistc   work2    marsta3 inwgt    monage   htself   hhpres   ortho    marsta4 satecc   cmedin   alclmo   work0    marsta1 {
replace `var' = . if `var'==.f
}


replace  powrnk = "." if powrnk == ".b"



foreach var of varlist sex econrk powrnk resprk satlif {
replace `var'= "5" if `var' == "five"
}
foreach var of varlist wtchng evalhl operat hattac geo {
replace `var'= "1" if `var' == "one"
}

replace smokes= "1" if smokes == "Smokes"

replace sex= "1" if sex == "male"
replace sex= "0" if sex == "female"

replace obese= "0" if obese == "1"
replace obese= "1" if obese == "This person is obese"

*remueve hip circumference*
replace hipsiz= subinstr(hipsiz, "hip circumference", "", .)

*string a numeric + cambiar coma por punto*
destring hipsiz, replace dpcomma

*remueve total expenditures*
replace totexp= subinstr(totexp, "Total expenditures", "", .)


destring totexp, replace dpcomma
sum totexpr


destring tincm_r, replace dpcomma

save "$input/data_russia_clear", replace




