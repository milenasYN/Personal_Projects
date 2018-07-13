theta<-function(p){log(p/(1-p))}

# La loi a priori de theta
mu<-0
sigma2<-0.0625
sigma<-sqrt(sigma2)
y<-4
n<-5
mLogf<-function(theta){-y*theta+n*log(1+exp(theta))+(theta-mu)^2/(2*sigma2)}
max<-nlm(mLogf,p=0,hessian=T)
max

# valeur maximale de f
thetaBar<-max$estimate
thetaBar
var<-max$hessian^(-1)
var


thetaRejet<-function(m){
  mu<-0
  sigma2<-0.0625
  sigma<-sqrt(sigma2)
  y<-4
  n<-5
  Y<-rep(0,m)
  for(i in 1:m){
    # etape 1, gerer X ~ g(x)
    x<-rnorm(1, mu, sigma)
    # etape 2, gerer U ~ U(0,1)
    u <-runif(1)
    
    # etape 3, si u <= p(x)/(cg(x)), posons Y = x, sinon on retourne a l'etape 1.
    c_<- exp(y*log(4))/(1+exp(log(4)))^n
    while(u > exp(y*x)/(c_*(1+exp(x))^n)){
      # etape 1, gerer X ~ g(x)
      x<-rnorm(1, mu, sigma)
      # etape 2, gerer U ~ U(0,1)
      u <-runif(1)
    }
    Y[i]<-x
  }
  return(Y)
}
m<-10000
Y<-thetaRejet(m)
p<-function(theta){exp(theta)/(1+exp(theta))}
p(mean(Y))
# d
thetaCondy<-rnorm(m,thetaBar,sqrt(var))
plot(thetaCondy,dnorm(thetaCondy))
lines(density(Y))
