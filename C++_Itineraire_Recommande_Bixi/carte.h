#if !defined(_CARTE__H_)
#define _CARTE__H_

#include <istream>
#include <string>
#include <list>
#include <set>
#include <unordered_map>
#include <vector>
#include <assert.h>
#include "coordonnee.h"

using namespace std;

class Carte{
  public:
	Carte(){}
    // Fonctions pour ajouter les lieux et les routes dans la cartes. Elles sont appelées par l'opérateur >>.
    void ajouterLieu(const string& nom, const Coordonnee& coor);
    void ajouterRoute(const string& nom, list<string>& noms);

    // Retourne le nom du lieux le plus près de la coordonnée c.
    const string& getNoeudPlusPres(const Coordonnee& c) const;

    // Fonction pour tester le bon fonctionnement de l'algorithme de recherche de chemins (Dijkstra ou Floyd-Warshall)
    // Reçoit deux noms de lieux. Le chemin est retourné dans la liste out_cheminnoeuds passée en référence.
    // Retourne la distance.
    double calculerChemin(const string& nomorigine, const string& nomdestination, list<string>& out_cheminnoeuds) const;

    // Fonction qui calcule un chemin entre deux coordonnées. Appelé dans le main() dans tp3.cpp.
    double calculerChemin(const Coordonnee& origine, const Coordonnee& destination, list<string>& out_cheminnoeuds) const;


  private:
    struct Lieu{
        Coordonnee coor;
        set<unsigned int> voisins;
    };

    unordered_map<unsigned int, Lieu> lieux;
    unsigned int getIdLieu(const string&) const;
    const string getNomLieu(unsigned int) const;
    friend istream& operator >> (istream& is, Carte& carte);
};

struct Poids{
	Poids(const unsigned int id_=0, double poids_=0.0):id(id_), poids(poids_){}
	unsigned int id;
	double poids;

	bool operator < (const Poids& p)const {return p.poids < poids;}
};


#endif

