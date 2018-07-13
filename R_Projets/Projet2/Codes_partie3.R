# Question 3.1
status <- function(x,y){
  if (x < 0 | y < 0) res <- "impossible"
  else{
    if (x < 8){
      if (y <= 8) res <- "non fini"
      else if (y == 9) res <- "joueur 2 gagne"
      else res <- "impossible"
    }else if (x == 8){
      if (y <= 9) res <- "non fini"
      else if (y == 10) res <- "joueur 2 gagne"
      else res <- "impossible"
    }else if (x == 9){
      if (y < 8) res <- "joueur 1 gagne"
      else if (y <= 10) res <- "non fini"
      else if (y == 11 ) res <- "joueur 2 gagne"
      else res <- "impossible"
    }else{
      if (y < x-2) res <- "impossible"
      else if (y == x-2) res <- "joueur 1 gagne"
      else if (x-2 < y & y < x+2) res <- "non fini"
      else if (y == x+2) res <- "joueur 2 gagne"
      else res <- "impossible"
    }
  }
  return(res)
}

status.test <- function(s.ftn) {
  x.vec <- (-1):12
  y.vec <- (-1):12
  plot(x.vec, y.vec, type = "n", xlab = "x", ylab = "y",las=1)
  for (x in x.vec) {
    for (y in y.vec) {
      s <- s.ftn(x, y)
      if (s == "impossible") text(x, y, "X", col = "red")
      else if (s == "non fini") text(x, y, "?", col = "blue")
      else if (s == "joueur 1 gagne") text(x, y, "1", col = "green")
      else if (s == "joueur 2 gagne") text(x, y, "2", col = "green")
    }
  }
  return(invisible(NULL))
}

status.test(status)

# Question 3.2 Simulation d'une partie
# Simuler d'abord un echange
play_point <- function(state, a, b){
  # Si le joueur 1 sert
  if (state[3] == 1){
    # Simuler le resultat d'un echange qui suit une loi de bernoulli
    res <- rbinom(1,size=1,prob=a)
    # Mettre a jour le vecteur state
    # Si le joueur 1 perd
    if (res == 0){
      state[3] = 2
    }else{  # Si le joueur 1 gagne
      state[1] = state[1] + 1
    }
  }else{  # Si le joueur 2 sert
    # Simuler le resultat d'un echange qui suit une loi de bernoulli
    res <- rbinom(1,size=1,prob=1-b)
    # Mettre a jour le vecteur state
    # Si le joueur 2 perd
    if (res == 0){
      state[3] = 1
    }else{  # Si le joueur 2 gagne
      state[2] = state[2] + 1
    }
  }
  return(state)
}

# Simuler une partie
play_game <- function(a, b) {
  state <- c(0, 0, 1)
  while (status(state[1], state[2]) == "non fini") {
    # Mettre a jour le vecteur state quand le jeu n'est pas termine
    state <- play_point(state, a, b)
  }
  if (status(state[1], state[2]) == "joueur 1 gagne") {
    return(TRUE)
  } else {
    return(FALSE)
  }
}
# Ecrire un algorithme pour calculer la probabilite estime p_hat
p_est <- function(n, a, b){
  resultat <- NULL
  for (i in 1:n){
    resultat[i] <- play_game(a,b)
  }
  p <- sum(resultat=="TRUE")/n 
  return(p)
}

set.seed(33)
a <- 0.55
b <- 0.45
n <- 2^seq(1, 12, by=1)

p_hat <- rep(0,length(n))
for(i in 1:length(n)){
  p_hat[i] <- p_est(n[i], a, b)
}

plot(log(n)/log(2),p_hat,type="o")
lines(log(n)/log(2),rep(0.5,length(n)),lty=2,col=2)

p_est(10000, a, b)

# Question 3.3
# Quand sd=0.01, n=p*(1-p)/0.01^2, p*(1-p) est maximum quand p=0.5
(n <- 0.5*(1-0.5)/0.01^2)
prob <- seq(0.1,0.9,0.1)
lp <- length(prob)
p_ab <- matrix(rep(0,lp^2),ncol = lp)
dimnames(p_ab) <- list(a=prob,b=prob)
set.seed(33)
for (i in 1:lp){
  for (j in 1:lp){
    p_ab[i,j] <- round(p_est(n,prob[i],prob[j]),2)
  }
}
p_ab
library(xtable)
table_p<-xtable(p_ab)
print.xtable(table_p, type="latex")

# Question 3.4
play_game <- function(a, b) {
  state <- c(0, 0, 1)
  nb <- 0
  while (status(state[1], state[2]) == "non fini") {
    # Mettre a jour le vecteur stats quand le jeu n'est pas termine
    state <- play_point(state, a, b)
    nb <- nb + 1
  }
  return(c(nb,state[1],state[2]))
}
nb <- matrix(rep(0,lp^2),ncol = lp)
dimnames(nb) <- list(a=prob,b=prob)
nb_est <- function(n, a, b){
  resultat <- 0
  for (i in 1:n){
    resultat[i] <- play_game(a,b)[1]
  }
  p <- mean(resultat)
  return(p)
}
set.seed(33)
for (i in 1:lp){
  for (j in 1:lp){
    nb[i,j] <- round(nb_est(n,prob[i],prob[j]),2)
  }
}
nb
library(xtable)
table_nb<-xtable(nb)
print.xtable(table_nb, type="latex")

# Question 4 Score des joueurs
Mscore <- function(n,a,b){
  score <- seq(0,12,1)
  lsc <- length(score)
  Mscore <- matrix(rep(0,lsc^2),ncol = lsc)
  dimnames(Mscore) <- list(x=score,y=score)
  for (i in 1:n){
    res <- play_game(a,b)
    Mscore[res[2]+1,res[3]+1] <- Mscore[res[2]+1,res[3]+1] + 1
  }
  return(Mscore)
}
a <- 0.9
b <- 0.5
n <- 2500
set.seed(33)
Mscore <- Mscore(n,a,b)

library(xtable)
table_score<-xtable(Mscore,digits=rep(0,14))
print.xtable(table_score, type="latex")

# Question 5
# Recrire l'algorithme de play_game pour estimer a et b dans chaque partie.
play_game <- function(a, b) {
  state <- c(0, 0, 1)
  # nb1 represente le nombre d'echange servi par le joueur 1
  nb1 <- 0
  # nb1_win_1 represente le nombre d'echange gagne par le joueur 1 quand il sert
  nb1_win_1 <- 0
  # nb1_win_2 represente le nombre d'echange gagne par le joueur 1 quand le joueur 2 sert
  nb1_win_2 <- 0
  # nb represente le monbre total d'echange
  nb <- 0
  while (status(state[1], state[2]) == "non fini") {   
    nb <- nb + 1
    # Garder le status precedent dans un vecteur state_prec
    state_prec <- state
    # Mettre a jour le vecteur state quand le jeu n'est pas termine
    state <- play_point(state, a, b)
    # Calculer le nombre d'echange gagne par le joueur 1
    if (state[3] == 1){
      # Calculer le nombre d'echange servi par le joueur 1
      nb1 <- nb1 + 1
      if (state_prec[3] == 1) nb1_win_1 <- nb1_win_1 + 1
      else nb1_win_2 <- nb1_win_2 + 1
    }
  }
  return(c(nb1_win_1/nb1, nb1_win_2/(nb-nb1)))
}

ab_est <- function(n,a,b){ 
  ab <- NULL
  for (i in 1:n){
    ab <- rbind(ab,play_game(a,b))
  }
  return(apply(ab,2,mean,na.rm=TRUE))
}

n <- 2500
a <- 0.1
b <- 0.9
ab_est(n,a,b)

a <- c(0.1,0.1,0.5,0.9,0.9)
b <- c(0.1,0.9,0.5,0.1,0.9)
set.seed(33)
ab_hat <- NULL
for (i in 1:5) ab_hat<-rbind(ab_hat,ab_est(n,a[i],b[i]))
ab_hat

# Calculer l'intervalle de confiance
set.seed(33)
# La variance
var_ab <- function(n,a,b){ 
  ab <- NULL
  for (i in 1:n){
    ab <- rbind(ab,play_game(a,b))
  }
  return(apply(ab,2,var,na.rm=TRUE))
}
var_ab_hat <- var_ab(n,a,b)
# Les intervalles inferieurs et superieurs
(int_inf <- ab_hat-sqrt(var_ab_hat))
(int_sup <- ab_hat+sqrt(var_ab_hat))
# Intervalle de confiance de a pour chaque couple de (a,b)
(int_a <- cbind(int_inf[,1],int_sup[,1]))
# Intervalle de confiance de b pour chaque couple de (a,b)
(int_b <- cbind(int_inf[,2],int_sup[,2]))

# Evaluer l'estimateur en fonction de n
axe_x<-seq(100,5000,500)
lx<-length(axe_x)
estimateur <- NULL
set.seed(33)
for (i in 1:lx){
  estimateur <- rbind(estimateur,ab_est(axe_x[i],a,b))
}
plot(axe_x,estimateur[,1],xlab="n",ylab="a_bar",type='l',main="Convergence de a_bar en fonction de n")
lines(axe_x,rep(0.105,lx),lty=7,col=2)
