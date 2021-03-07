3 parts to an Rmarkdown document:
  - regular text; this is like the text you would write in your report/manuscript
  - codeblocks - in between the "```{r}" and "```"; for code to run it needs to be in between them
  - YAML - very top of file - the parts bewteen 3 hyphens; information about the document
      - YAML gives you name of options; options for title, output format, etc.
      - if you want to give several values for an option, put several lines underneath and indent
      example: (allows you to make it into 2 formats)
      (then knit to both formats)

---
title: ''
output:
  html_document: default
  github_document: default
---

    ***you have to put the github_document function first if you want the option to knit both!
    Clicking the little blue yarn icon and clicking the dropdown are different things.
    The little blue yarn icon is what gives you the .md github file 
    You also have to go to the R Markdown console sometimes to get stuff from it; it tells you where files save.


#How to save operation - assign value to object.
# Assign
number_of_pies <- 65 * 8

number_of_pies +1

z <- 10
z
#then if you run z, it spits out 10.

#until you assign something, nothing gets saved.
#Thursday - gonna talk about vectors, dataframes, and github

#Tuesday 1/19/21
# R Script and R Markdown

# R Markdown combines R script to other text that is not R script.
# Save name of R Script with ".R"

#Object:
# everything in R is an object; if it exists in R, it's an object.'
#every object has a name and contents

3
pi #pi exists as object, its name is pi, and it's value is 3.14.....
# some objects are data sets that exist in R

#mtcars = name is "mtcars"; contents is the entire data frame

number <- 4
number # 4 is now called because the number 4 is assigned to the object
#Remove the object:
rm(number)

#when you assign objects, it doesn't automatically print out the value
#BUT if you do, you can put it in parentheses.
(number <- 4)

number * 2

#if you want to assign number the value that is twice the current number:
number <- number * 2


# you rarely want to work with 1 number at a time.
# VECTOR: working with multiple numbers at the same time
# set of multiple values of the same type

#make a vector:
times <- c(7, 5, 5, 9, 5.5, 4, 8, 6.5)
#c stands for concatenate

Types:
  #numberic
    #double (decimal) dbl
    c(2, 3.4, 1000)

    # integer
    # numerics without decimals
    # Tell R to give you integers by putting capital L after numbers
    c(1L, 2L, 100L)

    
    
  #character (words)
    #characters are wrapped in quotes
    c("a", "b", "lastname")

  #logical (TRUE/FALSE)
    c(TRUE, FALSE)
    #you can also just write T or F but it's easy for R to overwrite.

    
#if you combine two types of types into one vector, it puts it into the most general character.
    
#you can change the data in a vector with just ONE command.
times * 60
#you probably just want to do this if you only have 1 value you're doing this with


#functions
#everything that exists in R is an object; everything that R does is a function.
#functions take inputs and give us output.
#functions are basically pre-written R programs
#All R functions take a similar general form.

functionName(arg1 = val1, arg2 = val2, and so on)
#arg = argument

mean(times)

# See how a function works - look up helpfile
?mean
#or
help(mean)

#functions have default values - e.g., mean sets trim to 0 and NA to false.

#trimming top and bottom 25%:
mean(times, trim = .25)
#trims to mean of 6

#Specify arguments:
  #name the arguments
  mean(times, trim = .25)
  mean(x = times, trim = .25)

  mean(times, .25) ### YUCKY THOUGH; it doesn't tell you what the .25 is.
  
#if you name a first argument, you have to name the others that come after.

#!!!How to see arguments in a function: Press TAB when your cursor is after the object
mean(times,)

#literate programming - clearly writing code so it helps to read, decode, fix bugs, etc.

#other functions
sd(times)
range(times)
length(times)

#comparisons - comparing values to each other

#which of these are less than 6?
times < 6
#returns vector of logical values.

#which are exactly equal to 6?
times == 6

#combine multiple comparisons together:
#& (AND), | (OR), and ! (NOT).
! (times > 3 & times < 9)

#subset = pull out

#any values not between 3 and 6.
#any(! (times > 3 & times <9)

   #subsetting vector:
  times[4]

#pick out 4, 5, and 6th element in times:
  times[4:6]
  

#you can use subsetting to modify vector.

  #assign new element to the first value
  times[1] <- 5 
  
  
  #cap entries greater than 8:
  times[times > 8] <-8
  #take out all the values that are greater than 8 then set them to 8.


#Remove values  
#missing values = NA
#if you want to take out the 2nd value of the vector:
times[2] <- NA
#the brackets indicate the sequence of values in the vector.
times


mean(times, na.rm = TRUE)
#so the mean without the value is 6


#Dataframes/Data
#dataframe: list of vectors that are the same length.
mtcars
#each column has same # of values

#view first 6 rows:
head(mtcars)

# number of rows in data frame:
nrow(mtcars)
  


#R already comes with a ton of functions, but sometimes you want functions that
#don't come pre-loaded.
#How to get more functions: packages
#packages = pre-written functions

install.packages("palmerpenguins")
#contacts CRAN server and downloads.
#####don't put install package code in scripts.
#just put library commands in script to make function available

#Global environment: shows us the packages we've loaded
#shows objects in packages - data, values, functions
#penguins is the dataset.

library(palmerpenguins)

  
#1/21/21

#File >> new project >> Git >> put URL in repository >> create project
#going to clone github files to your computer, then switch R studio to be running in that folder.
#should show files in repository in the righthand side pane
#workflow -
#open file from Github folder on computer; use project folder

#2/2/21
remotes::install_github("bwiernik/progdata@main")
progdata::tutorial_wrangle()

#DATA WRANGLING
#you spend the majority of your time wrangling your data


Specific dplyr functions we will cover

select()
arrange()
filter()
mutate()
#make a new vbl; change vbl
summarize()
#descriptive stats; can combine with below functions
group_by()
grouped mutate()
grouped summarize()

#Prog Data Guide: 4.6.2

#Manipulating/working w data frames!
Base R vs. dplyr_col_modify()


Example of dplyr vs base R:
  
  gapminder[gapminder$country == "Cambodia", c("year", "lifeExp")]
vs.

#Base R - can be easy to miss quotes, etc.

gapminder %>%
  filter(country == "Cambodia") %>%
  select(year, lifeExp)

#dplyr breaks it up into separate steps.
#"%>%" = "then"
#above ^^ filter, THEN select.
#"%>%" = this is called a pipe. it takes whatever is on the left and turns that into an argument
#pipes separate out different steps.
#the second step only runs after the version of the data that gets passed through the first step
#each pipe step happens one at a time

#PRACTICE
mtcars %>%
  head()

####html page populated from initial code for today's class.

#the period (.) = stands for the first part of the argument.
#the dots says whatever was in the output for the left side - put it on the right side
#this piping etc. allows you to do multiple steps without creating objects

#The workflow
#Wrangle your data with dplyr first
#Pipe %>% your data into a plot/analysis

Basic principles:
  When it comes to coding, here are some helpful steps:
  
  Do one thing at a time

Transform variables OR select variables OR filter cases
Chain multiple operations together using the pipe %>%
  
  Use readable object and variable names

Subset a dataset (i.e., select variables) by name, not by “magic numbers”

Note that you need to use the assignment operator <- to store changes!


#select()
#there are several dif packages that use the select function
#make sure you load dplyr first
#select multiple dif columns

#the - character = remove columns with select
#Limit data to specific columns:

head(bfi_data)


gender_neuro <-
  bfi_data %>% 
  select(.id, gender, neuroticism)

gender_neuro


#Arrange - sort particular columns

desc_bfi <-
  bfi_data %>% 
  arrange(desc(age))

desc_bfi
#desc = descending


#select several columns:
#The colon operator - "to"
#example:
bfi_data %>%
  select(agree:openness)

#can avoid copy/pasting n stuff with these functions
any_of()
all_of()
# for all of - all variables have to exist if you try to call them

#filter = cutoffs.

openness_cut_off <-
  bfi_data %>% 
  filter(openness >= 3)

openness_cut_off

#filtering w multiple criteria
bfi_data %>% 
  filter(age > 20 & age < 29)
#you don't need to save something like this as an object if you don't necessarily wanna save it

#MUTATE! v frequently used in R
#create new variable, change or recode existing vbls

modified_data <-
  data %>% 
  mutate(new_column = any_operations(existing_variables))
#"newcolumn" - the new column you're creating


#2/9/21

gapminder %>%
  summarize(mean = mean(pop),
            sd = sd(pop)
            )

?summarize

library(dplyr)
library(gapminder)




