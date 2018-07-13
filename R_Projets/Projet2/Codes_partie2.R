setClass ("diagdisp", representation(data="numeric", reperes="numeric", xlim="numeric",
n="integer", atypik="numeric", xname = "character"))

# Verifier cette classe
getClass("diagdisp")
isClass("diagdisp")

diagdisp <- function (X,nom ="X",plot = TRUE){
  diagdispObj<-new("diagdisp",data=X, xname=nom)
  
  # Calculer les quantiles
  M<-median(X)
  if(length(X)%%2==1){
    C1<-median(sort(X)[1:(trunc(length(X)/2)+1)])
    C2<-median(sort(X)[(trunc(length(X)/2)+1):length(X)])
  } else {
    C1<-median(sort(X)[1:(length(X)/2)])
    C2<-median(sort(X)[(length(X)/2+1):length(X)])
  }
  delta<-1.5*(C2-C1)
  L1<-C1-delta
  L2<-C2+delta
  B1<-min(X[X>=L1])
  B2<-max(X[X<=L2])
  
  # Mettre a jour les elements de la classe
  reperes<-c(B1,C1,M,C2,B2)
  names(reperes)<-c("B1","C1","M","C2","B2")
  diagdispObj@reperes<-reperes
  diagdispObj@xlim<-c(min(X),max(X))
  diagdispObj@n<-length(X)
  diagdispObj@atypik<-X[X<B1|X>B2]
  
  diagdispObj
}
Rendement <- c(0.1,0.7,0.8,1.0,1.4,1.8,2.0,2.0,2.3,2.4,2.6,2.8,2.9,3.0,3.1,3.2,
3.3,3.4,3.4,3.5,3.5,3.5,3.6,3.7,3.7,3.8,3.8,3.8,3.9,4.1,4.1,4.2,4.3,4.3,4.4,4.4,
4.5,4.6,4.6,4.7,4.7,4.8,4.8,4.8,4.9,4.9,5.2,5.3,5.5,5.5,5.6,5.7,6.5,6.7,6.9,6.9,
7.4,7.6,7.7,7.7,7.7,7.8,7.9,7.9,8.0,8.1,8.2,8.2,8.4,8.8,9.4,15.2,18.5,25.3)
(unexemp <- diagdisp(Rendement))
setValidity("diagdisp", function(object){
  is.wholenumber <- function(x,tol=.Machine$double.eps^0.5)  abs(x-round(x))<tol
  if(is.numeric(object@data)==FALSE){
    return("Les donnees ne sont pas numeriques")
  }else {
    if(length(object@data) == 0)
    return("Il n'y pas de donnees")
  }
  if( is.numeric(object@reperes)==FALSE){
    return("Les donnee de reperes ne sont pas numeriques")
  }else {
    if(length(object@reperes)!=5)
    return("Le repere n'est pas de longueur 5")
  }
  if(is.wholenumber(object@n)==FALSE){
    return("Le nombre des observations n'est pas un entier")
  }
  if(is.numeric(object@atypik)==FALSE){
    return("Les donnees atypik ne sont pas numeriques")
  }
  if(is.numeric(object@xlim)== FALSE){
    return("Les donnees xlim ne sont pas numeriques ")
  } else {
    if (length(object@xlim)!=2)
    return("xlim ne contient pas 2 elements")
  }
  if(is.character(object@xname)==FALSE){
    return("Le nom de la variable n'est pas de type character")
  }
  return(TRUE)
})

# Methode plot
setMethod ("plot",signature(x="diagdisp",y="missing"),definition=function(x,...) {
  xobj<-x
  B1<-xobj@reperes[1]
  C1<-xobj@reperes[2]
  M<-xobj@reperes[3]
  C2<-xobj@reperes[4]
  B2<-xobj@reperes[5]
  xlim<-xobj@xlim
  atypik<-xobj@atypik
  xname<-xobj@xname
  
  # Tracer la diagramme
  plot(xlim,c(0,3),type="n",yaxt="n",xlab=xname,ylab="",...)
  rect(c(C1,M),c(1,1),c(M,C2),c(2,2))
  lines(c(M,M),c(1,2),lwd=2)
  lines(c(B1,B1),c(1.25,1.75))
  lines(c(B2,B2),c(1.25,1.75))
  lines(c(B1,C1),c(1.5,1.5),col="blue",lty=3)
  lines(c(C2,B2),c(1.5,1.5),col="blue",lty=3)
  points(atypik,rep(1.5,length(atypik)),pch=19,cex=0.5)
})

# Methode show
setMethod("show",signature("diagdisp"),definition=function(object){
  xobj <- object
  reperes<-xobj@reperes
  var.name <- xobj@xname
  atypik <- xobj@atypik
  
  cat("Variable : ",var.name, "\n")
  print(reperes)
  cat("\n\nDonnees atypiques\n")
  print(atypik)
})
options ( OutDec =",")
Rendement <- c(0.1,0.7,0.8,1.0,1.4,1.8,2.0,2.0,2.3,2.4,2.6,2.8,2.9,3.0,3.1,3.2,3.3,
               3.4,3.4,3.5,3.5,3.5,3.6,3.7,3.7,3.8,3.8,3.8,3.9,4.1,4.1,4.2,4.3,4.3,4.4,4.4,4.5,4.6,
               4.6,4.7,4.7,4.8,4.8,4.8,4.9,4.9,5.2,5.3,5.5,5.5,5.6,5.7,6.5,6.7,6.9,6.9,7.4,7.6,7.7,
               7.7,7.7,7.8,7.9,7.9,8.0,8.1,8.2,8.2,8.4,8.8,9.4,15.2,18.5,25.3)
unexemp <- diagdisp(Rendement)
plot(unexemp, frame=FALSE)
show(unexemp)
unexemp <- diagdisp ( Rendement , nom="Rendement")
plot ( unexemp , frame =FALSE , main ="Rendement")
text ( unexemp@atypik ,1.75 , unexemp@atypik ,cex =0.75)
