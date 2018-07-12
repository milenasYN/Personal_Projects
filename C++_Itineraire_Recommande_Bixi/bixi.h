#if !defined(_BIXI__H_)
#define _BIXI__H_

#include <iostream>
#include <vector>
#include "coordonnee.h"
#include "carte.h"
#include <unordered_map>
#include <string>

using namespace std;

class Station{
  public:
    Station();
    const Coordonnee& getCoordonnee()const;
    const string& getNom()const;
    bool aVeloDisponible()const;
    bool aPADDisponible()const;

    void rendreVelo();
    void prendreVelo();

  private:
    int id;
    Coordonnee coor;
    string nom;
    int nbVelos; // nombre de vélos disponibles
    int nbPAD; // nombre de points d'ancrage disponibles

  friend istream& operator >> (istream& is, Station& station);
  friend ostream& operator << (ostream& is, const Station& station);
};

class ReseauBixi{
  public:

    void servir(const Coordonnee& origine, const Coordonnee& destination, const Carte& carte);

  private:
    vector<Station> stations;

  friend istream& operator >> (istream& is, ReseauBixi& reseau);
  friend ostream& operator << (ostream& is, const ReseauBixi& reseau);
};


#endif
