h2o.init(nthreads = -1)

train.h2o = as.h2o(train)
test.h2o = as.h2o(test)

set.seed(1)
data_partition = sample(nrow(train),nrow(train)/10)
validation = train[data_partition]
train = train[-data_partition]
  
train.h2o = as.h2o(train)
validation.h2o = as.h2o(validation)

glm_h2o = h2o.glm(training_frame = train.h2o,
                  x = setdiff(names(train.h2o),"prime_tot_ttc"),
                  y = "prime_tot_ttc",
                  family = "tweedie")

predict_validation = h2o.predict(object = glm_h2o,
                                 newdata = validation.h2o)

predict_validation = as.vector(predict_validation)

mape(validation$prime_tot_ttc,predict_validation)
