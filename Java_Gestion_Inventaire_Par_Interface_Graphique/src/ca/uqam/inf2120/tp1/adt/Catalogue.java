package ca.uqam.inf2120.tp1.adt;

import java.util.List;
import java.util.ListIterator;



/**
 * UQAM - Hiver 2014 - INF2120 - Groupe 30 - TP1 
 * 
 * ListeAdt : Cette interface d�finit les services d'une liste dans laquelle 
 * un �l�ment peut apparaitre plusieurs fois. Le nombre de fois qu'un �l�ment
 * apparait dans la liste est appel� nombre de copie et support� par l'interface
 * NombreCopie. Le nombre de copies de tout �l�ment pr�sent dans la liste doit
 * �tre sup�rieur � 0.    
 *    
 * @author Ismael Doukoure
 * @version 12 f�vrier 2014
 */
public interface Catalogue<T extends NombreCopies> {

	/**
     * Ajoute "elt" dans la liste s'il n'existe pas, sinon, augmente son nombre de
     * copie (nombre de copies de "elt" dans la liste courante  + nombre de copies de "elt"
     * pass� en param�tre). "elt" doit �tre ajout� � la fin de la liste. Aucun ajout si 
     * "elt" est nul ou son nombre de copie est inf�rieur � 1. 
     * 
     * @param elt L'�l�ment � ajouter
     * @return true si "elt" est ajout�, sinon false.
     */
     public boolean ajouter(T elt);
    
    /**
     * Ajoute tous les �l�ments de la liste pass�e en param�tre dans la liste existante.
     * Si l'�l�ment � ajouter existe d�j� dans la liste courante, son nombre de copie est
     * augment� (nombre de copies de l'�l�ment dans la liste courante  + nombre de copies de
     * l'�l�ment de la liste pass�e en param�tre). 
     * 
     * Aucun ajout :
     *   - si la liste est vide ou nulle.
     *   - si l'�l�ment est nul ou son nombre de copie est inf�rieur � 1.
     *   
     * @param liste La liste dont les �l�ments doivent �tre ajout�s
     */
     public void ajouter(List<T> liste);
    
         
     /**
      * Supprime "elt" dans la liste existante en diminuant son nombre de copies
      * (nombre de copies de "elt" dans la liste courante  - nombre de copies de "elt" pass� en
      * param�tre). L'�l�ment doit �tre retir� de la liste si son nombre de copies apr�s
      * diminution est inf�rieur � 1. 
      * 
      * Aucune suppression si "elt" est nul, s'il n'existe pas dans la liste ou son nombre 
      * de copies est inf�rieur � 1. 
      * 
      * @param elt L'�l�ment � supprimer
      * @return Vrai si l'�l�ment est supprim�, sinon faux 
      */
      public boolean supprimer(T elt);
    
     /**
      * Supprime tous les �l�ments de la liste pass�e en param�tre dans la liste existante
      * en diminuant leur nombre de copies (nombre de copies de "elt" dans la liste 
      * existante - nombre de copies de "elt" de la liste pass�e en param�tre). L'�l�ment
      * doit �tre retir� de la liste existante si son nombre de copies apr�s diminution est
      * inf�rieur � 1. Tous les �l�ments non supprim�s de la liste pass�e en param�tre sont
      * retourn�s dans une autre liste (ArrayList).
      * 
      * @param liste La liste dont les �l�ments doivent �tre supprim�s
      * @return La liste des �l�ments non supprim�s, nul si tous les �l�ments sont supprim�s.
      */
      public List<T> supprimer(List<T> liste);
    
    /**
     * Remplace "eltARemplacer" dans la liste existante par "nouveauElt". 
     * Aucun remplacement ne doit �tre fait :
     *   - si "eltARemplacer" n'existe pas dans la liste
     *   - si "nouveauElt" est nul, s'il existe d�j� dans la liste ou son nombre de copies est
     *     inf�rieur � 1. 
     * 
     * @param eltARemplacer L'�lement de la liste � remplacer
     * @param nouveauElt Le nouveau �l�ment
     * @return Vrai si le remplacement est fait, sinon faux
     */
     public boolean remplacer(T eltARemplacer, T nouveauelt);
    
     /**
      * Retourne l'�l�ment qui se trouve � l'indice pass� en param�tre.
      * 
      * @param indice ou l'�lement � retourner se trouve
      * @throws IndiceHorsBornesException si l'indice est n�gatif ou sup�rieur
      *         au nombre d'�l�ments dans la liste.
      * @return L'�l�ment retourn�
      */
      public T element(int indice) throws IndiceHorsBornesException;
      
      
      /**
       * Retourne tous les �l�ments de la liste courante dont le nombre de 
       * copies <= "nbCopie".
       * 
       * @param nbCopie Le nombre de copies
       * @return La liste des �l�ments dont le nombre de copies <= "nbCopie"
       */
       public List<T> elements(int nbCopie);
      
      
    /**
     * Retourne le nombre de copies de "elt" dans la liste existante.
     * 
     * @param elt L'�lement dont le nombre de copies doit �tre retourn�
     * @return Le nombre de copies
     */
     public int nbCopies(T elt);
     

     /**
      * Retourne le nombre total de copies de tous les �l�ments dans la liste existante.
      * (nbCopie[elt1] + nbCopie[elt2] +...+nbCopie[eltn])
      * 
      * @return Le nombre total de copies
      */
      public int nbTotalCopies();
    
    /**
     * V�rifie si la liste pass�e en param�tre contient les m�mes �l�ments (m�me nombre
     * de copies) que la liste existante.
     *          
     * @param liste  La liste dont l'existence des �l�ments doit �tre v�rifi�e
     * @return Vrai si les deux (2) listes sont �gales, sinon faux
     */
     public boolean estEgale(Catalogue<T> liste);
    
	 /**
     * V�rifie si la liste existante est vide.
     * 
     * @return Vrai si la liste est vide, sinon faux
     */
     public boolean estVide();
     
    
     /**
      * Retourne un it�rateur sur la liste courante.
      *
      * @return It�rateur sur la liste courante.
      */
     public ListIterator<T> iterateur();
    
    
}


