soumission_modele = function(modele,test,name){
  
  if(class(modele)=="H2ORegressionModel"){
    predict_test = h2o.predict(modele,test)
    predict_test = as.data.table(predict_test)
    predict_test[,ID:=seq_len(nrow(predict_test))+300000]
    setnames(predict_test,"predict","COTIS")
    setcolorder(predict_test,c("ID","COTIS"))
    predict_test[,COTIS:=round(COTIS)]
    }
  
  write.csv2(predict_test,
             file = file.path(config$output,paste0(format(Sys.time(),"%Y%m%d_%H%M%S"),"_",name,".csv")),
             row.names=FALSE,
             quote=FALSE)
  
}

