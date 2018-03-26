---
title: "Factors Affecting CPC"
output: html_notebook
---
###4.Make a data model to predict the factors affecting CPC.

The aim was to build a data model for feature selection.
Methods Used:
1. Using Step wise regression
2.Random Forest (Limitation can only perform feature selection till 53 levels but Region and city indicator had more levels. In order to continue withthe model removed region and city indicators)
3.Decision Trees(Same limitation as Random Forest)
4.Boruta

Conclusion: As per the data models top 5 predictors are:
            a) CTR
            b) Clicks
            c) CPV
            d) Total_Spend
            e) CPCV

```{r}
Data<-read.csv('D:/Rutgers Study Material/MultivariateData1.csv')
# top 5 columns of the dataset
head(Data)
```

```{r}
# Removing the extra columns
drops <- c("ï..Region","City","SupplyVendor","OS","Browser","DeviceType","Impression_Time")
New_data<-Data[ , !(names(Data) %in% drops)]
dim(New_data)
```

```{r}
New_data$CPV[ is.na(New_data$CPV)] <- 0
New_data$CPC[ is.na(New_data$CPC)] <- 0
New_data$CPCV[ is.na(New_data$CPCV)] <- 0
```


```{r}

# Model fitting
fit<- lm(CPC~., data=New_data)
summary(fit)
```
```{r}
# Step wise Regression
model1<- step(fit)
summary(model1)
```
```{r}
drops <- c("Region_Indicators","City_indicators")
RF<-New_data[ , !(names(New_data) %in% drops)]
```

```{r}
dt<-sort(sample(nrow(RF),nrow(RF)*.8))
train<-RF[dt,]
test<-RF[-dt,]
library(randomForest)
model3 <- randomForest(CPC~., train, ntree=50)
varImpPlot(model3)
library(rpart)
library(rpart.plot)
library(caret)
pred2 <- predict(model3, test)                   
confusionMatrix(pred2, test$CPC)
```
```{r}
str(train)
model <- rpart(CPC~.,data=train)
prp(model, type=2, extra=1, col="green")

library(tree)

model1<-tree(CPC~.,train)
plot(model1)
text(model1,pretty=0)
```

```{r}
library(Boruta)

# Decide if a variable is important or not using Boruta

boruta_output <- Boruta(CPC ~ .,  doTrace=2,data=New_data)
```

```{r}
boruta_signif <- names(boruta_output$finalDecision[boruta_output$finalDecision %in% c("Confirmed", "Tentative")])
plot(boruta_output, cex.axis=.7, las=2, xlab="", main="Variable Importance")
```

