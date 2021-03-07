install.packages("here")
install.packages("qualtRics")
install.packages("tidyverse")
install.packages("lme4")
install.packages("psych")
install.packages("dplyr")
install.packages("sjlabelled")
install.packages("surveydata")
install.packages("ggpubr")
install.packages("rstatix")
install.packages("ellipsis")
install.packages("tibble")
install.packages("lme4")
install.packages("lmerTest")
install.packages("Hmisc")

suppressPackageStartupMessages(library(here))
suppressPackageStartupMessages(library(qualtRics))
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(lme4))
suppressPackageStartupMessages(library(psych))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(sjlabelled))
suppressPackageStartupMessages(library(surveydata))
suppressPackageStartupMessages(library(ggpubr))
suppressPackageStartupMessages(library(rstatix))
suppressPackageStartupMessages(library(ellipsis))
suppressPackageStartupMessages(library(tibble))
suppressPackageStartupMessages(library(lme4))
suppressPackageStartupMessages(library(lmerTest))
suppressPackageStartupMessages(library(Hmisc))

setwd("C:/Users/Liz/Box/Yoni Study")#set your working director (ordo the point and click method)

qualtrics_api_credentials(api_key = "VK6fpKTt4uqHsABK4n6MGdRuLT3b0a7N8QBbOYPl",     #this key might be different for you! I think I had to add it. 
                          base_url = "usf.az1.qualtrics.com", 
                          install = TRUE) # gives access to Qualtrics library

readRenviron("~/.Renviron")

surveys <- all_surveys() # imports full Qualtrics survey list

mysurvey <- surveys %>% # selects only relevant survey (ask Liz how to get the id number)
  filter(id == "SV_1NyHq22Is266aUZ")

yoni <- mysurvey %>% # fetches survey data
  fetch_survey(surveyID = mysurvey$id[1],
               force_request = TRUE,
               label = FALSE,
               convert = FALSE,
               include_display_order = FALSE)

write_csv(yoni,
          here::here("yoni.csv")) # writes csv of raw data so you have it on file. You can do this with your filtered data too to look at it. 

#These are all the basic commands I start with for cleaning data
pilot2<- pilot1d%>% 
  rownames_to_column(var = "p") %>% #add participant numbers
  select(-(RecipientLastName:ExternalReference))%>% #remove bullshit columns last name thru external reference
  drop_na(Q59.2)%>% #drop anyone who didn't answer this question (e.g. has all/mostly)
  rename_all(tolower)%>% #rename all variables to lowercase for easier coding later
  dplyr::mutate(q3.1_5_text = replace_na(q3.1_5_text, "NA")) %>% #convert NA to string with actual "NA" in the space
  filter((q3.1 %in% c(2, 5)),q3.1_5_text %in% c("Woman", "woman", "Woman/Bisexual", "NA")) #only keep people who gave a 2(woman) or 5(other), then, of people who answered other, keep only the people who typed in "woman" in the optional fill-in


#here's a simpler filter
yoni4<-yoni3%>% #I like to keep my old data set and write the altered data set to a new object so I can go back without having to re-run everything. This says "Take Yoni 3, filter it, and name it Yoni 4"
  filter(durmin > 10)

items<-as.matrix(get_label(pilot2))#get and print item wording for all items. You can also view them when you click on the object for your data or enter: view(yoni4)   as an example
items

#Syntax for alpha of a set of items. Psych::alpha means "use the psych package to run the alpha command" in case multiple packages have an alpha command
yoni5 %>%
  select(asi_9, asi_17, asi_20)%>% #select a set of columns
  psych::alpha(check.keys=TRUE) #if you have any items that load as a reverse, you'll want to remove the check keys from the parens unless the item has reverse wording


#These commants let you view/understand your variables
print(yoni4$ASI)#in the data set yoni4, print all ASI scores
typeof(yoni4$rs1)#get type: number of string. "double" and "integer" are numerical 
names(yoni4)#print the column names of all variables in the data set
head(yoni4)#prtin names and first 10 cases of all variables, up until it runs out of spatce. Printing individual variables can be more helpful
describe(yoni4$durmin)#descriptive stats for the variable durmin in yoni4
labels(yoni4) #i dk what this does?

yoni5<-yoni5 %>% 
  mutate(as.numeric((agen_1))) #make a strong variable numeric

cor.test(yoni3$incont, yoni3$durmin)#correlation between two variables
cor.test(yoni3)#correlate all variables in the data set (best to make a subset of variables that you're interested in (see alpha syntax above))

#here's how to rename variables
o39<-pilot3 %>% 
  select(p, q39.10:q39.13) %>% #select a set
  drop_na(q39.10) %>% #drop the blanks
  rename(unusual = "q39.10") %>% 
  rename(believable = "q39.11") %>% 
  rename(agreement = "q39.12") %>% 
  rename(action = "q39.13")

#here's how to compute a variable. 
pilot3<-pilot3%>% #start with pilot 3 and write the new variable into the same data set
  rowwise() %>% #use values in thge same row (i.e., within a subject)
  mutate(HS34 = mean(c(q34.3, q34.4, q34.5)) #HS34 is the mean of 3 items in response to item 34
  

#here are some exploratory descriptive stats
print<-get_summary_stats(pilotA1, HSBSscoreA, type = "mean_sd") #mean and SD of the variable HSBSScoreA within the pilotA1 data set

ggboxplot(pilotA1, x = "sexism_item", y = "HSBSscoreA", add = "point") #box plot of all HS anbd BS scores across several items

ggplot(data=pilotA1, aes(x=sexism_item, HSBSscoreA)) + #bar graph of same
  geom_bar(stat="identity")

pilotA1 %>% #check for outliers
  group_by(sexism_item) %>%
  identify_outliers(HSBSscoreA)

pilotA1 %>%
  group_by(sexism_item) %>% #forgot what this does--something for normality I think
  shapiro_test(HSBSscoreA)


#within-subjects ANOVA looking at differences in HS and BS scores of all of my pilot items
aov = aov(HSBSscoreA~sexism_item+Error(p/sexism_item),pilotA1) #run the analysis and save it as the pbject "aov"
summary(aov) #print the results
print(model.tables(aov,"means"),digits=3)#report the means and the number of subjects/cell
boxplot(HSBSscoreA~sexism_item,data=pilot9)#graphical output

#follow-up pairwise t-tests
attach(pilotA1) #attach the data set first
pwc<-pairwise.t.test(score, sexism_item, paired = TRUE, p.adjust.method = "none") #run the comparisons without correction and save as "pwc". can do bonferroni, etc, in place of "none"
pwc #print the result
detach(pilotA1) #detach the data set so you can attach a different one later
