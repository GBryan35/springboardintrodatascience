library(tidyverse) 
library(fastDummies)
library(readxl)

refine_original <- read_excel("C:/Users/Gala/Desktop/refine_original.xlsx")
View(refine_original)

refine_company <- refine_original %>% 
 # standardize company names and spelling using mutate to keep the updated company names in the dataframe
   mutate(company = gsub( ".*ps", "phillips", company, ignore.case = TRUE) %>% 
           gsub("^ak.*", "akzo", ., ignore.case = TRUE) %>%
           gsub("^va.*", "van houten", ., ignore.case = TRUE) %>%
           gsub("^un.*", "unilever", ., ignore.case = TRUE)
  ) %>%
  #separate product code and number
  separate( "Product code / number", into = c("product_code", "product_number"), sep = "-") %>%
  #create a new column with product category
  mutate(product_category = gsub("p", "Smartphone", product_code, ignore.case = TRUE)%>%
           gsub("v", "TV",  ., ignore.case = TRUE) %>%
           gsub("x", "Laptop",  ., ignore.case = TRUE) %>%
           gsub("q", "Tablet",  ., ignore.case = TRUE)
  )  %>% 
  # create a new column with the full address, leaving the old columns in place
  unite(full_address, address, city, country, sep = ",", remove = FALSE) %>%
  #create dummy columns for companies and categories to use for statistical analysis
  dummy_cols(select_columns = c("company", "product_category"))


write.csv(refine_company, file = "refine_clean", row.names = FALSE)
