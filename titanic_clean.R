library(tidyverse)
library(readxl)
titanic_original <- read_excel("C:/Users/Gala/Desktop/titanic_original.xlsx")
View(titanic_original)


titanic_refine <- titanic_original %>%
     #Replace NA values in embarked column with a value ("S")
     mutate(embarked = ifelse(is.na(embarked), "S", embarked)) %>%
     #Replace NA values in age with the mean of age
     mutate(age = ifelse(is.na(age), mean(age, na.rm = TRUE), age)) %>%
     #Create new dummy column for observations with cabin numbers
     mutate(has_cabin_number = ifelse(is.na(cabin), 1,0))
   

  write.csv(titanic_refine, "titanic_clean.csv")
tmp <- read.csv("titanic_clean.csv")


