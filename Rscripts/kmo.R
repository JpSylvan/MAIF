cor(train_tot[,setdiff(names(train_tot),"id"),with=FALSE])

cor_matrix = cor(train_tot[,paste0("var",c(2:5,9:13,15,17:22)),with=FALSE])

KMO(cor_matrix)
