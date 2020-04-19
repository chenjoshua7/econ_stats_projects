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
keep if q < 224
graph twoway (scatter ug GDPg) (lfit ug GDPg), xline(0, lcolor(black)) yline(0, lcolor(black)) legend(off) xtitle("Output Gap(%)") ytitle("Unemployment Gap(%p)") title("Gap Version of Okun’s Law, Quarterly") note("Sources: BEA, BLS and CBO" "Note: This sample perdiod is from 1949q1 through 2006q4")
graph export project2.pdf, replace
