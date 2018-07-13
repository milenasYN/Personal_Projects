# probleme 1
n <- 10000
alpha <- 4
beta <- 2
meanZ <- alpha*beta/(alpha-1)
varZ <- alpha*beta^2/((alpha-1)^2*(alpha-2))
# pour calculer les valeurs théoriques, on a Z = Y + beta ~ Pareto(alpha, beta), 
# E[Z] = E[Y + beta] = E[Y] + beta => E[Y] = E[Z] - beta, var[Y] = Var[Z]
meanY <- meanZ - beta
varY <- varZ
# Estimier E[Y] par E[Y|sigma], on a E[Y] = E[E[Y|sigma]], et E[Y|sigma] = y*f(y|sigma),
# on a donc besoin de estimer lamda, on a sigma ~ Gamma(alpha,beta), 
meanBar <- rep(0,n)

lamda <- rgamma(n,alpha,beta)
meanBar <- mean(1/lamda)
varBar <- 2*mean(1/lamda^2) - (mean(1/lamda))^2