import excel "\\appsstorage.bc.edu\chenaoz\potential.xlsx", sheet("Sheet1") firstrow clear
save potential.dta, replace
generate q = quarterly(time,"YQ")
tsset q, quarterly
merge 1:1 q using master
drop time marker
sort q
keep if _merge == 3
generate ug = u - Lu
generate GDPg = (Y/pY - 1) * 100
reg GDPg ug
save proj2reg, replace
rolling (-_b[_cons]/_b[ug]) _b, window(52): reg GDPg ug
tsset end, quarterly
rename _eq2_stat_1 d
label var d "Coefficient of the Output Gap"
rename _b_cons c
label var c "Constant Term"
tsline d || tsline c, yaxis(2) title("Estimated Constant Term and Coefficient of the Output	Gap") note("Sources: BEA, BLS and CBO" "Note: This sample period is from 1949q1 through 2006q4")
graph export project2.pdf, replace
