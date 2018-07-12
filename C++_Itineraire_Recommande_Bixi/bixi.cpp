#include "bixi.h"
#include <math.h>
#include <limits>

#define VITESSE_MARCHE  1.0
#define VITESSE_BIXI    4.0



Station::Station()
  : id(-1), nbVelos(0), nbPAD(0)
{
}

const Coordonnee& Station::getCoordonnee() const
{
    return coor;
}

const string& Station::getNom() const
{
    return nom;
}

bool Station::aVeloDisponible() const
{
    return nbVelos>0;
}

bool Station::aPADDisponible() const
{
    return nbPAD>0;
}

void Station::rendreVelo()
{
    nbVelos++;
    nbPAD--;
}

void Station::prendreVelo()
{
    nbVelos--;
    nbPAD++;
}

istream& operator >> (istream& is, Station& station)
{
    is >> station.id >> station.nom >> station.coor >> station.nbVelos >> station.nbPAD;
    return is;
}
ostream& operator << (ostream& os, const Station& station)
{
    os << station.id << "\t" << station.nom << "\t(" << station.coor << ")\t" << station.nbVelos << "\t" << station.nbPAD;
    return os;
}

ostream& operator << (ostream& os, const list<string>& chemin)
{
    for(list<string>::const_iterator iter=chemin.begin();iter!=chemin.end();++iter)
        os << *iter << " ";
    return os;
}

void ReseauBixi::servir(const Coordonnee& origine, const Coordonnee& destination, const Carte& carte)
{
    // Calculer la distance pour la marche seulement.
    list<string> cheminmarchedirecte;
    double distmarchedirect = carte.calculerChemin(origine, destination, cheminmarchedirecte);

    // Jusqu'à preuve du contraire, la marche est la meilleure option.
    double meilleureduree = distmarchedirect / VITESSE_MARCHE;

    // Variables pour conserver la meilleure option de BIXI.
    int meilleurso=-1, // so : station d'origine (où prendre un vélo)
        meilleursd=-1; // sd : station destination (où rendre le vélo)

    // Itérer sur toutes les stations d'origine
    for(unsigned int so=0;so<stations.size();so++){
        if(!stations[so].aVeloDisponible()) continue;

        // Itérer sur toutes les stations de destination
        for(unsigned int sd=0;sd<stations.size();sd++){
            if(sd==so) continue;
            if(!stations[sd].aPADDisponible()) continue;

            // Listes pour les chemins calculés.
            list<string> cheminmarche1, cheminvelo, cheminmarche2;

            // Lancer trois recherches de chemins.
            double distmarche1 = carte.calculerChemin(origine, stations[so].getCoordonnee(), cheminmarche1);
            double distvelo    = carte.calculerChemin(stations[so].getCoordonnee(), stations[sd].getCoordonnee(), cheminvelo);
            double distmarche2 = carte.calculerChemin(stations[sd].getCoordonnee(), destination, cheminmarche2);

            // Calculer la durée totale à partir des distances.
            double duree = distmarche1 / VITESSE_MARCHE
                         + distvelo / VITESSE_BIXI
                         + distmarche2 / VITESSE_MARCHE;

            // Retenir la meilleure option.
            if(duree<meilleureduree){
                meilleureduree = duree;
                meilleurso = so;
                meilleursd = sd;
            }
        }
    }

    // Vérifier si aucune recommandation n'a pu être trouvée.
    if(meilleureduree==numeric_limits<double>::infinity()){
        cout << "Impossible" << endl;
        cout << "--" << endl;
        return;
    }

    // Première ligne : la recommandation.
    if(meilleurso==-1 || meilleursd==-1){
        // Si aucune meilleure option de vélo n'a été trouvée, la meilleure option est la marche seulement.
        cout << "Marche";
    }else{
        // Sinon, la meilleure option est de prendre un vélo.
        stations[meilleurso].prendreVelo();
        stations[meilleursd].rendreVelo();
        cout << stations[meilleurso].getNom() << " --> " << stations[meilleursd].getNom();
    }
    cout << " " << (int) round(meilleureduree) << " s" << endl;

    // Deuxième ligne : le(s) chemin(s).
    if(meilleurso==-1 || meilleursd==-1)
        cout << cheminmarchedirecte << endl;
    else{
        list<string> cheminmarche1, cheminvelo, cheminmarche2;
        carte.calculerChemin(origine, stations[meilleurso].getCoordonnee(), cheminmarche1);
        carte.calculerChemin(stations[meilleurso].getCoordonnee(), stations[meilleursd].getCoordonnee(), cheminvelo);
        carte.calculerChemin(stations[meilleursd].getCoordonnee(), destination, cheminmarche2);
        cout << cheminmarche1 << "| " << cheminvelo << "| " << cheminmarche2 << endl;
    }
}

istream& operator >> (istream& is, ReseauBixi& reseau)
{
    while(is){
        Station s;
        is >> s;
        if(!is.fail()) reseau.stations.push_back(s);
    }
    return is;
}
ostream& operator << (ostream& os, const ReseauBixi& reseau)
{
    for(unsigned int i=0;i<reseau.stations.size();i++){
        cout << reseau.stations[i] << endl;
    }
    return os;
}

