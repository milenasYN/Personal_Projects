/*
  INF3105 - Structures de données et algorithmes
  UQAM / Département d'informatique
  Été 2014 / TP1 | TP3

  Squelette de départ. Vous pouvez modifier ce fichier à votre guise.
  Vous n'êtes pas oubligés de l'utiliser.
  En principe, vous ne devriez pas avoir à modifier la classe Coordonnee.
  
  SVP : N'imprimtez pas ce fichier, il est déjà fourni (-0.5 si imprimé).
*/

#if !defined(_COORDONNEE__H_)
#define _COORDONNEE__H_

#include <iostream>

class Coordonnee {

  public:
    Coordonnee(){}
    Coordonnee(double latitude_, double longitude_);
    Coordonnee(const Coordonnee&);

    double distance(const Coordonnee&) const;

  private:
    double latitude;
    double longitude;

  friend std::ostream& operator << (std::ostream&, const Coordonnee&);
  friend std::istream& operator >> (std::istream&, Coordonnee&);
};

#endif

