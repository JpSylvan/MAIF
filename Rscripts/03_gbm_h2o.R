h2o.init(nthreads = -1)

set.seed(1)
data_partition = sample(nrow(train),nrow(train)/10)
validation = train[data_partition]
train = train[-data_partition]

train.h2o = as.h2o(train)
validation.h2o = as.h2o(validation)

test.h2o = as.h2o(test)
  
# tweedie sans tuning ----
gbm_h2o = h2o.gbm(training_frame = train.h2o,
                  x = setdiff(names(train.h2o),"prime_tot_ttc"),
                  y = "prime_tot_ttc",
                  distribution = "tweedie")

predict_validation_gbm = h2o.predict(object = gbm_h2o,
                                 newdata = validation.h2o)

predict_validation_gbm = as.vector(predict_validation_gbm)

mape(validation$prime_tot_ttc,predict_validation_gbm)

soumission_modele(gbm_h2o,test.h2o,"gbm_tweedie_simple")

# gamma avec tuning ----
gbm_h2o = h2o.gbm(training_frame = train.h2o,
                  x = setdiff(names(train.h2o),"prime_tot_ttc"),
                  y = "prime_tot_ttc",
                  distribution = "gamma")

predict_validation_gbm = h2o.predict(object = gbm_h2o,
                                     newdata = validation.h2o)

predict_validation_gbm = as.vector(predict_validation_gbm)

mape(validation$prime_tot_ttc,predict_validation_gbm)

soumission_modele(gbm_h2o,test.h2o,"gbm_gamma_simple")


# gamma avec tuning ----
gbm_h2o = h2o.gbm(training_frame = train.h2o,
                  x = setdiff(names(train.h2o),"prime_tot_ttc"),
                  y = "prime_tot_ttc",
                  distribution = "gamma",
                  ntrees = 100,
                  max_depth = 10,
                  nbins = 25)

predict_validation_gbm = h2o.predict(object = gbm_h2o,
                                     newdata = validation.h2o)

predict_validation_gbm = as.vector(predict_validation_gbm)

mape(validation$prime_tot_ttc,predict_validation_gbm)
# 0.08406497
soumission_modele(gbm_h2o,test.h2o,"gbm_gamma_tune1")

# Gamma avec tuning lancé sur tout l'apprentissage

train_tot.h2o = as.h2o(train_tot)

gbm_h2o = h2o.gbm(training_frame = train_tot.h2o,
                  x = setdiff(names(train_tot.h2o),"prime_tot_ttc"),
                  y = "prime_tot_ttc",
                  distribution = "gamma",
                  ntrees = 100,
                  max_depth = 10,
                  nbins = 25)

soumission_modele(gbm_h2o,test.h2o,"gbm_gamma_tune1")


# gamma avec tuning ----
gbm_h2o = h2o.gbm(training_frame = train.h2o,
                  x = setdiff(names(train.h2o),"prime_tot_ttc"),
                  y = "prime_tot_ttc",
                  distribution = "gamma",
                  ntrees = 100,
                  max_depth = 25,
                  nbins = 25)

predict_validation_gbm = h2o.predict(object = gbm_h2o,
                                     newdata = validation.h2o)

predict_validation_gbm = as.vector(predict_validation_gbm)

mape(validation$prime_tot_ttc,predict_validation_gbm)

soumission_modele(gbm_h2o,test.h2o,"gbm_gamma_tune1")


# gbm sur train filtre ----
train_filtre_codepostal.h2o = as.h2o(train_filtre_codepostal)

gbm_h2o = h2o.gbm(training_frame = train_filtre_codepostal.h2o,
                  x = setdiff(names(train_filtre_codepostal.h2o),"prime_tot_ttc"),
                  y = "prime_tot_ttc",
                  distribution = "gamma",
                  ntrees = 100,
                  max_depth = 50,
                  nbins = 25)

predict_validation_gbm = h2o.predict(object = gbm_h2o,
                                     newdata = validation.h2o)

predict_validation_gbm = as.vector(predict_validation_gbm)

mape(validation$prime_tot_ttc,predict_validation_gbm)
# 0.08406497
soumission_modele(gbm_h2o,test.h2o,"gbm_gamma_100_97")
