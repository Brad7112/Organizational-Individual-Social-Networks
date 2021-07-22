set more off

*target folder
cd "C:\Users\Megumi\Dropbox\My PC (LAPTOP-0BSK3OQH)\Desktop\ICPSR\append_JGSS_20102012\social network"

use 34623-0001-Data.dta, clear
generate year = 2010
order year
save JGSS2010.dta, replace
clear
use 36577-0001-Data.dta, clear
generate year = 2012
order year
save JGSS2012.dta, replace
append using JGSS2010.dta
save JGSS20102012append.dta, replace

use JGSS20102012append.dta, clear

*change command names from upper to lower letters
rename *, lower

*delete the observations who answered "Not applicable" (==8) in Questionnaire A of 2010 and 2012
drop if year == 2010 & xvlnone == 8
drop if year == 2012 & xvlnone == 8

keep year sexa ageb sizehmt opnbmtcn fqnbas szincomx ownhouse xxlstsch ///
 xjob1wk tpjob domarry szffonly szffttl incself incsp incpar incfam incpen incueb ///
 incsave incsoc incirr incrent incother incnokn incmain xvlimprt xvlntenv xvlsafe ///
 xvlspts xvleld xvlcc xvlothr xvlnone xvldisab sizehmt ///
 fqnbas xliveyr fq7frsee mempltgp memind memvlntr memcivil memrl memsport memhobby memcoop ///
 xxlstsch ccnumttl szincoma ownhouse opnbmtcn opnbass op4trust 


*change "No Answer" to missing values
replace szffonly = . if szffonly == 999
replace szffttl = . if szffttl == 999
replace incself = . if incself == 9
replace incsp = . if incsp == 9
replace incpar = . if incpar == 9
replace incfam = . if incfam == 9
replace incpen = . if incpen == 9
replace incueb = . if incueb == 9
replace incsave = . if incsave == 9
replace incsoc = . if incsoc == 9
replace incirr = . if incirr == 9
replace incrent = . if incrent == 9
replace incother = . if incother == 9
replace incnokn = . if incnokn == 9
replace incmain = . if incmain == 99
replace sizehmt = . if sizehmt == 9 
replace szincomx = . if szincomx == 99
replace xxlstsch = . if xxlstsch == 99
replace ownhouse = . if ownhouse == 9
replace opnbmtcn = . if opnbmtcn == 9
replace xvlimprt = . if xvlimprt == 9
replace xvlntenv = . if xvlntenv == 9
replace xvlsafe = . if xvlsafe == 9
replace xvlspts = . if xvlspts == 9
replace xvleld = . if xvleld == 9
replace xvlcc = . if xvlcc == 9
replace xvlothr = . if xvlothr == 9
replace xvlnone = . if xvlnone == 9
replace xvldisab = . if xvldisab == 9
replace fqnbas = . if fqnbas == 9 
replace fq7frsee = . if fq7frsee == 9 
replace xliveyr = . if xliveyr == 99 
replace mempltgp = . if mempltgp == 9
replace memind = . if memind == 9
replace memvlntr = . if memvlntr == 9
replace memcivil = . if memcivil == 9
replace memrl = . if memrl == 9
replace memsport = . if memsport == 9
replace memhobby = . if memhobby == 9
replace memcoop = . if memcoop == 9
replace mempltgp = 0 if mempltgp == 2
replace memind = 0 if memind == 2
replace memvlntr = 0 if memvlntr == 2
replace memcivil = 0 if memcivil == 2
replace memrl = 0 if memrl == 2
replace memsport = 0 if memsport == 2
replace memhobby = 0 if memhobby == 2
replace memcoop = 0 if memcoop == 2
replace ccnumttl = . if ccnumttl == 999
replace ownhouse = . if ownhouse == 9
replace op4trust = . if op4trust == 9

*Create categorical variable related to the variable "the year living in the same place"
*replace "xliveyr" while making a distinction of the person who have lived in the same place since he/she was born.
gen native = 0
replace native = 1 if xliveyr == 1
replace xliveyr = 2 if xliveyr == 1 & ageb < 1
replace xliveyr = 3 if xliveyr == 1 & ageb >= 1 & ageb < 3
replace xliveyr = 4 if xliveyr == 1 & ageb >= 3 & ageb < 5
replace xliveyr = 5 if xliveyr == 1 & ageb >= 5 & ageb < 10
replace xliveyr = 6 if xliveyr == 1 & ageb >= 10 & ageb < 20
replace xliveyr = 7 if xliveyr == 1 & ageb >= 20 & ageb < 30
replace xliveyr = 8 if xliveyr == 1 & ageb >=30

/*
Respondent annual income: Overall
change "20 Don't want to state the income", "21 Don't know", and "99 No answer" into missing value
*/
gen h_income = 0
replace h_income = . if szincoma == 20 | szincoma == 21 | szincoma == 99
replace h_income = 1 if szincoma == 1 
replace h_income = 2 if szincoma == 2 | szincoma == 3 | szincoma == 4 | szincoma == 5
replace h_income = 3 if szincoma == 6
replace h_income = 4 if szincoma == 7
replace h_income = 5 if szincoma == 8
replace h_income = 6 if szincoma == 9
replace h_income = 7 if szincoma == 10
replace h_income = 8 if szincoma == 11
replace h_income = 9 if szincoma == 12
replace h_income = 10 if szincoma == 13
replace h_income = 11 if szincoma >= 14 & szincoma <= 19


*Create dummy variable related to the variable "Last school respondent attended"
*Reorganize shool system before and after the World War II
gen latest_edu = 0
*Ordinary elementary school　
replace latest_edu = 1 if xxlstsch == 1
*Reorganize Higher elementary school in the old system and junior high school　
replace latest_edu = 2 if xxlstsch == 2 | xxlstsch == 8
*Reorganize Junior high school/Girls' high school in the old system, Vocational school/Commerce school in the old system, Normal School in the old system, and High school
replace latest_edu = 3 if xxlstsch == 3 | xxlstsch == 4 | xxlstsch == 5 | xxlstsch == 9
*Reorganize Higher school or vocational school in the old system, College of technology, and 2-year college
replace latest_edu = 4 if xxlstsch == 6 | xxlstsch == 10 | xxlstsch == 11
*Reorganize University/Graduate school in the old system, University, and Graduate school
replace latest_edu = 5 if xxlstsch == 7 | xxlstsch == 12 | xxlstsch == 13
*Don't know 
replace latest_edu = 6 if xxlstsch == 14
*No answer
replace latest_edu = . if xxlstsch == 99

*label "Last shchool respondent attended" of the research
label variable latest_edu "education"
label define education 1 "elementary school" 2 "junior high school" 3 "high school" ///
4 "community college" 5 "university" 6 "unknown" 7 "N/A"
label value latest_edu education


*categorical variable relate to "ageb"
*divide floor by 10 and delete decimal point
generate agecat = floor(ageb/10) 
*make Column 1 year, Column 2 sex, and Column 3 agecat
order year sexa ageb agecat


*delete experience of volunteer activities: Disabilities
drop xvldisab

/* 
about each volunteer activities
delete "9 No answer"
replace "8 Not applicable" into "O Not chosen"
*/
drop if xvlimprt == 9 | xvlntenv == 9 | xvlsafe == 9 | xvlspts == 9 | xvleld == 9 | xvlcc == 9 | xvlothr == 9 | xvlnone == 9
replace xvlimprt = 0 if xvlimprt == 8
replace xvlntenv = 0 if xvlntenv == 8
replace xvlsafe = 0 if xvlsafe == 8
replace xvlspts = 0 if xvlspts == 8
replace xvleld = 0 if xvleld == 8
replace xvlcc = 0 if xvlcc == 8
replace xvlothr = 0 if xvlothr == 8 

*Create a new variable to mean all volunteer activities excluding "experience of volunteer activities: None"
gen allvolunteer = xvlimprt + xvlntenv + xvlsafe + xvlspts + xvleld + xvlcc + xvlothr 
gen d_allvolunteer = (allvolunteer >= 1)

/*
marital stasus
Reorganize "Currently married" and "Cohabiting"
Reorganize "Divorce", "Widowed", "Never married", and "Separated"
*/
drop if domarry == 9
replace domarry = 2 if domarry == 3
replace domarry = 2 if domarry == 4
replace domarry = 2 if domarry == 5
replace domarry = 1 if domarry == 6


*drop "9 No answer" 
*Reorganize "Almost everyday" and "Several times a week"
drop if fq7frsee == 9
replace fq7frsee = 2 if fq7frsee == 1

*the same procedure like "Frequency of Meals with Friends"
drop if latest_edu == 9 | latest_edu == 0


*drop "9 No answer" on "work status"
*Reorganize "I worked last week" and "I was going to work last week, but did not work"
drop if xjob1wk == 9
replace xjob1wk = 1 if xjob1wk == 2
replace xjob1wk = 2 if xjob1wk == 3

replace sexa = 0 if sexa == 2
replace domarry = 0 if domarry == 2
replace xjob1wk = 0 if xjob1wk == 2

save JGSS20102012append.dta,replace


use JGSS20102012append.dta, clear

drop if year == . | /// 
 sexa == . | /// 
 ageb == . | /// 
 sizehmt == . | /// 
 fqnbas == . | /// 
 ownhouse == . | ///
 xjob1wk == . | /// 
 domarry == . | /// 
 fqnbas == . | /// 
 xliveyr == . | /// 
 fq7frsee == . | /// 
 mempltgp == . | /// 
 memind == . | /// 
 memvlntr == . | /// 
 memcivil == . | /// 
 memrl == . | /// 
 memsport == . | /// 
 memhobby == . | /// 
 memcoop == . | /// 
 native == . | /// 
 h_income == . | /// 
 latest_edu == . 
 

save JGSS20102012append_excl_missing.dta,replace


use JGSS20102012append_excl_missing.dta, clear


*Make the baseline(reference) related to variale "Respondent annual income: Overall" Less than 700,000 yen to 1.5 million yen"
logit d_allvolunteer domarry sexa xjob1wk agecat##agecat i.sizehmt ///
 i.fqnbas i.xliveyr native i.fq7frsee mempltgp memind memvlntr memcivil memrl memsport memhobby memcoop ///
 b2.h_income i.latest_edu i.ownhouse i.year
outreg2 using netwk_incbase_yr.xls, 10pct dec(3)
margins, dydx(*) post
estimates store margins_all
outreg2 margins_all using netwk_incbase_yr.xls, 10pct dec(3)


use JGSS20102012append_excl_missing.dta, clear
keep if xvlimprt == 1 | xvlnone == 1
save xvlimprt.dta, replace


logit xvlimprt domarry sexa xjob1wk agecat##agecat i.sizehmt ///
 i.fqnbas i.xliveyr native i.fq7frsee mempltgp memind memvlntr memcivil memrl memsport memhobby memcoop ///
 b2.i.h_income i.latest_edu i.ownhouse i.year
outreg2 using netwk_incbase_yr.xls, 10pct dec(3)
margins, dydx(*) post
estimates store margins_community
outreg2 margins_community using netwk_incbase_yr.xls, 10pct dec(3)


use JGSS20102012append_excl_missing.dta, clear
keep if xvlntenv == 1 | xvlnone == 1
save xvlntenv.dta, replace
logit xvlntenv domarry sexa xjob1wk agecat##agecat i.sizehmt ///
 i.fqnbas i.xliveyr native i.fq7frsee mempltgp memind memvlntr memcivil memrl memsport memhobby memcoop ///
 b2.i.h_income i.latest_edu i.ownhouse i.year
outreg2 using netwk_incbase_yr.xls, 10pct dec(3)
margins, dydx(*) post
estimates store margins_environment
outreg2 margins_environment using netwk_incbase_yr.xls, 10pct dec(3)


use JGSS20102012append_excl_missing.dta, clear
keep if xvlsafe == 1 | xvlnone == 1
save xvlsafe.dta, replace
logit xvlsafe domarry sexa xjob1wk agecat##agecat i.sizehmt ///
 i.fqnbas i.xliveyr native i.fq7frsee mempltgp memind memvlntr memcivil memrl memsport memhobby memcoop ///
 b2.i.h_income i.latest_edu i.ownhouse i.year
outreg2 using netwk_incbase_yr.xls, 10pct dec(3)
margins, dydx(*) post
estimates store margins_safety
outreg2 margins_safety using netwk_incbase_yr.xls, 10pct dec(3)


use JGSS20102012append_excl_missing.dta, clear
keep if xvlspts == 1 | xvlnone == 1
save xvlspts.dta, replace
logit xvlspts domarry sexa xjob1wk agecat##agecat i.sizehmt ///
 i.fqnbas i.xliveyr native i.fq7frsee mempltgp memind memvlntr memcivil memrl memsport memhobby memcoop ///
 b2.i.h_income i.latest_edu i.ownhouse i.year
outreg2 using netwk_incbase_yr.xls, 10pct dec(3)
margins, dydx(*) post
estimates store margins_sports
outreg2 margins_sports using netwk_incbase_yr.xls, 10pct dec(3)

use JGSS20102012append_excl_missing.dta, clear
keep if xvlcc == 1 | xvlnone == 1
save xvlcc.dta, replace
logit xvlcc domarry sexa xjob1wk agecat##agecat i.sizehmt ///
 i.fqnbas i.xliveyr native i.fq7frsee mempltgp memind memvlntr memcivil memrl memsport memhobby memcoop ///
 b2.i.h_income i.latest_edu i.ownhouse i.year
outreg2 using netwk_incbase_yr.xls, 10pct dec(3)
margins, dydx(*) post
estimates store margins_children
outreg2 margins_children using netwk_incbase_yr.xls, 10pct dec(3)


