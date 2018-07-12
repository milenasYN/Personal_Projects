package ca.uqam.inf2120.tp1.adt.impl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

import ca.uqam.inf2120.tp1.adt.Catalogue;
import ca.uqam.inf2120.tp1.adt.IndiceHorsBornesException;
import ca.uqam.inf2120.tp1.adt.NombreCopies;

public class CatalogueImpl<T extends NombreCopies> implements Catalogue<T> {
	
	private List<T> uneListe;
	

	public CatalogueImpl() {
		uneListe = new ArrayList<T>();
	}

	@Override
	public boolean ajouter(T elt) {

		boolean estAjoute = false;

		if (elt != null && elt.obtenirNbCopies() >= 1){
			estAjoute = true;

			if (uneListe.indexOf(elt) >= 0) {

				int position = uneListe.indexOf(elt);
				uneListe.get(position).augmenter(elt.obtenirNbCopies());			
			}else {
				uneListe.add(elt);				
			}
		}
		
		return estAjoute;
	}

	@Override
	public void ajouter(List<T> liste) {

		if (liste != null && !liste.isEmpty()){
			for (T t: liste){
				this.ajouter(t);
			}
		}
	}

	@Override
	public boolean supprimer(T elt) {
		
		boolean estSupprime = false;
		
		if (elt != null && elt.obtenirNbCopies() >= 1 && uneListe.indexOf(elt) >= 0 ){
			estSupprime = true;
			int position = uneListe.indexOf(elt);
			uneListe.get(position).diminuer(elt.obtenirNbCopies());			
			if (uneListe.get(position).obtenirNbCopies() < 1){
				uneListe.remove(position);				
			}
		}
		
		return estSupprime;
	}

	@Override
	public List<T> supprimer(List<T> liste) {
		
		List<T> listeRetournee = new ArrayList<T>();

		if (liste != null && !liste.isEmpty()){	
			Iterator<T> it = liste.iterator();
			while (it.hasNext()){
				T elt = it.next();
				if (!supprimer(elt)){
					listeRetournee.add(elt);
				}
			}

			if (listeRetournee.isEmpty()){
				listeRetournee = null;
			}
		}else{
			listeRetournee = liste;
		}

		return listeRetournee;

	}

	@Override
	public boolean remplacer(T eltARemplacer, T nouveauelt) {
		
		boolean estRemplace = false;
		
		if (uneListe.indexOf(nouveauelt) >= 0 || nouveauelt == null || nouveauelt.obtenirNbCopies() < 1 ){
			estRemplace = false;
		}else if (uneListe.indexOf(eltARemplacer) >= 0){
			int position = uneListe.indexOf(eltARemplacer);
			uneListe.set(position,nouveauelt);
			estRemplace = true;
		}
		
		return estRemplace;

	}

	@Override
	public T element(int indice) throws IndiceHorsBornesException {

		if (indice < 0 || indice >= uneListe.size()){
			throw new IndiceHorsBornesException("l'indice est négatif ou supérieur au nombre d'éléments dans la liste!");
		}else{
			return uneListe.get(indice);
		}
	}

	@Override
	public List<T> elements(int nbCopie) {
		
		Iterator<T> it = uneListe.iterator();
		List<T> listeRetournee = new ArrayList<T>();

		if (uneListe != null && !uneListe.isEmpty()){
			while (it.hasNext()){
				T elt = it.next();
				if (elt.obtenirNbCopies() <= nbCopie){
					listeRetournee.add(elt);
				}
			}
		}else{
			listeRetournee = uneListe;
		}
		
		return listeRetournee;
	}

	@Override
	public int nbCopies(T elt) {
		
		int nbCopies = 0;
		
		if (uneListe.indexOf(elt) >= 0){
			int position = uneListe.indexOf(elt);
			nbCopies = uneListe.get(position).obtenirNbCopies();
		}
		
		return nbCopies;

	}

	@Override
	public int nbTotalCopies() {
		
		int nbCopiesTotales = 0;
		
		for (T t: uneListe){
			nbCopiesTotales += t.obtenirNbCopies();
		}
		
		return nbCopiesTotales;
	}

	@Override
	public boolean estEgale(Catalogue<T> liste) {

		boolean estEgale = false;
		ListIterator<T> it = liste.iterateur();
		int nbElement = 0, nbElementPareil = 0;

		while (it.hasNext()){
			T elt = it.next();
			nbElement++;

			if (uneListe.indexOf(elt) >= 0 
					&& elt.obtenirNbCopies() == nbCopies(elt)){
				nbElementPareil++;				
			}
		}

		if (nbElement == nbElementPareil && nbElement == uneListe.size()){
			estEgale = true;
		}

		return estEgale;
		
		
	}

	@Override
	public boolean estVide() {
		
		return uneListe.isEmpty();
	}

	@Override 
	public ListIterator<T> iterateur() {
		
		return uneListe.listIterator();
		
	}

}
