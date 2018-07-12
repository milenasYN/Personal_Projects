package ca.uqam.inf2120.tp3.modele;

import ca.uqam.inf2120.tp1.adt.NombreCopies;


/**
 * UQAM - Hiver 2014 - INF2120 - Groupe 30 - TP3 
 * 
 * Classe Pneu : représente les informations sur un pneu de vehicules.   
 *    
 * @author Ismael Doukoure
 *Complété par : YANG Na - YANN16628809
 * 
 * @version 1er avril 2014
 */
public class Pneu implements NombreCopies {
	
	// Identifiant unique du pneu
	private int identifiant;
	// le diamètre de roue 
	private int diametreRoue;
	// la largeur du pneu 
	private int largeur;
	// la hauteur 
	private int hauteur;
	// la saison d’utilisation
	private String saison;
	// Prix d'un pneu
	private float prix;
	// le nombre de pneus (nombre de copie).
	private int nombrePneus;
	
	// Le numéro sequentiel,
	private static int numeroSequentiel;
	

	/**
	 * @param identifiant
	 * @param nombrePneu
	 */
	public Pneu(int identifiant, int nombrePneus) {
		this.identifiant = identifiant;
		this.nombrePneus = nombrePneus;
	}




	/**
	 * @param diametreRoue
	 * @param largeur
	 * @param hauteur
	 * @param saison
	 * @param prix
	 * @param nombrePneu
	 */
	public Pneu(int diametreRoue, int largeur, int hauteur,
			String saison, float prix, int nombrePneus) {
		
		this.diametreRoue = diametreRoue;
		this.largeur = largeur;
		this.hauteur = hauteur;
		this.saison = saison;
		this.prix = prix;
		this.nombrePneus = nombrePneus;
		
		identifiant = ++numeroSequentiel;
	}
	
	
	

	/**
	 * @return Le diametre de la roue
	 */
	public int getDiametreRoue() {
		return diametreRoue;
	}

	/**
	 * @param diametreRoue Le nouveau diamètre de la roue.
	 */
	public void setDiametreRoue(int diametreRoue) {
		this.diametreRoue = diametreRoue;
	}

	/**
	 * @return La largeur
	 */
	public int getLargeur() {
		return largeur;
	}

	/**
	 * @param largeur La nouvelle largeur.
	 */
	public void setLargeur(int largeur) {
		this.largeur = largeur;
	}

	/**
	 * @return La hauteur
	 */
	public int getHauteur() {
		return hauteur;
	}

	/**
	 * @param hauteur La nouvelle hauteur
	 */
	public void setHauteur(int hauteur) {
		this.hauteur = hauteur;
	}

	/**
	 * @return La saison
	 */
	public String getSaison() {
		return saison;
	}

	/**
	 * @param saison La nouvelle saison
	 */
	public void setSaison(String saison) {
		this.saison = saison;
	}

	
	/**
	 * @return Le prix
	 */
	public float getPrix() {
		return prix;
	}

	/**
	 * @param prix Le nouveau prix
	 */
	public void setPrix(float prix) {
		this.prix = prix;
	}

	/**
	 * @param identifiant L'identifiant
	 */
	public void setIdentifiant(int identifiant) {
		this.identifiant = identifiant;
	}


	/**
	 * @param nombrePneus Le nouveau nombre de pneus
	 */
	public void setNombrePneus(int nombrePneus) {
		this.nombrePneus = nombrePneus;
	}
	
	/**
	 * @return the identifiant
	 */
	public int getIdentifiant() {
		return identifiant;
	}

	/**
	 * La description du pneu est obtenue en combinant La largeur du pneu, 
	 * une barre oblique (/), la hauteur, la lettre majuscule ‘R’, le diamètre 
	 * de roue, la saison, un espace, un trait d'union, un espace, et le nom.
	 *  
	 * Par exemple :  la largeur du pneu = 175, la hauteur = 65, le diamètre de 
	 *                roue = 14, et la saison est Hiver, la description est : 
	 *                "175/65R14 – Pneu Hiver de 14 pouces".
	 *                
	 * @return La description du pneu
	 */
	public String construireDecription() {
		
		// À compléter
		
		return this.largeur + "/" + this.hauteur + "R" + this.diametreRoue
				+ " - " + "Pneu " + this.saison + " de " + this.diametreRoue
				+ " Pouces.";
	}
	
	

	/* (non-Javadoc)
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object obj) {

		boolean egale = false;
		if ( obj != null && this == obj )
			egale = true;
		else if  ( obj != null && this.getClass() == obj.getClass() ){
			Pneu pneu = ( Pneu )obj;
			if ( identifiant == pneu.getIdentifiant() )
				egale = true;
			else if ( saison.equals( pneu.getSaison() ) &&
					largeur == pneu.getLargeur() &&
					hauteur == pneu.getHauteur() &&
					diametreRoue == pneu.getDiametreRoue() &&
					prix == pneu.getPrix() )
				egale = true;
		}
		return egale;

	}




	/* (non-Javadoc)
	 * @see ca.uqam.inf2120.tp1.adt.NombreCopies#augmenter(int)
	 */
	@Override
	public void augmenter(int nbCopies) {
		
		// À compléter
		
		// Ajoute le nombreCopies à l'attribut nombrePneu
		this.nombrePneus += nbCopies;
		
	}

	/* (non-Javadoc)
	 * @see ca.uqam.inf2120.tp1.adt.NombreCopies#diminuer(int)
	 */
	@Override
	public void diminuer(int nbCopies) {
		
		// À compléter
		
		// Diminue le nombreCopies de l'attribut nombrePneu
		this.nombrePneus -= nbCopies; 
		
	}

	/* (non-Javadoc)
	 * @see ca.uqam.inf2120.tp1.adt.NombreCopies#obtenirNbCopies()
	 */
	@Override
	public int obtenirNbCopies() {
		
		return nombrePneus;
	}
	
	public int TailleListePneus(){
		return numeroSequentiel;
	}

}


