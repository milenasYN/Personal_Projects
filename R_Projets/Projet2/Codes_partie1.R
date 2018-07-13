# Exercice 1
# 1.1
p.xyz <- function(x,y,z) z*(x-y)^2
conj.xyz <- NULL
for(i in 1:10){
  for(j in 1:10){
    for(k in 1:max(i,j)){
      conj.xyz <- rbind(conj.xyz,c(i,j,k,p.xyz(i,j,k)))
    }
  }	
}
head(conj.xyz)
(const <- 1/sum(conj.xyz[,4]))

# 1.2
p.xyz <- function(x,y,z) const*z*(x-y)^2
conj.xyz <- cbind(conj.xyz,conj.xyz[,4]*const)
colnames(conj.xyz) <- c("x","y","z","f","p")
head(conj.xyz) 
# Cov(X,Y)
EX <- sum(conj.xyz[,"x"]*conj.xyz[,"p"])
EY <- sum(conj.xyz[,"y"]*conj.xyz[,"p"])
EXY <- sum(conj.xyz[,"x"]*conj.xyz[,"y"]*conj.xyz[,"p"])
(covXY <- EXY-EX*EY)

# Cov(X,Z)
EZ <- sum(conj.xyz[,"z"]*conj.xyz[,"p"])
EXZ <- sum(conj.xyz[,"x"]*conj.xyz[,"z"]*conj.xyz[,"p"])
(covXZ <- EXZ-EX*EZ)

# Cov(Y,Z)
EYZ <- sum(conj.xyz[,"y"]*conj.xyz[,"z"]*conj.xyz[,"p"])
(covYZ <- EYZ-EY*EZ)

# 1.3
px <- NULL
for(i in 1:10){
  px <- c(px,sum(conj.xyz[conj.xyz[,"x"]==i,5]))
}
px

py <- NULL
for(i in 1:10){
  py <- c(py,sum(conj.xyz[conj.xyz[,"y"]==i,5]))
}
py

pz <- NULL
for(i in 1:10){
  pz <- c(pz,sum(conj.xyz[conj.xyz[,"z"]==i,5]))
}
pz

# 1.4
pz.3 <- pz[3]
pxyz3 <- NULL
pxyz3 <- conj.xyz[conj.xyz[,"z"]==3,]

# Enlever la colonne "z" et "f", et on obtient la table de la fonction de masse conjointe en sachant que z = 3.
pxyz3 <- pxyz3[,-c(3,4)]
head(pxyz3)

# La fonction de masse conditionnelle de (X,Y) si Z=3 est:
pxyCondz <- pxyz3[,"p"]/pz.3
pxyCondz

# La table de fonction de masse conditionnelle est donc:
condZ.xy <- pxyz3
condZ.xy[,"p"] <- condZ.xy[,"p"]/pz.3
condZ.xy

EXcondZ <- sum(condZ.xy[,"x"]*condZ.xy[,"p"])
EYcondZ <- sum(condZ.xy[,"y"]*condZ.xy[,"p"])
EXYcondZ <- sum(condZ.xy[,"x"]*condZ.xy[,"y"]*condZ.xy[,"p"])
(covXYcondZ <- EXYcondZ-EXcondZ*EYcondZ)
#############################################################################
##########################Fin de l'exercice 1################################

# Exercice 2
khi2cont <- function(data,nom.var,nom.x,nom.y,niveau.test){
	# Premier élément dans la liste retournée
  elem1 <- data
	totalC <- colSums(elem1)
	totalL <- rowSums(elem1)
  elem1 <- rbind(elem1,totalC)
  elem1 <- cbind(elem1,c(totalL,sum(totalL)))
	colnames(elem1) <- c(nom.y,"Total")
	rownames(elem1) <- c(nom.x,"Total")		
  
	# Deuxième élément dans la liste retournée
	proportion <- as.matrix(c(67,129,93)/289,ncol=1)
  T <- proportion%*%totalC
  elem2 <- round(T,2)
	totalC.T <- colSums(elem2)
	totalL.T <- rowSums(elem2)
  elem2 <- rbind(elem2,totalC.T)
  elem2 <- cbind(elem2,c(totalL.T,sum(totalL.T)))
	colnames(elem2) <- c(nom.y,"Total")
	rownames(elem2) <- c(nom.x,"Total")
  
  # Troisième élément dans la liste retournée
  khi2 <- (data-T)^2/T
  elem3 <- khi2
  colnames(elem3) <- nom.y
  rownames(elem3) <- nom.x
  
  # Quatrième élément dans la liste retournée
  khi2.obs <- sum(khi2)
  elem4 <- khi2.obs
  
  # Cinquième élément dans la liste retournée
  khi2.crit <- round(qchisq(0.95,4),4)
  elem5 <- khi2.crit
  
  # Sixième élément dans la liste retournée
  ddl <- (ncol(data)-1)*(nrow(data)-1)
  elem6.1 <- ddl
  elem6.2 <- niveau.test
  
  # Septième élément dans la liste retournée
  rejet <- khi2.obs > khi2.crit
  elem7 <- rejet
  
  # Huitième élément dans la liste retournée
  condLigne <- elem1/elem1[,4]
  rownames(condLigne)[4] <- c("Tous")
  elem8.1 <- round(condLigne,3)
  
  condCol <- t(t(elem1)/elem1[4,])
	colnames(condCol)[4] <- c("Tous")
  elem8.2 <- round(condCol,3)
  
  # Neuvième élément dans a liste retournée
  elem9 <- nom.var
  
  liste <- list(elem1,elem2,elem3,elem4,elem5,elem6.1,elem6.2,elem7,elem8.1,elem8.2,elem9)
  names(liste) <- c("obs","theo","contrib","khi2.obs","khi2.crit","dl","alpha","rejet","condiLigne","condiCol","var.names")
	return (liste)
}

O <- matrix (c(35 ,58 ,48 ,27 ,39 ,16 ,5 ,32 ,29) ,nrow=3) 
var.names <-  c("Nombre d'emp.", "Raison de fermeture") 
x.names <- c("5 - 9","10 - 49","50 et +")
y.names <-  c("Marché" ,"Finance" ,"Opération")
alpha <-  0.05 # niveau du test du khi-2
(result <-  khi2cont(O,var.names,x.names,y.names,alpha))
#############################################################################
##########################Fin de l'exercice 2################################

