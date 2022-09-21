---
title: "R Notebook"
output: html_notebook
date: "21/04/2022"
Author: "Israel Usen"
---


#Data scientist salary data exploration, 'kaggle sample data'
#this can be done to know better about career as a data scientist and to make better choice sthat suits us as a person choices.


```{r}
#loading packages
library("tidyverse")
library("readr")
library("dplyr")
library('janitor')
library('skimr')
library("here")
```


#get working directory
getwd()


#the package needed to make the csv file load
getOption("repos")

#reading my csv file, then assigning it to a variable name
ds_salary<-read.csv("ds_salaries.csv", header = TRUE, sep = ",") 

View(ds_salary)


```{r}
ds_salary %>% 
  Select(job_title, experience_level, work_year,employment_type, salary_in_usd, employee_residence, company_location)
```


```{r}
#the experience level of data scientist with salaries>160,000 usd living in Us
ds_salary %>% 
  select(job_title, experience_level, salary_in_usd, employee_residence)%>%
  filter(job_title=="Data Scientist", salary_in_usd > 160000, employee_residence=="US") %>% 
  arrange(-salary_in_usd)#in descending order
#this makes it easier to understand that most data scientist that earn the highest pay livining in the US are the senior level in experience.

```


```{r}
#the experience level of data Analyst with salaries>160,000 usd living in Us
ds_salary %>% 
  select(job_title, experience_level, salary_in_usd, employee_residence)%>%
  filter(job_title=="Data Analyst", salary_in_usd > 160000, employee_residence=="US") %>% 
  arrange(-salary_in_usd)#in descending order
#the  same is the case for the data analyst, the most earners are of the senior level in work experience.
```


```{r}
#to know the job title with the maximum pay living in us and their job experience level.
ds_salary %>% 
  select(job_title, experience_level, salary_in_usd, employee_residence)%>%
  group_by(job_title, experience_level, salary_in_usd, employee_residence) %>% 
  summarize(max_salary_in_usd=max(salary_in_usd)) %>% 
  arrange(-max_salary_in_usd)#in descending order
#the job title with the maximum pay are the Principal Data Engineer, with an expert level these are the executive
```

   
```{r}
#to know the data scientist highest pay for those living in GB and their job experience level.
ds_salary %>% 
  select(job_title, experience_level, salary_in_usd, employee_residence)%>%
  filter(job_title=="Data Scientist", employee_residence=="GB") %>% 
  arrange(-salary_in_usd)#in descending order
#the highest paid data scientist earns over 180,000usd and is a mid level experience
```


```{r}
#to know the average pay of BI data analyst living at ES with an entry level experience 
ds_salary %>% 
  select(job_title, experience_level, salary_in_usd, employee_residence)%>%
  filter(job_title=="BI Data Analyst", employee_residence=="ES", experience_level=="EN") %>% 
  group_by(experience_level) %>% 
  summarize(mean_salary_in_usd=mean(salary_in_usd)) 
#there is no BI Data Analyst that resides in ES with an entry level experience
```


```{r}
#the same code for BI Data Analyst in the US
ds_salary %>% 
  select(job_title, experience_level, salary_in_usd, employee_residence)%>%
  filter(job_title=="BI Data Analyst", employee_residence=="US", experience_level=="EN") %>% 
  group_by(job_title, experience_level, employee_residence) %>% 
  summarize(mean_salary_in_usd=mean(salary_in_usd))
#this gives us the average
```


```{r}
#let do this for every resident location
ds_salary %>% 
  select(job_title, experience_level, salary_in_usd, employee_residence)%>%
  filter(job_title=="BI Data Analyst", experience_level=="EN") %>% 
  group_by(job_title, experience_level, employee_residence) %>% 
  summarize(mean_salary_in_usd=mean(salary_in_usd))
#it gives us the average salary for just two locations and that's for the US and KE
```


```{r}
#which place of residence generates the highest pay for the lead data scientist
ds_salary %>% 
  select(job_title, experience_level, salary_in_usd, employee_residence)%>%
  filter(job_title=="Lead Data Scientist") %>% 
  arrange(-salary_in_usd)#in descending order
#Us is where the highest paid Lead Data Analyst resides with SE as the experience level.
```


```{r}
#where is the location of the company that pays the minimum to the machine learning engineer
ds_salary %>% 
  select(job_title, experience_level, salary_in_usd, company_location)%>%
  filter(job_title=="Machine Learning Engineer") %>% 
  group_by(job_title, experience_level, company_location) %>% 
  summarize(min_salary_in_usd=min(salary_in_usd))
#the company is located at CO and pays the least to the Machine Learning Engineer

```

#Note: this goes on and on but let's give it a wrap.
