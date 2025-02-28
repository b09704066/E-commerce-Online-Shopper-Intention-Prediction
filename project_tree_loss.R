data = read.csv('/Users/nina/Downloads/online_shoppers_intention.csv')

data$Revenue <- data$Revenue * 1

#EDA

#Classification Tree
library(rpart.plot)
# convert categorical data to factor
data$Weekend<- as.factor(data$Weekend)
data$TrafficType <- as.factor(data$TrafficType)
data$OperatingSystems <- as.factor(data$OperatingSystems)
data$Region <- as.factor(data$Region)
data$Browser <- as.factor(data$Browser)
data$Month <- as.factor(data$Month)
data$VisitorType <- as.factor(data$VisitorType)
#data$Revenue <- as.factor(data$Revenue)

#Train-test split
index <- sample(nrow(data),nrow(data)*0.80)
train = data[index,]
test = data[-index,]

#Fit model
##loss matrix 9:1
data_rpart <- rpart(formula = Revenue ~ . , data = train, method ="class",
                      parms = list(loss=matrix(c(0,6,1,0), nrow = 2)))
##print tree
data_rpart
prp(data_rpart, extra = 1)

#prediction (in-sample)
##asymmetric
train.pred.tree<- predict(data_rpart, train, type="class")
table(train$Revenue, train.pred.tree, dnn=c("Truth","Pred"))

#prediction (out-of-sample)
test.pred.tree<- predict(data_rpart, test, type="class")
table(test$Revenue, test.pred.tree, dnn=c("Truth","Pred"))

#Pruning
largetree1 <- rpart(formula = Revenue ~ ., data = train, method ="class",
                    cp = 0.001,  parms = list(loss=matrix(c(0,6,1,0), nrow = 2)))
prp(largetree1)
plotcp(largetree1) #find out appropriate cp (complexity parameter)
train.pred.tree1<- predict(largetree1, train, type="class")
table(train$Revenue, train.pred.tree1, dnn=c("Truth","Pred"))

largetree2 <- rpart(formula = Revenue ~ ., data = train, method ="class",
                    cp = 0.0087,  parms = list(loss=matrix(c(0,6,1,0), nrow = 2)))
prp(largetree2)
train.pred.tree2<- predict(largetree2, train, type="class")
table(train$Revenue, train.pred.tree2, dnn=c("Truth","Pred"))


#Cost function
cost <- function(r, phat){
  weight1 <- 6
  weight0 <- 1
  pcut <- weight0/(weight1+weight0)
  c1 <- (r==1)&(phat<pcut) #logical vector - true if actual 1 but predict 0
  c0 <-(r==0)&(phat>pcut) #logical vector - true if actual 0 but predict 1
  return(mean(weight1*c1+weight0*c0))
}
##calculate cost
cost(train$Revenue, predict(data_rpart, train, type="prob"))
cost(test$Revenue, predict(data_rpart, test, type="prob"))


#Probability of getting 1
test_prob_rpart = predict(data_rpart, test, type="prob")

library(ROCR)
pred = prediction(test_prob_rpart[,2], test$Revenue)
perf = performance(pred, "tpr", "fpr")
plot(perf, colorize=TRUE)
#AUC
slot(performance(pred, "auc"), "y.values")[[1]]

#cut-off
test_pred_rpart = as.numeric(test_prob_rpart[,2] > 1/(6+1))
table(test$Revenue, test_pred_rpart, dnn=c("Truth","Predicted"))
