package ca.uqam.inf2120.tp3.modele;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import ca.uqam.inf2120.tp1.adt.Catalogue;
import ca.uqam.inf2120.tp1.adt.impl.CatalogueImpl;

/**
 * UQAM - Hiver 2014 - INF2120 - Groupe 30 - TP3 
 * 
 * Classe GestionnaireInventairePneus : contient les services de gestion 
 * de l'inventaire de pneus de NORDIC PNEUS.   
 *    
 * @author Ismael Doukoure
 * Complété par : YANG Na - YANN16628809
 * 
 * @version 1er avril 2014
 */
public class GestionnaireInventairePneus {
	
	// Le catalogue de pneus
	Catalogue<Pneu> catalogue;
	
	/**
	 * Constructeur sans argument qui crée
	 * un catalogue vide de pneus.
	 */
	public GestionnaireInventairePneus() {
		catalogue = new CatalogueImpl<Pneu>();
	}
	
	/**
	 * Ajouter un pneu dans l'inventaire.
	 * 
	 * @param unPneu Le pneu à ajouter
	 */
	public void ajouterPneu(Pneu unPneu) {		
		catalogue.ajouter(unPneu);	

	}
	
	/**
	 * Trouver le pneu selon l'identifiant dans l'inventaire et modifier le 
	 * pneu selon les informations du pneu passé en paramètre.
	 * 
	 * @param unPneu Le pneu à modifier
	 */
	public void modifierPneu(Pneu unPneu) {
		Iterator<Pneu> it = catalogue.iterateur();
		boolean estTrouve = false;
		while (it.hasNext() && !estTrouve){
			Pneu pneuCourant = it.next();
			if (pneuCourant.getIdentifiant() == unPneu.getIdentifiant()){
				estTrouve = true;
			}
			pneuCourant.setDiametreRoue(unPneu.getDiametreRoue());
			pneuCourant.setHauteur(unPneu.getHauteur());
			pneuCourant.setLargeur(unPneu.getLargeur());
			pneuCourant.setNombrePneus(unPneu.obtenirNbCopies());
			pneuCourant.setPrix(unPneu.getPrix());
			pneuCourant.setSaison(unPneu.getSaison());			
		}		
	}
	
	/**
	 * Rechercher tous les pneus dont le diametre est égal au diamètre
	 * passé en paramètre et la saison est égale à la saison passée en
	 * paramètre.
	 *   
	 * @param diametre Le diamètre du pneu recherché.
	 * @param saison dont les valeurs possibles: 1 = Hiver, 2 = Été, 3 = Hiver et Été 
	 * @return Le tableau Liste (ArrayList) des pneus qui répondent au critère de recherche.
	 */
	public List<Pneu> rechercherParDiametre(int diametre, int saison) {
		List<Pneu> listeRetournee = new ArrayList<Pneu>();
		String saisonString = null;
		switch (saison){
		case 1:
			saisonString = "Hiver";
			break;
		case 2:
			saisonString = "Été";
			break;
		case 3:
			saisonString = "Hiver et Été";
			break;		
		}
		
		Iterator<Pneu> it = catalogue.iterateur();
		while (it.hasNext()){
			Pneu pneuCourant = it.next();
			if (pneuCourant.getDiametreRoue() == diametre 
					&& pneuCourant.getSaison() == saisonString){
				listeRetournee.add(pneuCourant);
			}
		}
			
		return listeRetournee;
		
	}
	
	/**
	 * Rechercher tous les pneus selon une saison (ou les saisons) et dont le nombre de pneus est :
	 * 
	 *   a) supérieur au paramètre "nombrePneus" si le paramètre "plusPetitOuEgal" est faux.  
	 *   b) inférieur ou égal au paramètre "nombrePneus" si le paramètre "plusPetitOuEgal" est vrai.
	 *   
	 * @param nnombrePneus Le nombre de pneus
	 * @param plusPetitOuEgal Le flag qui indique le type de recherche selon le nombre de pneus.     
	 * @param saison dont les valeurs possibles: 1 = Hiver, 2 = Été, 3 = Hiver et Été 
	 * @return Le tableau Liste (ArrayList) des pneus qui répondent au critère de recherche.
	 */
	public List<Pneu> rechercherParNombre(int nnombrePneus, boolean plusPetitOuEgal, int saison) {
		
		List<Pneu> listeRetournee = new ArrayList<Pneu>();
		String saisonString = null;
		switch (saison){
		case 1:
			saisonString = "Hiver";
			break;
		case 2:
			saisonString = "Été";
			break;
		case 3:
			saisonString = "Hiver et Été";
			break;		
		}
		
		Iterator<Pneu> it = catalogue.iterateur();
		while (it.hasNext()){
			Pneu pneuCourant = it.next();
			if (pneuCourant.getSaison() == saisonString){
				if (plusPetitOuEgal == true && pneuCourant.obtenirNbCopies() <= nnombrePneus){
					listeRetournee.add(pneuCourant);
				}else if (plusPetitOuEgal == false && pneuCourant.obtenirNbCopies() > nnombrePneus)
					listeRetournee.add(pneuCourant);
				}
			}
					
		return listeRetournee;
	}
	
	/**
	 * Rechercher tous les pneus selon la saison ou les saisons. 
	 *     
	 * @param saison dont les valeurs possibles: 1 = Hiver, 2 = Été, 3 = Hiver et Été 
	 * @return Le tableau Liste (ArrayList) des pneus qui répondent au critère de recherche.
	 */
	public List<Pneu> rechercherTousLesPneus(int saison) {
		
		List<Pneu> listeRetournee = new ArrayList<Pneu>();
		String saisonString = null;
		switch (saison){
		case 1:
			saisonString = "Hiver";
			break;
		case 2:
			saisonString = "Été";
			break;
		case 3:
			saisonString = "Hiver et Été";
			break;		
		}
		
		Iterator<Pneu> it = catalogue.iterateur();
		while (it.hasNext()){
			Pneu pneuCourant = it.next();
			if (pneuCourant.getSaison() == saisonString){				
					listeRetournee.add(pneuCourant);
				}
			}
					
		return listeRetournee;
		
	}
	
	/**
	 * Supprime un pneu en diminuant le nombre et/ ou en le suprimer physiquement si 
	 * le nombre de copies est <= 0.
	 * 
	 * @param unPneu Le pneu à supprimer.
	 * @return Vrai si la suppression a été faite, sinon faux.
	 */
	public boolean supprimerPneu(Pneu unPneu) {
		
		return catalogue.supprimer(unPneu);
	}
	
	public boolean estVide(){
		return catalogue.estVide();
	}
	
	

}
