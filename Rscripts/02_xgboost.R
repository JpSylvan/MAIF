library(xgboost)

gb = xgboost(data=apprentissage,label=apprentissage$prime_tot_ttc)

bst <- xgboost(data = X_app, label = Y_app, max.depth = 2,
               eta = 1, nthread = 2, nround = 2,objective = "binary:logistic")
pred <- predict(bst, test$data)