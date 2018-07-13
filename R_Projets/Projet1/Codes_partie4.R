mu<-0
sigma<-0.25
y<-4
n<-5

# Ecrire la fonction logarithmique de f(¦È).
logf<-function(theta){y*theta-n*log(1+exp(theta))-(theta-mu)^2/(2*sigma^2)}

# Etape 1, gerer T = 10*10000 variables aleatoires iid ¦È ~ G, prenons la loi a priori comme densite
# instrumentale, on a donc G=N(0,0.25^2).
T<-10*10000 # selon la critere de la methode ERI
set.seed(123)
theta.a<-rnorm(T,mean=mu,sd=sigma)

# Etape 2, calculer w_(¦È) = f(¦È)/g(¦È) et puis w(¦È) = w_(¦È)/somme(w_(¦È)).
poidsnn.a<-logf(theta.a)-dnorm(theta.a,mean=mu,sd=sigma,log=T)
poids.a<-exp(poidsnn.a)/sum(exp(poidsnn.a))

# Etape 3, echantillonner sous la ponderation w(¦È) avec remise 10000 realisations p(¦È|y).
theta.post.a<-sample(theta.a,size=10000,prob=poids.a,replace=T)

# Comme p > 0.5 => ¦È = log(p/(1-p)) = log(1/(1-p)-1) > log(1/0.5-1) = 0 => P(p>0.5) = P(¦È>0), ainsi calculer P(¦È>0) de cet # echantillon pour estimer la probabilite que la piece soit non equilibree et favorisant le cote ?? face ??.
p.a<-sum(theta.post.a>0)/10000
p.a

# b)
# Etape 1, gerer T = 10*10000 variables aleatoires iid ¦È ~ G, on a donc G=N(0.087, 0.058) 
# car par l'approximation normale en TP4, p(¦È|y)¡ÖN(0.087, 0.058)
T<-10*10000 # selon le critere de la methode ERI
set.seed(123)
theta.b<-rnorm(T,mean=.087,sd=sqrt(.058))

# Etape 2, calculer w_(¦È) = f(¦È)/g(¦È) et puis w(¦È) = w_(¦È)/somme(w_(¦È)).
poidsnn.b<-logf(theta.b)-dnorm(theta.b,mean=.087,sd=sqrt(.058),log=T)
poids.b<-exp(poidsnn.b)/sum(exp(poidsnn.b))

# Etape 3, echantillonner sous la ponderation w(¦È) avec remise 10000 realisations p(¦È|y).
theta.post.b<-sample(theta.b,size=10000,prob=poids.b,replace=T)

# Calculer p de cet echantillon
p.b<-sum(theta.post.b>0)/10000
p.b

# Comparer la distribution des poids sous les deux choix de densite instrumentale
# Statistiques sur les poids relatifs
summary(poids.a/(1/T))
summary(poids.b/(1/T))

quantile(poids.a/(1/T),prob=seq(0.99,0.999,0.001))
quantile(poids.b/(1/T),prob=seq(0.99,0.999,0.001))

hist(log(poids.a/(1/T)),main="Histogramme des poids relatif ¨¤ 1/100000 (echelle log)
     en utilisant N(0,0.25^2) comme densit¨¦ instrumentale")
hist(log(poids.b/(1/T)),main="Histogramme des poids relatif ¨¤ 1/100000 (echelle log)
     en utilisant N(0.087, 0.058) comme densit¨¦ instrumentale")
# c)
# Etape 1, on cherche a estimer P(¦È>0)=E[I(¦È>0)], on pose donc h(x)=I(x>0)
hx<-function(x){
  if (x>0) h<-1
  else h<-0
  return(h)
}

# Etape 2, Determiner f(x)/g(x) et h(x)f(x)/g(x), ou G=N(0.087, 0.058) la loi instrumentale.
set.seed(123)
fw<-function(x){
  logfonc<-logf(x)-dnorm(x,mean=.087,sd=sqrt(.058),log=T)
  return(exp(logfonc))
}

fnorm<-function(x){
  logfonc<-log(hx(x))+logf(x)-dnorm(x,mean=0.087,sd=sqrt(0.058),log=T)
  return(exp(logfonc))
}

# Etape 3, generer un echantillon de taille 10000 de la loi instrumentale G et calculer l'estimateur de ¦È.
xnorm<-rnorm(10000,mean=.087,sd=sqrt(.058))
mx<-as.matrix(xnorm,ncol=1)
finorm<-apply(mx,1,fnorm)
w<-apply(mnorm,1,fw)

# L¡¯estimateur de ¦È
enorm<-sum(finorm)/sum(w)
enorm

sd<-sqrt(sum(((apply(mnorm,1,hx)-enorm)*w)^2))/sum(w)
sd
