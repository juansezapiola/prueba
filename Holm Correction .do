**===========================================================================**
**===========================================================================**
* 3) a) Holm Correction
*==============================================================================*
**===========================================================================**

eststo clear

**===========================================================================**
*PANEL A
**===========================================================================**

********************************** BAYLEY *************************************
*si yo hago cambios aca que pasa
* Define number of hypothesis
scalar hyp = 4
* Define level of significance
scalar signif = 0.05

* Store p-values in matrix
scalar i = 1
mat p_values = J(4,1,.)
foreach y in $bayley{
	local append append 
if "`y'"=="b_tot_cog" local append replace 
	cap drop V*
	reg `y'1_st treat `y'0_st $covs_eva , cluster(cod_dane)
	eststo: test treat = 0
	mat p_values[i,1]=r(p)
scalar i = i + 1
}

preserve
clear 
svmat p_values
gen var = _n
sort p_values1

gen alpha_corr = signif/(hyp+1-_n)

gen significant = (p_values1<alpha_corr)

replace significant = 0 if significant[_n-1]==0
save "$output/holmpvals_panelA.dta", replace
sort var
restore

*\ Según la corrección de Holm las variables que son significativas al 5% son Bayley: Cognitive y Bayley: Receptive language.

********************************** MACARTHUR *************************************

* Define number of hypothesis
scalar hyp = 2
* Define level of significance
scalar signif = 0.05

* Store p-values in matrix
scalar i = 1
mat p_values = J(2,1,.)
foreach y in $macarthur{
	cap drop V*
	reg `y'1_st treat mac_words0_st $covs_ent , cluster(cod_dane)
	eststo: test treat = 0
	mat p_values[i,1]=r(p)
scalar i = i + 1
}

preserve
clear 
svmat p_values
gen var = _n
sort p_values1

gen alpha_corr = signif/(hyp+1-_n)

gen significant = (p_values1<alpha_corr)

replace significant = 0 if significant[_n-1]==0
save "$output/holmpvals_panelAa.dta", replace
sort var
restore

*\ Según la corrección de Holm ninguna de las variables es significativa al 5%
**===========================================================================**
*PANEL B
**===========================================================================**

********************************** ICQ ****************************************

* Define number of hypothesis
scalar hyp = 3
* Define level of significance
scalar signif = 0.05

* Store p-values in matrix
scalar i = 1
mat p_values = J(3,1,.)
foreach y in $bates{
	cap drop V*
	reg `y'1_st treat `y'0_st $covs_ent, cl(cod_dane)
	eststo: test treat = 0
	mat p_values[i,1]=r(p)
scalar i = i + 1
}

preserve
clear 
svmat p_values
gen var = _n
sort p_values1

gen alpha_corr = signif/(hyp+1-_n)

gen significant = (p_values1<alpha_corr)

replace significant = 0 if significant[_n-1]==0
save "$output/holmpvals_panelB.dta", replace
sort var
restore

*\ Según la corrección de Holm ninguna de las variables es significativa al 5%
********************************** ECBQ ****************************************

* Define number of hypothesis
scalar hyp = 2
* Define level of significance
scalar signif = 0.05

* Store p-values in matrix
scalar i = 1
mat p_values = J(2,1,.)
foreach y in $roth{
	cap drop V*
	reg `y'1_st treat bates_difficult0_st $covs_ent , cluster(cod_dane)
	eststo: test treat = 0
	mat p_values[i,1]=r(p)
scalar i = i + 1
}

preserve
clear 
svmat p_values
gen var = _n
sort p_values1

gen alpha_corr = signif/(hyp+1-_n)

gen significant = (p_values1<alpha_corr)

replace significant = 0 if significant[_n-1]==0
save "$output/holmpvals_panelBb.dta", replace
sort var
restore

*\ Según la corrección de Holm ninguna de las variables es significativa al 5%
**===========================================================================**
*PANEL C
**===========================================================================**

*************************** FCI: Material Investment ****************************

* Define number of hypothesis
scalar hyp = 5
* Define level of significance
scalar signif = 0.05

* Store p-values in matrix
scalar i = 1
mat p_values = J(5,1,.)
foreach y in $fcimat{
	cap drop V*
	reg `y'1_st treat fci_play_mat_type0_st $covs_ent , cluster(cod_dane)
	eststo: test treat = 0
	mat p_values[i,1]=r(p)
scalar i = i + 1
}

preserve
clear 
svmat p_values
gen var = _n
sort p_values1

gen alpha_corr = signif/(hyp+1-_n)

gen significant = (p_values1<alpha_corr)

replace significant = 0 if significant[_n-1]==0
save "$output/holmpvals_panelC.dta", replace
sort var
restore

*\ Según la corrección de Holm las variables que son significativas al 5% son FCI: Number of types of play materials y FCI: Number of toys to learn shapes.

**===========================================================================**
**PANEL D
**===========================================================================**

****************************** FCI: Time Investment ********************************


* Define number of hypothesis
scalar hyp = 5
* Define level of significance
scalar signif = 0.05

* Store p-values in matrix
scalar i = 1
mat p_values = J(5,1,.)
foreach y in $fcitime{
	cap drop V*
	reg `y'1_st treat fci_play_act0_st $covs_ent , cluster(cod_dane)
	eststo: test treat = 0
	mat p_values[i,1]=r(p)
scalar i = i + 1
}

preserve
clear 
svmat p_values
gen var = _n
sort p_values1

gen alpha_corr = signif/(hyp+1-_n)

gen significant = (p_values1<alpha_corr)

replace significant = 0 if significant[_n-1]==0
save "$output/holmpvals_panelD.dta", replace
sort var
restore

*\ Según la corrección de Holm todas las variables del PANEL D son significativas al 5%.  


eststo clear

* Finally, run regressions including p-value and corrected p-value for PANEL A
mat q_values_tHA = [0.0125, 0.0167, 0.025, 0.05]

* Finally, run regressions including p-value and corrected p-value for PANEL Aa
mat q_values_tHAa = [0.025, 0.05]

* Finally, run regressions including p-value and corrected p-value for PANEL B
mat q_values_tHB = [0.0167, 0.025, 0.05]

* Finally, run regressions including p-value and corrected p-value for PANEL Bb
mat q_values_tHBb = [0.05, 0.025]

* Finally, run regressions including p-value and corrected p-value for PANEL C
mat q_values_tHC = [0.0125, 0.0167, 0.025, 0.01, 0.05]

* Finally, run regressions including p-value and corrected p-value for PANEL D
mat q_values_tHD = [0.0125, 0.05, 0.01, 0.0167, 0.025]


* Finally, run regressions including p-value and corrected p-value for PANEL A
scalar i = 1
foreach y in $bayley{
	local append append 
    if "`y'"=="b_tot_cog" local append replace 
	cap drop V*
	reg `y'1_st treat `y'0_st $covs_eva , cluster(cod_dane)
	eststo: test treat = 0
	estadd scalar p_value = r(p)
	estadd scalar p_value_corr = q_values_tHA[1,i]
scalar i = i+1
}

* Finally, run regressions including p-value and corrected p-value for PANEL Aa
scalar i = 1
foreach y in $macarthur{
	cap drop V*
	reg `y'1_st treat mac_words0_st $covs_ent , cluster(cod_dane)
	eststo: test treat = 0
	estadd scalar p_value = r(p)
	estadd scalar p_value_corr = q_values_tHAa[1,i]
scalar i = i+1
}

* Finally, run regressions including p-value and corrected p-value for PANEL B
scalar i = 1
foreach y in $bates{
	cap drop V*
	reg `y'1_st treat `y'0_st $covs_ent, cl(cod_dane)
	eststo: test treat = 0
	estadd scalar p_value = r(p)
	estadd scalar p_value_corr = q_values_tHB[1,i]
scalar i = i+1
}

* Finally, run regressions including p-value and corrected p-value for PANEL Bb
scalar i = 1
foreach y in $roth{
	cap drop V*
	reg `y'1_st treat bates_difficult0_st $covs_ent , cluster(cod_dane)
	eststo: test treat = 0
	estadd scalar p_value = r(p)
	estadd scalar p_value_corr = q_values_tHBb[1,i]
scalar i = i+1
}


* Finally, run regressions including p-value and corrected p-value for PANEL C
scalar i = 1
foreach y in $fcimat{
	cap drop V*
	reg `y'1_st treat fci_play_mat_type0_st $covs_ent , cluster(cod_dane)
	eststo: test treat = 0
	estadd scalar p_value = r(p)
	estadd scalar p_value_corr = q_values_tHC[1,i]
scalar i = i+1
}


* Finally, run regressions including p-value and corrected p-value for PANEL D
scalar i = 1
foreach y in $fcitime{
	cap drop V*
	reg `y'1_st treat fci_play_act0_st $covs_ent , cluster(cod_dane)
	eststo: test treat = 0
	estadd scalar p_value = r(p)
	estadd scalar p_value_corr = q_values_tHD[1,i]
scalar i = i+1
}





esttab using "$output/Table_3Holm.rtf", p se replace label noobs ///
keep(treat, relax) ///
cells(b(fmt(2) star) se(par fmt(2))) ///
stats(p_value p_value_corr blank N r2, fmt(2 2 0 2) labels("P-value" "Corrected p-value" " "  "Number of Observations" "R-Squared") layout([@] [@] @ @ @)) 



