train_tot = fread(file.path(config$input,"ech_apprentissage.csv"))
test = fread(file.path(config$input,"ech_test.csv"))

col_to_factor = c("profession","energie_veh","var14","codepostal","var8","var16","marque","var7","var6")

train_tot[,eval(col_to_factor):=lapply(.SD,as.factor),.SDcols=col_to_factor]
test[,eval(col_to_factor):=lapply(.SD,as.factor),.SDcols=col_to_factor]

ID = train[,id]
y_train = train[,prime_tot_ttc]
# train[,id:=NULL]
# test[,id:=NULL]

dim(apprentissage)
head(apprentissage)

plot(x = apprentissage$annee_permis,
     y = apprentissage$prime_tot_ttc)

y_annee_permis = ggplot(apprentissage, aes(x=xvar, y=yvar)) +
  geom_point(shape=1) +    # Use hollow circles
  geom_smooth()

for(variable in names(apprentissage)){
  cat(variable,":",nrow(apprentissage[get(variable)=="NR"]),"\n")
}

for(variable in names(apprentissage)){
  if(nrow(apprentissage[get(variable)=="NR"])>0){
    apprentissage[get(variable)=="NR",variable,with=FALSE]=NA
  }
}

Xplore_profession = train[,mean(prime_tot_ttc),by=profession]
setorder(Xplore_profession,V1)
Xplore_profession$profession = factor(Xplore_profession$profession, levels = Xplore_profession$profession[order(Xplore_profession$V1)])

G_profession = ggplot(data = Xplore_profession,aes(x=profession,y=V1,fill=profession)) +
  geom_bar(stat="identity", position=position_dodge(), colour="black")

G_profession

# Ajout dimanche
ggplot(train_tot, aes(x=puis_fiscale, fill=prime_tot_ttc>1200)) + geom_density(alpha=.3)
ggplot(train_tot, aes(x=annee_permis, fill=prime_tot_ttc>1200)) + geom_density(alpha=.3)

ggplot(train_tot, aes(x=annee_permis, y=prime_tot_ttc, color=prime_tot_ttc>1200)) + geom_point(shape=1)

