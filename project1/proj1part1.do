use master, replace
generate year = yofd(dofq(q))
collapse (mean) u (mean) Y, by (year)
tsset year, yearly
generate ra = (Y/(L.Y)-1)*100
gen d = u-L.u
keep if year > 1948
graph twoway (scatter d ra) (lfit d ra), xline(0, lcolor(black)) yline(0, lcolor(black)) legend(off) xtitle("Real GDP Growth(%)") ytitle("Change in Unemployment Rate(%p)") title("Difference Version of Okun’s Law, Annual") note("Sources: BEA and BLS" "Note: 1949 through 2006")
graph export project1.pdf, replace
save proj1.dta, replace
