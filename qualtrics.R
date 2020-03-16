library(tidyverse)
library(qualtRics)
library(here)
here()
#### YOU WILL NEED TO FOLLOW INSTRUCTIONS to LINK qualtRics to your accounts.
####
# Census Landscape Master id
nonprofit_srvy <- "SV_0pSOGb8KXUxHdlj"


all_files <- list.files(here("dta/raw",""),".rds")
all_files <- str_remove(all_files,".rds")
all_files <- as.Date(all_files)
all_files <- sort(all_files,decreasing = T)
most_recent <- all_files[1]
most_recent
current_date <- Sys.Date()


# IF STATEMENTS -----------------------------------------------------------
if(is.na(most_recent)){
  print(paste("Grabbing lastest file now! "))
  # Fetch Survey ------------------------------------------------------------
  dta <- fetch_survey(surveyID = nonprofit_srvy,
                      verbose = TRUE,
                      force_request = T,
                      local_time=T)
  # Save Raw Copy ------------------------------------------------------------
  current_date <- Sys.Date()
  current_date <- paste(current_date,".rds",sep = "")
  dta %>%
    write_rds(here("dta/raw",current_date))
  rm(dta)
  gc()
} else if(most_recent == current_date){
  print("Uh. We actually have already downloaded the latest survey data today, so we should't need to re-download the data, unless you really want to")
  print("IS THAT WHAT YOU WANT!?!?!?!?")
  pull_again <- readline(prompt="Enter Y/N: ")
  pull_again <- str_to_lower(pull_again)
  if(pull_again == "y" | pull_again == "yes"){
    print("I mean if that's what you want.....")
    dta <- fetch_survey(surveyID = nonprofit_srvy,
                        verbose = TRUE,
                        force_request = T,
                        local_time=T)
    # Save Raw Copy ------------------------------------------------------------
    
    current_date <- paste(current_date,".rds",sep = "")
    dta %>%
      write_rds(here("dta/raw",current_date))
    rm(dta)
    print("I have saved the data in the raw data folder")
    gc()
  }
  else{
    print("cool, I'm going to just use the file we already downloaded.")
    
  }
}else if (is.na(most_recent)){
  print(paste("Grabbing lastest file now! "))
  # Fetch Survey ------------------------------------------------------------
  dta <- fetch_survey(surveyID = nonprofit_srvy,
                      verbose = TRUE,
                      force_request = T,
                      local_time=T)
  # Save Raw Copy ------------------------------------------------------------
  current_date <- Sys.Date()
  current_date <- paste(current_date,".rds",sep = "")
  dta %>%
    write_rds(here("dta/raw",current_date))
  rm(dta)
  print("I have saved the data in the raw data folder")
  gc()
}else{
  print(paste("OK, the most recent dataset we have is from ",most_recent,". Grabbing a newer one now! "))
  # Fetch Survey ------------------------------------------------------------
  dta <- fetch_survey(surveyID = nonprofit_srvy,
                      verbose = TRUE,
                      force_request = T,
                      local_time=T)
  # Save Raw Copy ------------------------------------------------------------
  current_date <- Sys.Date()
  current_date <- paste(current_date,".rds",sep = "")
  dta %>%
    write_rds(here("dta/raw",current_date))
  rm(dta)
  print("I have saved the data in the raw data folder")
  gc()
}








