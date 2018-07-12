package ca.uqam.inf2120.tp1.adt;

/**
 * Classe pour g�rer l'exception li�e � un indice 
 * hors bornes d'un tableau.
 * 
 * @author Ismael Doukoure
 * @version 12 f�vrier 2014
 */
@SuppressWarnings("serial")
public class IndiceHorsBornesException extends RuntimeException{
	
	/**
	 * Constructeur sans argument
	 */	
	public IndiceHorsBornesException() {
        super();
    }
	
	/**
	 * Permet d'initialiser le message
	 * @param message Message � afficher
	 */
	public IndiceHorsBornesException(String message) {
        super(message);
    }

}

