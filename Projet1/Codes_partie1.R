hx <- function(x){exp(-x)}
integrate(hx,2,4)
I <- .1170196
n <- 10000
set.seed(1234567)
u <- runif(n,2,4)
#delta est équivalent à l'espérence de h(x), on estime donc l'espérence de h(x)
#en générant 
meanHbar <- mean(hx(u))
sd <- sqrt(var(hx(u)))
#Internalle de confiance
meanHbar-1.96*sd
meanHbar+1.96*sd