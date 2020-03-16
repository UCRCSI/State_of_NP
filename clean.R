library(tidyverse)
#open the rds file in your directory
dta_current <- read_rds("dta/raw/2020-03-11.rds")

# Clean names
dta_current <- dta_current %>% janitor::clean_names()
# Drop test
dta_current <- dta_current %>% filter(q2 != "test@gmail.com")

## Recoding dta$finished
dta_current$finished <- as.character(dta_current$finished)
dta_current$finished <- fct_recode(dta_current$finished,
                                   "Complete" = "TRUE",
                                   "Incomplete" = "FALSE")


# dta_current$finished
# Cleaning ----------------------------------------------------------------

dta_current <- dta_current %>%
  filter(finished=="Complete") %>%
  distinct(q2,.keep_all = T)

#check question list
reference <- dta_current %>% 
  mutate(id = row_number()) %>% 
  filter(id == 1) %>% 
  gather(key, value) %>% 
  mutate(row = row_number())

#rename important questions
dta_current <- dta_current %>%
  rename(org_name = q2, #basic questions
         org_other_name = q4_1,
         org_other_zip = q4_2,
         org_year = q5,
         org_indep = q7,
         capacity_2 = q10_2,
         capacity_3 = q10_3,
         capacity_4 = q10_4,
         capacity_5 = q10_5,
         capacity_6 = q10_6,
         capacity_7 = q10_7,
         capacity_8 = q10_8,
         capacity_9 = q10_9,
         capacity_11 = q10_11,
         capacity_12 = q10_12,
         capacity_13 = q10_13,
         capacity_14 = q10_14,
         capacity_15 = q10_15,
         capacity_16 = q10_16,
         capacity_17 = q10_17,
         capacity_18 = q10_18,
         capacity_19 = q10_19,
         con_bylaw = q12_1,
         annual_reprt = q12_2,
         b_directors = q12_3,
         ad_board = q12_4,
         paid_staffs = q13_1,
         volunteers = q13_2,
         members = q13_3,
         clients = q13_4,
         org_growth = q14,
         serve_age1 = q15_1,
         serve_age2 = q15_4,
         serve_age3 = q15_5,
         serve_age4 = q15_6,
         serve_age5 = q15_7,
         serve_age6 = q15_8,
         serve_age7 = q15_9,
         serve_age8 = q15_10,
         org_race_wt = q16_1,
         org_race_lx = q16_2,
         org_race_blk = q16_3,
         org_race_asn = q16_4,
         org_race_pi = q16_5,
         org_demo_dis = q17_1,
         org_demo_hmless = q17_2,
         org_demo_inc = q17_3,
         org_demo_m = q17_4,
         org_demo_f = q17_5,
         org_demo_trans = q17_6,
         org_demo_lgbtq = q17_7,
         org_exp = q18,
         source_rev_2 = q19_2,
         source_rev_3 = q19_3,
         source_rev_4 = q19_4,
         source_rev_5 = q19_5,
         source_rev_7 = q19_7,
         source_rev_8 = q19_8,
         source_rev_9 = q19_9,
         source_rev_10 = q19_10,
         source_rev_other = q19_6,
         tech = q20,
         tech_type1 = q21_1,
         tech_type2 = q21_5,
         tech_type3 = q21_4,
         tech_type4 = q21_2,
         alliance = q22,
         alliance1 = q23_1,
         alliance2 = q23_2,
         alliance3 = q23_3,
         alliance4 = q23_4,
         alliance_formal  = q24,
         alliance_fund = q25)

#merging nonprofit list from IRS with survey additional entries
dta <- dta_current[,1:4]

dta_current <- dta_current %>% 
  mutate(org_name = case_when(
  is.na(org_name) == F ~org_name,
  is.na(org_other_name) == F ~org_other_name,
  TRUE ~NA_character_))

dta_current$org_name


####-----------------------------------------------------------
#backup script if....
#merging multiple choices into one string...
#divide by ", "...
#skip all the NAs in between

dta_q88 <- dta_current %>% 
  select(q88_1, q88_4, q88_5, q88_6, 
         q88_7, q88_8, q88_9, q88_10, q88_11, q88_12, 
         q88_13, q88_14, q88_15, q88_16, q88_17, q88_18, 
         q88_19, q88_20, q88_21, q88_22, q88_23, q88_24, 
         q88_25, q88_26, q88_27_text)

# create full string
dta_current$org_area <- apply(dta_q88, 1, function(x) paste(na.omit(x),collapse=", ") )

