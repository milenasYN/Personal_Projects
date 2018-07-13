data <- file.choose()
dataICU <- read.table(file=data,header=TRUE)
icu <- dataICU[,-c(1,16,17,18,19)]
# Définir la variable dépendante
sta <- icu[,1]
# quantitative
age <- icu[,2]

sex <- factor(icu[,3])
race <- factor(icu[,4])
ser <- factor(icu[,5])
can <- factor(icu[,6])
crn <- factor(icu[,7])
inf <- factor(icu[,8])
cpr <- factor(icu[,9])
# quantitative
sys <- icu[,10]
# quantitative
hra <- icu[,11]

pre <- factor(icu[,12])
typ <- factor(icu[,13])
fra <- factor(icu[,14])
cre <- factor(icu[,15])
loc <- factor(icu[,16])
# Définir les variables de x et y.
x <- cbind(age,sex,race,ser,can,crn,inf,cpr,sys,hra,pre,typ,fra,cre,loc)
y <- matrix(sta)
# i
# Modèle de regression complet.
glm1 <- glm(y~age+sex+race+ser+can+crn+inf+cpr+sys+hra+pre+typ+fra+cre,binomial) 
step(glm1)
# la formule proposée est y ~ x[, 1] + x[, 5] + x[, 8] + x[, 9] + x[, 12]
# c'est-a-dire, y~age+can+cpr+sys+typ
glm2 <- glm(y ~ age + can + cpr + sys + typ,binomial)
anova(glm2,test="Chisq")
glm3 <- glm(y ~ age + cpr + sys + typ + can,binomial)
anova(glm3,test="Chisq")

reg1 <- glm(y~age + cpr + sys + typ + can + loc,binomial)
anova(reg1,test="Chisq")
reg2 <- glm(y~age + cpr + sys + typ + loc + can,binomial)
anova(reg2,test="Chisq")
# interaction
reg3 <- glm(y~age+cpr+sys+typ+can+age:cpr+age:sys+age:typ+age:can,binomial)
anova(reg3,test="Chisq")
reg3 <- glm(y~age+cpr+sys+typ+can+age:sys,binomial)
anova(reg3,test="Chisq")
summary(reg3)

# ii
coef(reg3)
round(exp(coef(reg3)),4)

# iii
# Regrouper les donnees selon l'âge.
# icu <- cbind(y,x)
group <- split.data.frame(icu,icu[,1])
age0 <- group$`0`[,2]
age1 <- group$`1`[,2]
cat.age1 <- c(sum(age1==50),sum(age1==70),length(age1)-sum(age1==50)-sum(age1==70))
cat.age0 <- c(sum(age0==50),sum(age0==70),length(age0)-sum(age0==50)-sum(age0==70))
cat.age <- cbind(cat.age1,cat.age0)
cat.age.f <- data.frame(1:3,cat.age)
cat.age.f
cat.age.glm <- glm(cat.age~cat.age.f[,1],binomial)
predict(cat.age.glm)
predict(cat.age.glm,type="response")
# regrouper les données selons le type.
type0 <- group$`0`[,13]
type1 <- group$`1`[,13]
cat.type1 <- c(sum(type1==0),sum(type1==1))
cat.type0 <- c(sum(type0==0),sum(type0==1))
cat.type <- cbind(cat.type1,cat.type0)
cat.type.f <- data.frame(1:2,cat.type)
cat.type.f
cat.type.glm <- glm(cat.type~cat.type.f[,1],binomial)
predict(cat.type.glm)
# regrouper les données selons le sexe.
sexe0 <- group$`0`[,3]
sexe1 <- group$`1`[,3]
cat.sexe1 <- c(sum(sexe1==0),sum(sexe1==1))
cat.sexe0 <- c(sum(sexe0==0),sum(sexe0==1))
cat.sexe <- cbind(cat.sexe1,cat.sexe0)
cat.sexe.f <- data.frame(1:2,cat.sexe)
cat.sexe.f
cat.sexe.glm <- glm(cat.sexe~cat.sexe.f[,1],binomial)
predict(cat.sexe.glm)
predict(cat.sexe.glm,type="response")
# regrouper les données selons le sys.
sys0 <- group$`0`[,10]
sys1 <- group$`1`[,10]
cat.sys1 <- c(sum(sys1==120),sum(sys1==140),length(sys1)-sum(sys1==120)-sum(sys1==140))
cat.sys0 <- c(sum(sys0==120),sum(sys0==140),length(sys0)-sum(sys0==120)-sum(sys0==140))
cat.sys <- cbind(cat.sys1,cat.sys0)
cat.sys.f <- data.frame(1:3,cat.sys)
cat.sys.f
cat.sys.glm <- glm(cat.sys~cat.sys.f[,1],binomial)
predict(cat.sys.glm)
predict(cat.sys.glm,type="response")

# iv
library(ROCR)
pi <- fitted(reg3)
# courbe ROC
pred <- prediction(pi,icu[,1])
perf <- performance(pred,"tpr","fpr")
plot(perf)
# courbe residus
xi<-icu[,2]
devi<-residuals(reg3)
plot(xi,devi)

# v
# calcul par le tableau
sexe0 <- group$`0`[,3] # sexe des survivants
sexe1 <- group$`1`[,3] # sexe des morts
ser0 <- group$`0`[,5] # type de soins pour les survivants
ser1 <- group$`1`[,5] # type de soins pour les mots
cat.homme.ser1 <- c(sum(sexe1==0&ser1==1),sum(sexe1==0&ser1==0))
cat.homme.ser0 <- c(sum(sexe0==0&ser0==1),sum(sexe0==0&ser0==0))
# le tableau en stratifiant les hommes est :
cat.homme.ser <- cbind(cat.homme.ser1,cat.homme.ser0)
cat.homme.ser
w0 <- cat.homme.ser[1,1]*cat.homme.ser[2,2]/(cat.homme.ser[2,1]*cat.homme.ser[1,2])
w0
fisher.test(cat.homme.ser)
cat.femme.ser1 <- c(sum(sexe1==1&ser1==1),sum(sexe1==1&ser1==0))
cat.femme.ser0 <- c(sum(sexe0==1&ser0==1),sum(sexe0==1&ser0==0))
# le tableau en stratifiant les femmes est :
cat.femme.ser <- cbind(cat.femme.ser1,cat.femme.ser0)
cat.femme.ser
w1 <- cat.femme.ser[1,1]*cat.femme.ser[2,2]/(cat.femme.ser[2,1]*cat.femme.ser[1,2])
w1
fisher.test(cat.femme.ser)
# calclul par le modèle logistique
reg4 <- glm(y~ser*sex,binomial)
summary(reg4)
exp(coef(reg4))
mantelhaen.test(array(c(cat.homme.ser,cat.femme.ser),dim=c(2,2,2)))

# vi
Se_Sp <- function(p0){
  pi <- fitted(reg3)
  AB <- cbind(y,pi)
  # Séparer les données selon y
  grp <- split.data.frame(AB,AB[,1])
  A <- grp$`1`[,2]
  A_bar <- grp$`0`[,2]
  # Calculer la colonne de B et B_bar
  col.B <- c(length(A[A>p0]),length(A_bar[A_bar>p0]))
  col.Bbar <- c(length(A[A<p0|A==p0]),length(A_bar[A_bar<p0|A_bar==p0]))
  # Obtenir le tableau de type (1)
  cat.sta <- cbind(col.B,col.Bbar)
  dimnames(cat.sta) <- list(c("A","A_bar"),c("B","B_bar"))
  # Calculer Se et sp
  r1 <- rowSums(cat.sta)[1]
  r2 <- rowSums(cat.sta)[2]
  Se <- cat.sta[1,1]/r1
  Sp <- cat.sta[2,2]/r2
  Se_Sp <- c(Se,Sp)
  names(Se_Sp) <- c("Sensibilité","Spécificité")
  return(list(cat.sta,Se_Sp))
}
Se_Sp(0.1)
Se_Sp(0.25)
Se_Sp(0.5)
Se_Sp(0.75)
Se_Sp(0.95)
Se_Sp(0.2)
Se_Sp(0.15)
