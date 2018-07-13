donnee<-file.choose()
Auto<-read.table(file=donnee,header=T)
# a)
mpg<-Auto$mpg
horsepower<-Auto$horsepower
reg<-lm(mpg~horsepower)
summary(reg)
coef(reg)
confint(reg)

# b)
# 1)
plot(horsepower,mpg,main="mpg en fonction de horsepower")
abline(reg,lty=2,col=2,lwd=2)
# 2)
plot(predict(reg),mpg,xlab="R¨¦ponses observ¨¦es",ylab="R¨¦ponses ajust¨¦es",
     main="R¨¦ponses observ¨¦es versus R¨¦ponses ajust¨¦es")
abline(a=0,b=1,lty=2,col=2,lwd=2)
# 3)
plot(residuals(reg),predict(reg),xlab="R¨¦sidus",ylab="R¨¦ponses observ¨¦es",
     main="R¨¦ponses observ¨¦es versus r¨¦sidus")
abline(v=0,lty=2,col=2,lwd=2)
# c)
# Ecrire l'estimateur
fonctheta<-function(data,vecteur){
  coef(lm(mpg~horsepower,data=Auto,subset=vecteur))
}

# fonction bootstrap
bootstrap<-function(donnee,B){
  # Creer une matrice nulles de 2 colonnes et B lignes pour stocker nos deux estimateurs.
  theta.B<-matrix(rep(0,2*B),ncol=2)
  n<-length(donnee$mpg)  
  # Generer n echantillons de taille n avec remplacement de Fe
  # Pour chaque echantillon on calcule notre estimateur
  for(i in 1:B){
    ind<-sample(1:n,n,replace=T)
    theta.B[i,]<-fonctheta(donnee,ind)
  }
  list(theta.hat=fonctheta(donnee,1:n),moy.theta=c(mean(theta.B[,1]), mean(theta.B[,2])), 
       SE=c(sqrt(var(theta.B[,1])), sqrt(var(theta.B[,2]))),
       biais=c(mean(theta.B[,1])-fonctheta(donnee,1:n)[1], mean(theta.B[,2])-
                 fonctheta(donnee,1:n)[2] ),thetas= matrix(theta.B,ncol=2))
}

set.seed(666)
B<-1999
boottheta<-bootstrap(Auto,B)
boottheta


# d
# Histogramme pour les estimateurs bootstrap de beta0
hist(boottheta$thetas[,1])

# Ic1
boottheta$theta.hat[1]-qnorm(0.975)*boottheta$SE[1]
boottheta$theta.hat[1]+qnorm(0.975)*boottheta$SE[1]

# IC2
2*boottheta$theta.hat[1]-quantile(boottheta$thetas[,1],prob=0.975,type=2)
2*boottheta$theta.hat[1]-quantile(boottheta$thetas[,1],prob=0.025,type=2)

# IC3
quantile(boottheta$thetas[,1],prob=0.025,type=2)
quantile(boottheta$thetas[,1],prob=0.975,type=2)

# Histogramme pour les estimateurs bootstrap de beta1
hist(boottheta$thetas[,2])

# Ic1
boottheta$theta.hat[2]-qnorm(0.975)*boottheta$SE.beta1
boottheta$theta.hat[2]+qnorm(0.975)*boottheta$SE.beta1

# IC2
2*boottheta$theta.hat[2]-quantile(boottheta$thetas[,2],prob=0.975,type=2)
2*boottheta$theta.hat[2]-quantile(boottheta$thetas[,2],prob=0.025,type=2)

# IC3
quantile(boottheta$thetas[,2],prob=0.025,type=2)
quantile(boottheta$thetas[,2],prob=0.975,type=2)
