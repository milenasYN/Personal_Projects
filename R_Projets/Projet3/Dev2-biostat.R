x <- c(2.09, 0.36, 0.6, 1.44, 0.92)
y <- c(55, 120, 280, 389, 1516)
v3 <- c(1,0,1,0,0)
library(survival)
donnee <- cbind(x,y,v3)
donnee.surv <- Surv(donnee[,2],donnee[,3]==1)
cox.donnee.surv <- coxph(donnee.surv~donnee[,1],init=1.3)
summary(cox.donnee.surv)
numr <- 2.09+0.6-sum(x*exp(x*1.3))/sum(exp(x*1.3))-sum(x[3:5]*exp(x[3:5]*1.3))/sum(exp(x[3:5]*1.3))
denom <- (sum(x^2*exp(x*1.3))*sum(exp(x*1.3))-sum(x*exp(x*1.3))^2)/sum(exp(x*1.3))^2+(sum(x[3:5]^2*exp(x[3:5]*1.3))*sum(exp(x[3:5]*1.3))-sum(x[3:5]*exp(x[3:5]*1.3))^2)/sum(exp(x[3:5]*1.3))^2
stat <- numr^2/denom
1-pchisq(stat,1)
xi1<-1-exp(1.189*2.09)/sum(exp(x*1.189))
xi1
xi2<-1-exp(1.189*0.6)/sum(exp(x[3:5]*1.189))
xi2
xi10<-xi1^exp(-1.189*2.09)
xi10
xi20<-xi2^exp(-1.189*0.6)
xi20
s1<-xi10^exp(1.189*2.09)
s1
# Partie 2
data <- read.table("C:/Users/ynmilenas/Documents/R/cirrhose-312-data.txt",header=T)
donnee2 <- data[c(2,3,4,11,19,20)]
data.surv <- Surv(donnee2[,1],donnee2[,2]==1)
cox.surv <- coxph(data.surv~donnee2[,3]+donnee2[,4]+donnee2[,5]+factor(donnee2[,6]))
# i)
summary(step(cox.surv))
# Regrouper les stades 1 & 2
donnee2[donnee2[,6]==1,][,6] <- rep(2,16)
cox.surv <- coxph(data.surv~donnee2[,3]+donnee2[,4]+donnee2[,5]+factor(donnee2[,6]))
summary(step(cox.surv))
# ii)
grTrait<-donnee2[donnee2[,3]==1,]
grNonTrait<-donnee2[donnee2[,3]==2,]
grTrait.surv<-Surv(grTrait[,1],grTrait[,2]==1)
grNonTrait.surv<-Surv(grNonTrait[,1],grNonTrait[,2]==1)
# Graphique pour les traités selon les stades
cox.surv.trait<-coxph(grTrait.surv~grTrait[,4]+grTrait[,5]+strata(grTrait[,6]))
plot(survfit(cox.surv.trait),lty=1:3,main="Graphique pour les traités selon les stades",xlab="Temps")
legend(20,0.5,c("stade 1&2","stade 3","stade 4"),lty=1:3)
# Graphique pour les non-traités selon les stades
cox.surv.nonTrait<-coxph(grNonTrait.surv~grNonTrait[,4]+grNonTrait[,5]+strata(grNonTrait[,6]))
plot(survfit(cox.surv.nonTrait),lty=1:3,main="Graphique survie pour les non-traités selon les stades",xlab="Temps")
legend(20,0.5,c("stade 1&2","stade 3","stade 4"),lty=1:3)
# iii)
# méthode b
data.nv<-cbind(donnee2[,1],donnee2[,2],donnee2[,4],donnee2[,5],factor(donnee2[,6]))
grStade12<-data.nv[data.nv[,5]==1,]
grStade3<-data.nv[data.nv[,5]==2,]
grStade4<-data.nv[data.nv[,5]==3,]
grStade12.surv<-Surv(grStade12[,1],grStade12[,2]==1)
grStade3.surv<-Surv(grStade3[,1],grStade3[,2]==1)
grStade4.surv<-Surv(grStade4[,1],grStade4[,2]==1)
fit.surv.stade12<-survfit(grStade12.surv~1)
fit.surv.stade3<-survfit(grStade3.surv~1)
fit.surv.stade4<-survfit(grStade4.surv~1)
x1<-log(fit.surv.stade12$time[fit.surv.stade12$n.event>0])
x2<-log(fit.surv.stade3$time[fit.surv.stade3$n.event>0])
x3<-log(fit.surv.stade4$time[fit.surv.stade4$n.event>0])
y1<-log(-log(fit.surv.stade12$surv[fit.surv.stade12$n.event>0]))
y2<-log(-log(fit.surv.stade3$surv[fit.surv.stade3$n.event>0]))
y3<-log(-log(fit.surv.stade4$surv[fit.surv.stade4$n.event>0]))
x<- sort(c(x1,x2,x3))
y<- sort(c(y1,y2,y3)) 
plot(x,y,type="n", main="Comparaison pour tester mod. Cox", xlab="Log-temps décès")
points(x1,y1,pch=19)
points(x2,y2,pch=22)
points(x3,y3,pch=25)

# méthode a
grStade12<-donnee2[donnee2[,6]==2,]
grStade3<-donnee2[donnee2[,6]==3,]
grStade4<-donnee2[donnee2[,6]==4,]
grStade12.surv<-Surv(grStade12[,1],grStade12[,2]==1)
grStade3.surv<-Surv(grStade3[,1],grStade3[,2]==1)
grStade4.surv<-Surv(grStade4[,1],grStade4[,2]==1)
# Graphique pour les stades 1&2 selon les traité-non traités
cox.surv.stade12<-coxph(grStade12.surv~grStade12[,4]+grStade12[,5])
plot(survfit(cox.surv.stade12),lty=1:2,main="Graphique pour les stades 1&2 selon les traité-non traités",xlab="Temps")
legend(20,0.5,c("traités","non-traités"),lty=1:2)
# Graphique pour les non-traités selon les stades
cox.surv.nonTrait<-coxph(grNonTrait.surv~grNonTrait[,4]+grNonTrait[,5]+strata(grNonTrait[,6]))
plot(survfit(cox.surv.nonTrait),lty=1:3,main="Graphique survie pour les non-traités selon les stades",xlab="Temps")
legend(20,0.5,c("stade 1&2","stade 3","stade 4"),lty=1:3)
# iv
# Rappel ajustement cox
cox.surv<-coxph(data.surv~donnee2[,4]+donnee2[,5]+factor(donnee2[,6]))
# On obtient les divers types de résidus:
res.m<- residuals(cox.surv,type="martingale") 
# on obtient les résidus Cox 
res.cox<- donnee2[,2]-res.m
# on retient résidus Cox prime 
res.cox.prime<- res.cox + (1-donnee2[,2]) 
# on calcule K-M avec résidus traités comme temps 
fit.res<- survfit(Surv(res.cox.prime,donnee2[,2]==1)~1)
plot(log(fit.res$time),log(-log(fit.res$surv)), xlab="Log-résidus", main="QQ-plot des
résidus") 
plot(fit.res$time,fit.res$surv, main="Fct survie résidus")
