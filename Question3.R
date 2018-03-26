---
title: "Exploratory Data Ananlysis"
output: html_notebook
---
##Exploratory Data Analysis on Multivatiate Dataset. 
####Steps Involved:
1. Loading and Reading the dataset
2. Insights about dataset
   a) Structure
   b) Dimensions
   c) Data types of predicting variables
   d) Summary of the dataset
   e) Removing duplicate columns such as Region
3. Data Cleansing
   a) Solved mapping issues between variable and its corresponding indicators using Excel.
   b) Converted numeric variables with NA's to 0.
   c)Computed the summary of the new dataset.
4. Data Visualization
   a) Plotted Box Plots and Strip charts to understand the data distribution and to detect outliers. Skewness in data and outliers were observed.
   b) Plotted Scatter Plot Matrix using GGally library to understand the correlation between other variables as well as CPC.

   

--Loading and reading the dataset

```{r}
Data<-read.csv('D:/Rutgers Study Material/MultivariateData1.csv')
# top 5 columns of the dataset
head(Data)
```

```{r}
#Names of the columns in dataset
names(Data)
```
There are 23 columns present.

```{r}
#Structure of the data
str(Data)
```
There are 7 factors or categorical variables. Lots of NA's or missing values were oobserved.

```{r}
# Dimension of the data
dim(Data)
```


```{r}
# Removing the extra columns
drops <- c("ï..Region","City","SupplyVendor","OS","Browser","DeviceType","Impression_Time")
New_data<-Data[ , !(names(Data) %in% drops)]
dim(New_data)

```
Since we have column names as well as their indicators, it's always better to remove redundant information.

```{r}
# Checking the datatype of each column 
attach(New_data)
class(Region_Indicators)
class(City_indicators)
class(SupplyVendors_Indicators)
class(OS_Indicators)
class(Browser_Indicators)
class(DeviceType_Indicators)
class(Impression_Day)
class(Impressions)
class(Clicks)
class(CTR)
class(CPC)
class(VCR)
class(CPV)
class(Completes)
class(Total_Spend)
class(CPCV)
```

```{r}
# Analyzing missing values
sapply(New_data,function(x) sum(is.na(x)))

```
A lot of indicators were missing from the data.
On analyzing the file "VLookUP" was not working properly. 
Steps Taken: Mapped the indicators using excel.
```{r}
summary(New_data)
```

```{r}
New_data$CPV[ is.na(New_data$CPV)] <- 0
New_data$CPC[ is.na(New_data$CPC)] <- 0
New_data$CPCV[ is.na(New_data$CPCV)] <- 0

```
```{r}
summary(New_data)
```
We can observe skewness in data as mean is either greater than or less than median.

###Visualizing the Data
Plotting stripcharts and boxplots side-by-side can be useful to visualize the spread and distribution of data as well as analyzing outliers.
```{r}

## Stripcharts
numeric_data <- New_data[,c(1:5)]
numeric_data <- data.frame(scale(numeric_data ))
strip<-stripchart(numeric_data,
           vertical = TRUE, 
           method = "jitter", 
           col = "orange", 
           pch=1,
           main="Stripcharts")
box<-boxplot(numeric_data,col='Purple')
```


```{r}

## Stripcharts
numeric_data <- New_data[,c(6:10)]
numeric_data <- data.frame(scale(numeric_data ))
strip<-stripchart(numeric_data,
           vertical = TRUE, 
           method = "jitter", 
           col = "orange", 
           pch=1,
           main="Stripcharts")
box<-boxplot(numeric_data)
```

```{r}

## Stripcharts
numeric_data <- new[,c(10:16)]
numeric_data <- data.frame(scale(numeric_data ))
strip<-stripchart(numeric_data,
           vertical = TRUE, 
           method = "jitter", 
           col = "orange", 
           pch=1,
           main="Stripcharts")
box<-boxplot(numeric_data)
```
From the above plots we can confirm about skewness and presence of outliers as well.

### Scatter Plot matrix is another important way to visualize data, its distribution and correlation with other variables.

```{r}
numeric_data <- New_data[,c(1,2,3,4,11)]
numeric_data <- data.frame(scale(numeric_data ))
library("GGally")
ggpairs(numeric_data)

```

CPC, Region Indicators, City Indicators are positively correlated while CPC, Vendor Indicator and OS Indiator are negatively correlated.
```{r}
numeric_data <- New_data[,c(5,6,7,8,9,11)]
numeric_data <- data.frame(scale(numeric_data ))
library("GGally")
ggpairs(numeric_data)
```
```{r}
numeric_data <- New_data[,c(10,12,13,11)]
numeric_data <- data.frame(scale(numeric_data ))
library("GGally")
ggpairs(numeric_data)
```

CTR,CPC,CPV are positively correlated and VCR negatively.
```{r}
numeric_data <- New_data[,c(14,15,16,11)]
numeric_data <- data.frame(scale(numeric_data ))
library("GGally")
ggpairs(numeric_data)
```
CPC, Completes, CPCV are negatively correlated and total spend is positively correlated.


