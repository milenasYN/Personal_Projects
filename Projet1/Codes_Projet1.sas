Option Mprint;/*Imprimer dans le journal les etapes de macro*/
%Macro devoir4(nbEchan,nbObs,beta0,beta1,sigma0,sigmaN,ecartSigma);
data Echantillons; 
	beta0 = &beta0;
	beta1 = &beta1;
	do idSigma = &sigma0 by &ecartSigma to &sigmaN; /*generer 11 differentes valeurs de sigmaU*/
		sigmaU = idSigma;
		do idEch = 1 to &nbEchan; /*pour chaque valeur de sigmaU on genere 100 echantillons*/
			do i = 1 to &nbObs; /*pour chaque echantillon on genere 100 observations de X et Y*/
				x = rannor(8)*10 + 100;
				u = rannor(8)*sigmaU;
				e = rannor(8)*20;
				X_ = x + u;
				Y = beta0 + beta1*x + e;
				output;
			end;
		end;
	end;
run;
proc sort data = Echantillons;
	by sigmaU idEch;
run;
proc print data = Echantillons(obs=10);
	title 'Les 10 premières observations des échantillons';
run;

/*Construire le modèle de régression et sortir le R^2*/
title;
Proc Reg data = Echantillons outest = statistiques RSQUARE noprint;
	Model Y = X_;
	by sigmaU idEch;
Run;
proc sort data = statistiques;
	by sigmaU idEch;
run;
proc print data = statistiques(obs=10);
	title 'Les 10 premières observations des statistiques du modèle de régression';
run;

/*Construire le graphique de R^2 par rapport à la valeur de sigmaU*/
title;
proc template;                                                                
  define statgraph unbox1;
    begingraph;
      entryTitle "R^2 par rapport à la valeur de sigmaU"; 
      layout overlay / xaxisopts=(display=(tickvalues) 
	  					linearOpts=(tickvalueSequence=(start=&sigma0 increment=&ecartSigma end=&sigmaN)
                        ))
						yaxisopts=(label="R^2")
                        ;
        scatterPlot x=eval(0.08*rannor(57)+sigmaU) y=_RSQ_ / name="sp1"
                    markerAttrs=GraphData3 legendLabel="jittered data"
                    dataTransparency=0.5;
        boxplot x=sigmaU y=_RSQ_ / display=(caps mean median CONNECT) connect=mean
                    meanAttrs=(color=red symbol=diamondFilled);

        discreteLegend "sp1";
      endlayout;           
    endgraph;                                                               
  end;                                                                       
run;
proc sgrender template=unbox1 data=statistiques;
run;

/*Construrie le graphique de l'estimateur de beta1 par rapport à la valeur de sigmaU*/
proc template;                                                                
  define statgraph unbox2;
    begingraph;
      entryTitle "L'estimateur de beta1 par rapport à la valeur de sigmaU"; 
      layout overlay / xaxisopts=(display=(tickvalues)
	  					linearOpts=(tickvalueSequence=(start=&sigma0 increment=&ecartSigma end=&sigmaN)
                        ))
						yaxisopts=(label="Estimateur de beta1");
        scatterPlot x=eval(0.08*rannor(57)+sigmaU) y=X_ / name="sp1"
                    markerAttrs=GraphData3 legendLabel="jittered data"
                    dataTransparency=0.5;
        boxplot x=sigmaU y=X_ / display=(caps mean median CONNECT) connect=mean
                    meanAttrs=(color=red symbol=diamondFilled);

        discreteLegend "sp1";
      endlayout;           
    endgraph;                                                               
  end;                                                                        
run;
proc sgrender template=unbox2 data=statistiques;
run;
%Mend devoir4;
/*En donnant nbEchan=100,nbObs=100,beta0=10,beta1=10,sigma0=0,sigmaN=10,ecartSigma=1
on obtient les deux graphiques en utilisant le macro '%devoir4'*/
%devoir4(100,100,10,10,0,10,1);
