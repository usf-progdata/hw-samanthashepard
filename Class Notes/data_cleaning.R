library(dplyr)
library(tidyr)
library(tibble)


dat_bfi <- psychTools::bfi
key_bfi <- psychTools::bfi.keys

head(dat_bfi)


# ==================================================
#convert row names to be read like any other column
#moves row names into its own column

# getting rid of rownames
dat_bfi <- dat_bfi %>%
  rownames_to_column(var = ".id")

# now you can do normal things like filter by this column
head(dat_bfi)
filter(dat_bfi, .id == 61617)


# ==================================================

#Difference between Base R and Tidyverse

# converting between data.frame and tibble

## data.frame (base R)
#data frames don't show you what kinds of variables the columns are
psychTools::bfi

## convert data frame into tibble (tibble/tidyverse)
as_tibble(psychTools::bfi, rownames = ".id")
#tibbles displays the type of variable is in each column (character, integer, etc)
#Tibbles also do things like check to make sure 2 columns don't have the same name
#when you import data, you'll want to import as tibble with "as_tibble"

dat_bfi <- as_tibble(dat_bfi)

#if you want  to see more rows = "n = 30"
print(dat_bfi, n = 30)

## tibbles are nice, but some packages (e.g., lavaan) don't play well with them
## In that case, convert back to data.frame:
as.data.frame(dat_bfi)


# ==================================================

# recode()
select(dat_bfi, .id, gender, education)

## Let's recode the categorical variables
dict <- psychTools::bfi.dictionary %>%
  as_tibble(rownames = "item")

# Remember how mutate() and summary() have the form:
#   mutate(.data, new_column = computation)

# recode() is backwards:
#   recode(.x, old = new)

dat_bfi %>%
  mutate(
    gender = recode(gender, "1" = "man", "2" = "female")
  ) %>%
  select(.id, gender, education)

## note that for numeric values, you need to wrap them in "quotes" or `backticks`
## That's not necessary for character values
palmerpenguins::penguins %>%
  mutate(sex = recode(sex, male = "Male", female = "Female"))

## Let's look at a few more recode options
?recode

dat_bfi %>%
  mutate(
    education = recode(education, "1" = "Some HS", "2" = "HS", "3" = "Some College", "4" = "College", "5" = "Graduate degree")
  ) %>%
  select(.id, gender, education)
#if you only recoded 2 out of the 5, it's gonna give you a warning message to let you know there were other values that you didn't recode.


## Let's say we want just "HS or less" versus "more than HS"
dat_bfi %>%
  mutate(
    education = recode(education, "1" = "HS", "2" = "HS", .default = "More than HS")
  ) %>%
  select(.id, gender, education)
#The new column is called college^



## Let's say we want to convert NA values to an explict value
dat_bfi %>%
  mutate(
    education = recode(education, "1" = "HS", "2" = "HS", .default = "More than HS", .missing = "(Unknown)")
  ) %>%
  select(.id, gender, education)

# tidyr::replace_na()

## If we just want to replace NA values, use `tidyr::replace_na()`

dat_bfi %>%
  mutate(
    education = replace_na(education, replace = "(Unknown)")
  ) %>%
  select(.id, gender, education)




# reverse coding variables
print(dict, n = 30)

reversed <- c("A1", "C4", "C5", "E1", "E2", "O2", "O5")


reversed <- dict %>%
  filter(Keying == -1) %>%
  pull(item)

dat_bfi %>%
  mutate(A1r = recode(A1, "6" = 1, "5" = 2, "4" = 3, "3" = 4, "2" = 5, "1" = 6)) %>%
  select(A1, A1r)


dat_bfi %>%
  mutate(A1r = 7 - A1) %>%
  select(A1, A1r)

#reminder = "across" = across a bunch of columns, do the same thing
#".x" - placeholder - refers to all of the columns you chose
#"reversed" = columns in the reversed vector you made
dat_bfi %>%
  mutate(
    across(all_of(reversed),
           ~ recode(.x, "6" = 1, "5" = 2, "4" = 3, "3" = 4, "2" = 5, "1" = 6),
           .names = "{.col}r")
  ) %>%
  select(A1, A1r)



# Now you try:

## 1. Use the psychTools::bfi (or psych::bfi) data
## 2. Recode gender to 'man', 'women', '(no response)'
dat_bfi %>% 
  mutate(
    gender = recode(gender,"1" = "woman", "2" = "man", .missing = "(Unknown)")
  ) %>% 
  select(gender)
## 3. Recode education to "Some HS", "HS", "Some College", "College", "Graduate degree", "(no response)"
## 4. Compute a new variable `hs_grad` with levels "no" and "yes"


dat_bfi %>% 
  mutate(
    hs_grad = recode(education, "1" = "no", .default = "yes", .missing = "(Unknown)")
  ) %>% 
  select(education, hs_grad)
## 5. Reverse code the -1 items, as indicated in psychTools::bfi.dictionary or psych::bfi.key
