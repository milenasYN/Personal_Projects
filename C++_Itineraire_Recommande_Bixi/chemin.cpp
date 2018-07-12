/*
  INF3105 - Structures de données et algorithmes
  UQAM / Département d'informatique
  Été 2014
  
  Auteur : Eric Beaudry (beaudry.eric@uqam.ca - http://ericbeaudry.ca)
  
  Ce programme a pour objectif de vous aider à tester votre implémentation de l'algorithme de recherche de chemins.
  
  SVP : N'imprimtez pas ce fichier, il est déjà fourni (-0.5 si imprimé).
*/

#include <fstream>
#include <iostream>
#include <string>
#include <list>
#include <math.h>
#include "carte.h"

using namespace std;

int main(int argc, const char** argv)
{
    if(argc<=1){
        cout << "Syntaxe: ./chemin carte.txt" << endl;
        return 1;
    }

    Carte carte;
   
    ifstream fichiercarte(argv[1]);
    if(fichiercarte.fail()){
        cout << "Erreur ouverture : " << argv[1] << endl;    
        return 1;
    }
    fichiercarte >> carte;
    
    while(cin){
        Coordonnee origine, destination;
        cout << "#Origine : ";
        cin >> origine;
        if(!cin)break;
        string noeudorigine = carte.getNoeudPlusPres(origine);
        cout << "#Noeud le plus près de l'origine dans la carte : " << noeudorigine << endl;

        cout << "#Destination : ";
        cin >> destination;
        if(!cin)break;
        string noeuddestination = carte.getNoeudPlusPres(destination);
        cout << "#Noeud le plus près de la destination dans la carte : " << noeuddestination << endl;
        
        std::list<string> chemin1;
        cout << "#Chemin de " << noeudorigine << " à " << noeuddestination << " :" <<endl;
        double longueur1 = carte.calculerChemin(noeudorigine, noeuddestination, chemin1);
        cout << "#";
        for(std::list<string>::iterator iter=chemin1.begin();iter!=chemin1.end();++iter)
            cout << *iter << " ";
        cout << endl;
        cout << "#" << round(longueur1) << " m" << endl;

        std::list<string> chemin2;
        cout << "#Chemin de " << origine << " à " << destination << " :" <<endl;
        double longueur2 = carte.calculerChemin(origine, destination, chemin2);
        for(std::list<string>::iterator iter=chemin2.begin();iter!=chemin2.end();++iter)
            cout << *iter << " ";
        cout << endl;
        cout << (int) round(longueur2) << " m" << endl;
    }
    
}
