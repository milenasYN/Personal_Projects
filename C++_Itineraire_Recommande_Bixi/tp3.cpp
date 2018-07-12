/*
  INF3105 -- Structures de données et algorithmes
  UQAM / Département d'informatique
  Été 2014
*/

/*
  Squelette de départ pour le TP3.
   - Ce squelette est fourni pour vous aider à vous concentrer sur l'essentiel du TP3.
   - Vous est libre de l'utiliser ou de repartir à zéro.
   - Vous pouvez y effectuer toutes les modifications que vous souhaitez ou jugez nécessaires.
   - Ce squelette vise d'abord la simplicité pour obtenir rapidement un programme fonctionnel.
   - Une réorganisation peut être nécessaire pour obtenir un programme efficace.

  Ce fichier contient une solution simple du TP1. Elle a été adaptée au TP3.
  
  SVP : N'imprimtez ce fichier que si vous l'avez modifié de façon signification.
*/

#include <fstream>
#include <iostream>
#include <string>
#include "bixi.h"
#include "carte.h"

using namespace std;

void tp3(ReseauBixi& reseau, Carte& carte, istream& isrequetes){
    while(isrequetes){
        Coordonnee c1, c2;
        isrequetes >> c1 >> c2;
        //string plusproche1 = carte.getNoeudPlusPres(c1);
        //string plusproche2 = carte.getNoeudPlusPres(c2);
        if(!isrequetes) break;
        reseau.servir(c1, c2, carte);
    }
}

int main(int argc, const char** argv)
{
    if(argc<3){
        cout << "Syntaxe: ./tp3 reseau.txt carte.txt [requetes.txt]" << endl;
        return 1;
    }
    
    ReseauBixi reseau;
    Carte carte;
   
    ifstream fichierreseau(argv[1]);
    if(fichierreseau.fail()){
        cout << "Erreur ouverture : " << argv[1] << endl;
        return 1;
    }
    fichierreseau >> reseau;
    
    ifstream fichiercarte(argv[2]);
    if(fichiercarte.fail()){
        cout << "Erreur ouverture : " << argv[2] << endl;
        return 1;
    }
    fichiercarte >> carte;

    if(argc==4){
        ifstream fichierrequetes(argv[3]);
        if(fichierrequetes.fail()){
            cout << "Erreur ouverture : " << argv[3] << endl;
            return 1;
        }
        tp3(reseau, carte, fichierrequetes);
    }else
        tp3(reseau, carte, cin);
    
    return 0;
}

