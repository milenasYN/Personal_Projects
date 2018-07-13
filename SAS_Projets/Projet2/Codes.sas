/*******Question 1*******/
/*a*/
data Echantillon(drop = i); /*generer 250 observations d’une loi N(100, 25) dans une variable nommee X*/
	 do i=1 to 250; /*repeter 250 fois*/
	 	X = rannor(888)*5 + 100; /*generer une observation de loi N(100,5^2)*/
	 	output;
	 end;
run;
proc print data = Echantillon(obs=10);
	title1 'Les 10 premières observations des';
	title2 '250 observations d’une loi N(100, 25)';
run;
/*b*/
title;
data echBootstrap(drop = idObs); /*generer 1000 echantillons aleatoires avec remise de taille 250 de la variable X*/
	do idEchan = 1 to 1000;
		do idObs = 1 to 250;
			alea = int(ranuni(888)*n) + 1; /*generer un nombre aleatoire de loi d'uniforme(1,250)*/
			set Echantillon point = alea nobs = n; /*choisir au hasard une valeur aleatoire (generee)*/
			output;
		end;
	end;
	stop;
run;
proc print data = echBootstrap(obs = 10);
	title1 'Les 10 premières observations des';
	title2 '1000 échantillons aléatoires avec remise';
	title3 'de taille 250 de la variable X';
run;
/*c*/
title;
proc means data = echBootstrap;/*calculer la moyenne de chacun de ces 1000 echantillons*/
	class idEchan;
	output out = MoyennesEchanB mean(X) = MoyenneX;/*nommer le nouveau data MoyenneEchanB et la moyenne MoyenneX*/
run;
data MoyennesEchanB(drop =_TYPE_  _FREQ_ ); /*enlever la moyenne generale*/
	set MoyennesEchanB;
	if _TYPE_ = 0 then delete;
run;
proc print data = MoyennesEchanB(obs = 10);	
	title1 'Les 10 premières observations des';
	title2 'moyennes de chacun des 1000 échantillons';
run;

title;
proc means data = MoyennesEchanB; /*calculer l'ecart-type de la moyenne*/
	 Var MoyenneX;
	 output out = EcartTypeMoyB  std(MoyenneX) = ErreurStandardBootstrap; /*trouver l'estime d'erreur standard*/
run;
/*d*/
data EcartTypeMoyB(drop =_TYPE_  _FREQ_ );
	retain ErreurStandardBootstrap ErreurStandardVrai procheDeLaVraie;	
	set EcartTypeMoyB;
	ErreurStandardVrai = 5/sqrt(250); /*calculer l'erreur standard theorique*/
	if round(ErreurStandardBootstrap) = round(ErreurStandardVrai) then procheDeLaVraie = 'Oui';
	/*Verifiez que l’erreur standard trouvee est proche de la vraie*/
	run;
proc print data = EcartTypeMoyB;
	title1 'Comparaison entre la vraie erreur standard et' ;
	title2 'son estimé par le Bootstrap' ;
run;



/*******Question 2*******/
/*a*/
title;
data Echantillon(drop = i);/*generer 250 observations d’une loi N(100, 25) dans une variable nommee X*/
    do i=1 to 250;/*repeter 250 fois*/
        X = rannor(888)*5 + 100;/*generer une observation de loi N(100,5^2)*/
        output;
    end;
run;
proc print data = Echantillon(obs=10);
	title1 'Les 10 premières observations des';
	title2 '250 observations d’une loi N(100, 25)';
run;
/*b*/
title;
data echJackknife;/*generez 250 echantillons de taille 249 de la variable X*/
    do idEchan = 1 to 250;
        do idObs = 1 to 250;
            set Echantillon point = idObs;
            if idEchan ^= idObs then output;/*gerder toutes les observations sauf l'observation i*/
        end;
    end;
    stop;
run;
proc print data = echJackknife(obs = 10);
	title1 'Les 10 premières observations des';
	title2 '250 Échantillons de taille 249 de la variable X';
run;
/*c*/
title;
proc means data = echJackknife;/*calculer la moyenne de chacun de ces 250 echantillons*/
	class idEchan;
	output out = MoyennesEchanJ mean(X) = MoyenneX;
run;
data MoyennesEchanJ(drop =_TYPE_  _FREQ_ ); /*enlever la moyenne generale*/
	set MoyennesEchanJ;
	if _TYPE_ = 0 then delete;
run;
proc print data = MoyennesEchanJ(obs = 10);	
	title1 'Les 10 premières observations des';
	title2 'Moyenne des 250 échantillons';
run;

title;
proc means data = MoyennesEchanJ;/*calculer l'ecart-type de la moyenne*/
	 Var MoyenneX;
	 output out = EcartTypeMoyJ  std(MoyenneX) = EcartTypeMoyX;
run;
/*d*/
data EcartTypeMoyJ(drop=_TYPE_ _FREQ_ EcartTypeMoyX);/*calculer l'erreur standard theorique*/
	retain ErreurStandardJackknife ErreurStandardVrai procheDeLaVraie;	
	set EcartTypeMoyJ;
	ErreurStandardVrai = 5/sqrt(250);
	ErreurStandardJackknife = (250-1)/sqrt(250)*EcartTypeMoyX; /*calculer l'estime de l'erreur standard de Jacknife*/
	if round(ErreurStandardJackknife) = round(ErreurStandardVrai) then procheDeLaVraie = 'Oui';
	/*Verifiez que l’erreur standard trouvee est proche de la vraie*/
run;
proc print data = EcartTypeMoyJ;	
	title1 'Comparaison entre la vraie erreur standard et' ;
	title2 'son estimé par le Jackknife' ;
run;
/*De ces deux questions, on voit que l'estimé d'erreur standard par le Jackknife est plus proche à la vraie valeur que par le Bootstrap*/


/*******Question 3*******/
/*a*/
title;
data Echantillons;/*Generer 1000 echantillons de taille 5,10,15,...,500 d’une N(0, 1)*/
	do idTaille = 1 to 100; 
		do idEchan = 1 to 1000;
    		do idObs=1 to 5*idTaille;
        		X = rannor(888);
        		output;
        	end;
    	end;
    end;
run;
proc print data = Echantillons (obs=10);
	title 'Les 10 premières observations des 1000 échantillons de taille 5,10,15,...,500';
run;
/*b*/
title;
proc means data = Echantillons prt;/*calculer la p-value d’un test t pour chacun des 101101 echantillons*/
	class idTaille idEchan;
	var X;
	output out = testT prt(X)=pValue;
run;
data testT(drop=_TYPE_); /*elever des observations generees automatiquement par SAS*/
	set testT;
	if (idTaille = '') OR (idEchan = '') then delete;
	rename _FREQ_=tailleEchantillon;
run;
proc print data = testT(obs=10);
	title1 'Les 10 premières observations des';
	title2 'p-values des 101101 échantillons';
run;
/*c*/
title;
data erreur1;/*garder seulement les observations qui ont des p-value < 0.05*/
	set testT;
	where (pValue < 0.05);
run;
proc print data = erreur1(obs=10);
	title1 'Les 10 premières observations qui ont des';
	title2 'p-values < 0.05 dans des 101101 échantillons';
run;

title;
proc means data = erreur1 N; /*compter le nombre d'observation (p-value < 0.05) dans chacun des 100 tailles d'echantillons*/
	class tailleEchantillon;
	var pValue;
	output out = dataErreur1 N = nbrErreur1;
run;
data propErreur1(drop=_TYPE_ _FREQ_); /*calculer la proportion des observations pour chaque taille d'echantillon*/
	set dataErreur1;
	if tailleEchantillon = . then delete;
	proportion = nbrErreur1/1000;
run;
proc print data=propErreur1(obs=10);
	title 'Les 10 premières proportions des erreurs de première espèces';
run;
/*d*/
/* parametriser l'environment du graphique*/ 
goptions reset=all border cback=white htitle=12pt htext=10pt;
/* definir le titre */                                                                                                      
title "la proportion des erreurs de première espèce par rapport à la taille d'échantillons";                                                                                      
                                                                                                                                        
/* definir les caracteristiques des symbols*/                                                                                 
symbol3 interpol=join value=dot  color=depk;                                                                         
                                                                                                                                        
/* definir les caracteristiques des legends*/                                                                                                     
legend1 label=none frame;                                                                                                               
                                                                                                                                        
/* definir les caracteristiques des axes*/                                                                                                       
axis1 label=("taille d'échantillons") 
		minor=none offset=(4pct,4pct)
		reflabel=(j=c h=9pt 'alpha=0.05');                                                                                    
axis2 label=(angle=90 "proportion des erreurs de première espèce")                                                                                                     
      order=(0 to 0.12 by 0.01) minor=(n=1);
proc gplot data=propErreur1;                                                                                                                 
   plot proportion*tailleEchantillon / overlay legend=legend1                                                                               
                              haxis=axis1 vaxis=axis2 vref=0.05;                                                                             
run;                                                                                                                                    
quit;
/*Selon le graphique, les proportions des erreurs de première espèce bougent autour du niveau 0.05 par rapport des différentes tailles*/
/*La taille d'échantillon n'influence pas sur la proportion des erreurs de première espèce*/

/*e*/
/*Etape 1*/
title;
data Echantillons;/*Generer 1000 echantillons de taille 5,10,15,...,500 d’une N(0.2, 1)*/
	do idTaille = 1 to 100; 
		do idEchan = 1 to 1000;
    		do idObs=1 to 5*idTaille;
        		X = rannor(888)+0.2;
        		output;
        	end;
    	end;
    end;
run;
proc print data = Echantillons (obs=10);
	title 'Les 10 premières observations des 1000 echantillons de taille 5,10,15,...,500';
run;
/*Etape 2*/
title;
proc means data = Echantillons prt;/*calculer la p-value d’un test t pour chacun des 101101 echantillons*/
	class idTaille idEchan;
	var X;
	output out = testT prt(X)=pValue;
run;
data testT(drop=_TYPE_);/*elever des observations generees automatiquement par SAS*/
	set testT;
	if (idTaille = '') OR (idEchan = '') then delete;
	rename _FREQ_=tailleEchantillon;
run;
proc print data = testT(obs=10);
	title1 'Les 10 premières observations des';
	title2 'p-values des 101101 échantillons';
run;
/*Etape 3*/
title;
data erreur2;/*garder seulement les observations qui ont des p-value > 0.05*/
	set testT;
	where (pValue > 0.05);
run;
proc print data = erreur2(obs=10);
	title1 'Les 10 premières observations qui ont des';
	title2 'p-values > 0.05 dans des 101101 échantillons';
run;

title;
proc means data = erreur2 N; /*compter le nombre d'observation (p-value > 0.05) dans chacun des 100 tailles d'echantillons*/
	class tailleEchantillon;
	var pValue;
	output out = dataErreur2 N = nbrErreur2;
run;
data propErreur2(drop=_TYPE_ _FREQ_); /*calculer la proportion des observations pour chaque taille d'echantillon*/
	set dataErreur2;
	if tailleEchantillon = . then delete;
	puissance = 1-nbrErreur2/1000;
run;
proc print data=propErreur2(obs=10);
	title 'Les 10 premières valeurs des puissances';
run;
/*Etape 4*/
/* parametriser l'environmen
t du graphique*/ 
goptions reset=all border cback=white htitle=12pt htext=10pt;
/* definir le titre */                                                                                                      
title "la puissance par rapport à la taille d'échantillons";                                                                                      
                                                                                                                                        
/* definir les caracteristiques des symbols*/                                                                                 
symbol3 interpol=join value=dot  color=depk;                                                                         
                                                                                                                                        
/* definir les caracteristiques des legends*/                                                                                                     
legend1 label=none frame;                                                                                                               
                                                                                                                                        
/* definir les caracteristiques des axes*/                                                                                                       
axis1 label=("taille d'échantillons") 
		minor=none offset=(4pct,4pct)
		reflabel=(j=c h=9pt 'alpha=0.05');                                                                                    
axis2 label=(angle=90 "puissance du test")                                                                                                     
      order=(0 to 1 by 0.05) minor=(n=1);
proc gplot data=propErreur2;                                                                                                                 
   plot puissance*tailleEchantillon / overlay legend=legend1                                                                               
                              haxis=axis1 vaxis=axis2 vref=0.05;                                                                             
run;                                                                                                                                    
quit;
/*Selon le graphique, la puissance du test augmente avec la taille d'échantillon.*/
