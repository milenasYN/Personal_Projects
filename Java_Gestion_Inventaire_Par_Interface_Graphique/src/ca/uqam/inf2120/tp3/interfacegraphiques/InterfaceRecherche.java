package ca.uqam.inf2120.tp3.interfacegraphiques;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;

import javax.swing.*;
import javax.swing.border.TitledBorder;
import javax.swing.event.TableModelEvent;
import javax.swing.event.TableModelListener;
import javax.swing.table.DefaultTableModel;

import ca.uqam.inf2120.tp3.modele.GestionnaireInventairePneus;
import ca.uqam.inf2120.tp3.modele.Pneu;


@SuppressWarnings("serial")
public class InterfaceRecherche extends JFrame{
	static GestionnaireInventairePneus stockPneus = new GestionnaireInventairePneus();
	List<Pneu> pneusTrouves;
	static Pneu pneuChoisi;
	static int ligneChoisie;
	static int diametreRoue;
	static int largeur;
	static int hauteur;
	static String saison;
	static float prix;
	static int nombrePneus;
	static String description;



	//panneauRadio et ses composants.
	JPanel panneauRadio = new JPanel();
	JRadioButton radioDiam = new JRadioButton("Diam鑤re de la roue");
	JRadioButton radioTousPneus = new JRadioButton("Tous les pneus");
	JRadioButton radioInfEgaNb = new JRadioButton("<= �un nombre de pneus");
	JRadioButton radioSupNb = new JRadioButton("> �un nombre de pneus");

	//panneauBox et ses composants
	JPanel panneauBox = new JPanel();
	JCheckBox boxHiver = new JCheckBox("Hiver");
	JCheckBox boxEte = new JCheckBox("蓆�");

	//panneauRecherche et ses composants.
	JPanel panneauRecherche = new JPanel(); 
	JTextField textRecherche = new JTextField();
	JButton boutonRecherche = new JButton("Rechercher");

	//panneauTable et ses composants.
	JPanel panneauTable = new JPanel();
	DefaultTableModel model;
	JScrollPane jScrollPane = new JScrollPane();
	JTable tableInfoPneus;

	//panneauBouton et ses composants.
	JPanel panneauBouton = new JPanel();
	JButton boutonAjouter = new JButton("Ajouter");
	JButton boutonModifier = new JButton("Modifier");
	JButton boutonSupprimer = new JButton("Supprimer");
	JButton boutonAfficher = new JButton("Afficher");
	JButton boutonFermer = new JButton("Fermer"); 

	//des 閏outeurs des panneaux.
	EcouteurRadio ecouteurRadio = new EcouteurRadio();
	EcouteurRecherche ecouteurRecherche = new EcouteurRecherche();
	EcouteurBouton ecouteurBouton = new EcouteurBouton();


	public InterfaceRecherche() {
		super("Nordic Pneus - Syst鑝e de Gestion de l'Inventaire (SGI)");
		init();
	}

	public static void main(String[] args) {

		JFrame fenetre = new InterfaceRecherche();
		fenetre.setBounds(400, 200, 600, 500); 
		fenetre.setDefaultCloseOperation(JDialog.HIDE_ON_CLOSE);
		fenetre.setVisible(true);
	}

	private void init() {
		//Cr閍tion du panneauRadio.		
		panneauRadio.setBorder(new TitledBorder(null, "Type de recherche",
				TitledBorder.LEADING, TitledBorder.TOP, null, null));
		panneauRadio.setLayout(new GridLayout(2, 2, 10, 10));		
		radioDiam.setSelected(true);
		ButtonGroup grp = new ButtonGroup();
		grp.add(radioDiam);
		grp.add(radioInfEgaNb);
		grp.add(radioTousPneus);
		grp.add(radioSupNb);
		radioDiam.addActionListener(ecouteurRadio);
		radioInfEgaNb.addActionListener(ecouteurRadio);
		radioTousPneus.addActionListener(ecouteurRadio);
		radioSupNb.addActionListener(ecouteurRadio);

		panneauRadio.add(radioDiam);
		panneauRadio.add(radioInfEgaNb);
		panneauRadio.add(radioTousPneus);        
		panneauRadio.add(radioSupNb);

		//Cr閍tion du panneauBox.		
		panneauBox.setBorder(new TitledBorder(null, "Saisons des pneus recherch閟",
				TitledBorder.LEADING, TitledBorder.TOP, null, null));
		panneauBox.setLayout(new GridLayout(1, 2, 10, 10));
		boxHiver.setSelected(true);
		panneauBox.add(boxHiver);
		panneauBox.add(boxEte);

		//Cr閍tion du panneauRecherche.		
		panneauRecherche.setBorder(new TitledBorder(null, null,
				TitledBorder.LEADING, TitledBorder.DEFAULT_POSITION, null, null));
		panneauRecherche.setLayout(new FlowLayout());    	       
		textRecherche.setColumns(20); 
		//mettre des 閏outeurs sur le boutonRecherche.
		boutonRecherche.addActionListener(ecouteurRecherche);

		panneauRecherche.add(textRecherche);
		panneauRecherche.add(boutonRecherche);


		//Cr閍tion du panneauTable.	
		String[] entete = new String[]{
				"Description", "Prix", "Nombre de pneus"
		};
		model = new DefaultTableModel(entete,0);
		tableInfoPneus = new JTable(model);
		jScrollPane = new JScrollPane(tableInfoPneus);
		tableInfoPneus.setPreferredScrollableViewportSize(new Dimension(550,50));
		panneauTable.add(jScrollPane, BorderLayout.CENTER);



		//Cr閍tion du panneauBouton    	 
		panneauBouton.setLayout(new FlowLayout(FlowLayout.RIGHT));

		//Mettre des ecouteurs sur les boutons.        
		boutonAjouter.addActionListener(ecouteurBouton);        
		boutonModifier.addActionListener(ecouteurBouton);
		boutonSupprimer.addActionListener(ecouteurBouton);
		boutonAfficher.addActionListener(ecouteurBouton);        
		boutonFermer.addActionListener(ecouteurBouton);
		boutonModifier.setEnabled(false);
		boutonSupprimer.setEnabled(false);
		boutonAfficher.setEnabled(false);

		panneauBouton.add(boutonAjouter);
		panneauBouton.add(boutonModifier);
		panneauBouton.add(boutonSupprimer);
		panneauBouton.add(boutonAfficher);
		panneauBouton.add(boutonFermer);

		this.setLayout(new GridLayout(5, 1, 5, 5));
		this.add(panneauRadio);
		this.add(panneauBox);
		this.add(panneauRecherche);
		this.add(panneauTable);
		this.add(panneauBouton);   	

	}

	//classe interne d'EcouteurRadio.
	public class EcouteurRadio implements ActionListener {

		public void actionPerformed(ActionEvent evt) {
			if (evt.getSource().equals(radioTousPneus)){
				textRecherche.setEditable(false);
			}else{
				textRecherche.setEditable(true);
			}
		}

	}	

	//classe interne d'EcouteurRecherche.
	public class EcouteurRecherche implements ActionListener{

		public void actionPerformed(ActionEvent evt) {
			if (evt.getSource().equals(boutonRecherche)){
				int saisonInt;	
				String saisonString;
				if (boxHiver.isSelected() && boxEte.isSelected()){
					saisonInt = 3;
					saisonString = "Hiver et 蓆�";
				}else if (boxHiver.isSelected()){
					saisonInt = 1;	
					saisonString = "Hiver";
				}else{
					saisonInt = 2;
					saisonString = "蓆�";
				}

				if (radioDiam.isSelected()){
					int diamRecherche = Integer.parseInt(textRecherche.getText());					
					pneusTrouves = stockPneus.rechercherParDiametre(diamRecherche, saisonInt);	
					if (pneusTrouves.isEmpty()){
						JOptionPane.showMessageDialog(null,
								"Aucun pneu d'" + saisonString + " est trouv�avec le diam鑤re de " 
										+ diamRecherche + "!",
										"Information",
										JOptionPane.INFORMATION_MESSAGE);
					}
				}else if (radioInfEgaNb.isSelected()){
					int nnombrePneus = Integer.parseInt(textRecherche.getText());
					boolean plusPetitOuEgal = true;
					pneusTrouves = stockPneus.rechercherParNombre(nnombrePneus, plusPetitOuEgal, saisonInt);
					if (pneusTrouves.isEmpty()){
						JOptionPane.showMessageDialog(null,
								"Aucun pneu d'" + saisonString + 
								" est trouv�avec le nombre de pneus plus petit ou 間al �"
								+ nnombrePneus + "!",
								"Information",
								JOptionPane.INFORMATION_MESSAGE);
					}
				}else if (radioSupNb.isSelected()){
					int nnombrePneus = Integer.parseInt(textRecherche.getText());
					boolean plusPetitOuEgal = false;
					pneusTrouves = stockPneus.rechercherParNombre(nnombrePneus, plusPetitOuEgal, saisonInt);
					if (pneusTrouves.isEmpty()){
						JOptionPane.showMessageDialog(null,
								"Aucun pneu d'" + saisonString + 
								" est trouv�avec le nombre de pneus plus grand �" 
								+ nnombrePneus + "!",
								"Information",
								JOptionPane.INFORMATION_MESSAGE);
					}
				}else{
					pneusTrouves = stockPneus.rechercherTousLesPneus(saisonInt);
					if (pneusTrouves.isEmpty()){
						JOptionPane.showMessageDialog(null,
								"Aucun pneu d'" + saisonString + " est trouv�",
								"Information",
								JOptionPane.INFORMATION_MESSAGE);
					}
				}				

				Iterator<Pneu> it = pneusTrouves.iterator();
				while (it.hasNext()){
					Pneu pneuCourant = it.next();
					String descripC =pneuCourant.construireDecription();
					float prixC = pneuCourant.getPrix();
					int nombrePneusC = pneuCourant.obtenirNbCopies();

					Vector vector = new Vector(model.getColumnCount());

					for (int i = 0; i < model.getColumnCount(); i++) {
						switch (i){
						case 0:
							vector.add(descripC);
							break;
						case 1:
							vector.add(prixC);
							break;
						case 2:
							vector.add(nombrePneusC);
							break;	                    
						}
					}
					model.addRow(vector);

				}
			}
		}

	}	



	//classe interne d'EcouteurBoutton.
	public class EcouteurBouton implements ActionListener {

		public void actionPerformed(ActionEvent evt) {

			if (evt.getSource().equals(boutonAjouter)) {			
				DialogAjouterPneus ajoutDialog = new DialogAjouterPneus();				
				ajoutDialog.setVisible(true);
				boutonModifier.setEnabled(true);
				boutonSupprimer.setEnabled(true);
				boutonAfficher.setEnabled(true);
			}else if (evt.getSource().equals(boutonModifier)){
				ligneChoisie = tableInfoPneus.getSelectedRow();
				pneuChoisi = pneusTrouves.get(ligneChoisie);
				saison = pneuChoisi.getSaison();
				largeur = pneuChoisi.getLargeur();
				hauteur = pneuChoisi.getHauteur();
				diametreRoue = pneuChoisi.getDiametreRoue();
				prix = pneuChoisi.getPrix();
				nombrePneus = pneuChoisi.obtenirNbCopies();
				DialogModifierPneus modifierDialog = new DialogModifierPneus();				
				modifierDialog.setVisible(true);
			}else if (evt.getSource().equals(boutonSupprimer)){	
				ligneChoisie = tableInfoPneus.getSelectedRow();
				pneuChoisi = pneusTrouves.get(ligneChoisie);
				description = pneuChoisi.construireDecription();
				nombrePneus = pneuChoisi.obtenirNbCopies();
				DialogSupprimerPneus supprimerDialog = new DialogSupprimerPneus();				
				supprimerDialog.setVisible(true);
			}else if (evt.getSource().equals(boutonAfficher)){	
				ligneChoisie = tableInfoPneus.getSelectedRow();
				pneuChoisi = pneusTrouves.get(ligneChoisie);
				saison = pneuChoisi.getSaison();
				largeur = pneuChoisi.getLargeur();
				hauteur = pneuChoisi.getHauteur();
				diametreRoue = pneuChoisi.getDiametreRoue();
				prix = pneuChoisi.getPrix();
				nombrePneus = pneuChoisi.obtenirNbCopies();						
				DialogAfficherPneus afficherDialog = new DialogAfficherPneus();				
				afficherDialog.setVisible(true);
			}else{
				System.exit(0);
			}
		}
	}

}








