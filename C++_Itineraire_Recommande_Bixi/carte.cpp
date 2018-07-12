#include <iostream>
#include <limits>
#include <queue>
#include <math.h>
#include <cstdlib>
#include "carte.h"

void Carte::ajouterLieu(const string& nom, const Coordonnee& coor) {
    Lieu& lieu = lieux[getIdLieu(nom)];
    lieu.coor = coor;
}

void Carte::ajouterRoute(const string& nom, list<string>& route){
	list<string>::const_iterator iter1=route.begin();
    if(iter1==route.end()) return;
    list<string>::const_iterator iter2=iter1;
    ++iter2;
    while(iter2!=route.end()){
        lieux[getIdLieu(*iter1)].voisins.insert(getIdLieu(*iter2));
        iter1 = iter2;
        ++iter2;
    }
}

string rien = "?";
const string& Carte::getNoeudPlusPres(const Coordonnee& c) const{
	double distance, distanceMinimum = std::numeric_limits<double>::infinity();
	string& nomNoeud(rien);
	for (unordered_map<unsigned int, Lieu>::const_iterator iter=lieux.begin();iter!=lieux.end();++iter){
		distance = c.distance(iter->second.coor);
		if (distance < distanceMinimum){
            unsigned int id = iter->first;
			distanceMinimum = distance;
			nomNoeud = getNomLieu(id);
		}
	}

    return nomNoeud;
}

double Carte::calculerChemin(const string& nomorigine, const string& nomdestination, list<string>& out_cheminnoeuds) const
{
	priority_queue<Poids,vector<Poids> > candidat;
	unordered_map<unsigned int, double> compteurDistance;
	unordered_map<unsigned int, unsigned int> compteurParent;
	bool dejaVisite(false);
	unsigned int idorigine = getIdLieu(nomorigine);
	unsigned int iddestination = getIdLieu(nomdestination);
	
	candidat.push(Poids(idorigine));	
	for(unordered_map<unsigned int, Lieu>::const_iterator iter = lieux.begin(); iter != lieux.end(); ++iter)
		compteurDistance[iter->first] = numeric_limits<double>::infinity();
		
	compteurDistance[idorigine] = 0.0;

	while(!candidat.empty() && !dejaVisite){
		Poids p = candidat.top();
		candidat.pop();
		if(p.id == iddestination)
			dejaVisite = true;
		double distcandidat = compteurDistance[p.id];
		if (distcandidat == numeric_limits<double>::infinity()) {
			break;
		}
		
		Lieu lieu = lieux.at(p.id);
		const set<unsigned int> voisins = lieu.voisins;
		double distance(0.0);
		for(set<unsigned int>::const_iterator iter = voisins.begin(); iter != voisins.end(); ++iter){
			distance = distcandidat + lieu.coor.distance(lieux.at(*iter).coor);
			if(distance < compteurDistance[*iter]){
				compteurDistance[*iter] = distance;
				compteurParent[*iter] = p.id;
				candidat.push(Poids(*iter, distance));
			}
		}
	}	

	out_cheminnoeuds.push_back(nomdestination);
	unsigned int idLieuRoute(iddestination);
	while(idLieuRoute != idorigine){
			out_cheminnoeuds.push_front(getNomLieu(compteurParent[idLieuRoute]));
			idLieuRoute = compteurParent[idLieuRoute];
	}

    return compteurDistance[iddestination];
}



double Carte::calculerChemin(const Coordonnee& origine, const Coordonnee& destination, list<string>& out_cheminnoeuds) const
{
    double d(0.0);
	string noeudOrig = getNoeudPlusPres(origine);
    string noeudDest = getNoeudPlusPres(destination);
    unsigned int idNoeudOrig = getIdLieu(noeudOrig);
    unsigned int idNoeudDest = getIdLieu(noeudDest);
	if (noeudOrig!=noeudDest)
		d = calculerChemin(noeudOrig, noeudDest, out_cheminnoeuds);
	else
		out_cheminnoeuds.push_back(noeudOrig);
    d += origine.distance(lieux.at(idNoeudOrig).coor);
	d += destination.distance(lieux.at(idNoeudDest).coor);
    return d;
}

/*
 * Convertir un nom de lieu en ID
 */
unsigned int Carte::getIdLieu(const string& nom) const {
    string strip = nom.substr(1);
    return atoi(strip.c_str());
}


/*
 * Convertir un ID en nom de lieu
 */
const string Carte::getNomLieu(unsigned int id) const {

    unsigned long long a = id;
    string str = "n" + to_string(a);

    return str;
}

/* Lire une carte. */
istream& operator >> (istream& is, Carte& carte)
{
    // Lire les lieux
    while(is){
        string nomlieu;
        is >> nomlieu;
        if(nomlieu == "---") break;
        Coordonnee coor;
        is >> coor;
        carte.ajouterLieu(nomlieu, coor);
    }

    // Lire les routes
    while(is){
        string nomroute;
        is >> nomroute;
        if(nomroute == "---" || nomroute=="" || !is) break;

        char deuxpoints;
        is >> deuxpoints;
        assert(deuxpoints == ':');

        std::list<std::string> listenomslieux;

        string nomlieu;
        while(is){
            is>>nomlieu;
            if(nomlieu==";") break;
            assert(nomlieu!=":");
            assert(nomlieu.find(";")==string::npos);
            listenomslieux.push_back(nomlieu);
        }

        assert(nomlieu==";");

        carte.ajouterRoute(nomroute, listenomslieux);
    }

    return is;
}

