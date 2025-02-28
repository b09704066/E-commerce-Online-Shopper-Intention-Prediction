library(MASS)
boston_data <-data(Boston)
sample_index <- sample(nrow(Boston), nrow(Boston) * 0.90)
boston_train <- Boston[sample_index, ]
boston_test <- Boston[-sample_index, ]

library(rpart)
library(rpart.plot)

boston_rpart <- rpart(formula = medv ~ ., data = boston_train)
boston_rpart
#digits: The number of significant digits in displayed numbers
#extra: 1 -> Display the number of observations that fall in the node, different value represent different information
prp(boston_rpart, digits = 4, extra = 1)
?prp() #prp help file 

#prediction
#in-sample
boston_train_pred_tree = predict(boston_rpart)
#out-of-sample
boston_test_pred_tree = predict(boston_rpart, boston_test)
mean((boston_test_pred_tree - boston_test$medv)^2)

#Pruning
boston_largetree1 <- rpart(formula = medv ~ ., data = boston_train, cp = 0.001)
prp(boston_largetree1)
printcp(boston_largetree1)
mean((predict(boston_largetree1) - boston_train$medv)^2)

plotcp(boston_largetree1) #find out appropriate cp (complexity parameter)

boston_largetree2 <- rpart(formula = medv ~ ., data = boston_train, cp = 0.0089)
prp(boston_largetree2)
mean((predict(boston_largetree2) - boston_train$medv)^2) 
#optimal model mean square error higher since overfitting reduced for in-sample data
