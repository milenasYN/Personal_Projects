package ca.uqam.inf2120.tp3.interfacegraphiques;

import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.JTextField;
import javax.swing.border.TitledBorder;

import ca.uqam.inf2120.tp3.modele.Pneu;
import ca.uqam.inf2120.tp3.interfacegraphiques.InterfaceRecherche;

@SuppressWarnings("serial")
public class DialogAjouterPneus extends JDialog{

	JPanel panneauAjouterInfo = new JPanel();
	JRadioButton radioBoutonHiver = new JRadioButton();
	JRadioButton radioBoutonEte = new JRadioButton();
	JLabel labelPrix = new JLabel("Prix:");
	JLabel labelNbPneus = new JLabel("Nombre de pneus:");	
	JLabel grpLarg = new JLabel("Largeur:");
	JLabel grpHaut = new JLabel("Hauteur:");
	JLabel grpDiam = new JLabel("Diamètre:");
	JComboBox<Integer> textLarg;
	JComboBox<Integer> textHaut;
	JComboBox<Integer> textDiam;
	JTextField textPrix = new JTextField();
	JTextField textNbPneus = new JTextField();

	JPanel panneauAjouterBoutton = new JPanel();
	JButton annuler = new JButton("Annuler");
	JButton ajouter = new JButton("Ajouter");

	Integer[] larg = {165, 175, 185, 215, 225, 265, 275, 285, 295};
	Integer[] haut = {50, 55, 60, 65, 70, 75, 80, 85};
	Integer[] diam = {14, 15, 16, 17, 18, 19, 20, 21};

	@SuppressWarnings({ "unchecked", "rawtypes" })
	DialogAjouterPneus(){
		setTitle("Nordic Pneus (SGI) - Ajout");
		setLayout(new GridLayout(2,1, 5, 5));
		setBounds(400, 300, 400, 400);

		//création du panneauAjouterInfo.
		panneauAjouterInfo.setBorder(new TitledBorder(null, "Information du pneu",
				TitledBorder.LEADING, TitledBorder.TOP, null, null));
		panneauAjouterInfo.setLayout(new GridLayout(6, 2, 10, 4));
		radioBoutonHiver.setSelected(true);
		radioBoutonHiver.setText("Hiver");
		radioBoutonEte.setText("Été");
		textLarg = new JComboBox(larg);
		textHaut = new JComboBox(haut);
		textDiam = new JComboBox(diam);

		panneauAjouterInfo.add(radioBoutonHiver);
		panneauAjouterInfo.add(radioBoutonEte);
		panneauAjouterInfo.add(grpLarg);
		panneauAjouterInfo.add(textLarg);
		panneauAjouterInfo.add(grpHaut);
		panneauAjouterInfo.add(textHaut);
		panneauAjouterInfo.add(grpDiam);
		panneauAjouterInfo.add(textDiam);
		panneauAjouterInfo.add(labelPrix);
		panneauAjouterInfo.add(textPrix);
		panneauAjouterInfo.add(labelPrix);
		panneauAjouterInfo.add(textPrix);
		panneauAjouterInfo.add(labelNbPneus);
		panneauAjouterInfo.add(textNbPneus);

		//création du panneauAjouterBoutton.
		panneauAjouterBoutton.setLayout(new FlowLayout(FlowLayout.RIGHT));
		panneauAjouterBoutton.add(ajouter);		
		panneauAjouterBoutton.add(annuler);
		//mettre des écouteur sur les boutons de dialogue ajout.
		Ecouteur ecouteur = new Ecouteur();
		ajouter.addActionListener(ecouteur);
		annuler.addActionListener(ecouteur);
		add(panneauAjouterInfo);
		add(panneauAjouterBoutton);
	}

	public class Ecouteur implements ActionListener {

		public void actionPerformed(ActionEvent e) {
			if (e.getSource().equals(ajouter)){
				String saison;
				if (radioBoutonHiver.isSelected() && radioBoutonEte.isSelected()){
					saison = "Hiver et Été"; 
				}else if (radioBoutonHiver.isSelected()){
					saison = "Hiver";
				}else{
					saison = "Été";
				}
				int larg = (int) textLarg.getSelectedItem();
				int haut = (int) textHaut.getSelectedItem();
				int diam = (int) textDiam.getSelectedItem();
				float prix = Float.parseFloat(textPrix.getText());
				int nbPneus = Integer.parseInt(textNbPneus.getText());
				if (prix <= 0){
					JOptionPane.showMessageDialog(null,
							"Le prix doit être un nombre réel supérieur à 0",
							"Erreur",
				    		JOptionPane.ERROR_MESSAGE);
				}else if (nbPneus <= 0){
					JOptionPane.showMessageDialog(null,
							"Le nombre de pneus doit être un nombre entier supérieur à 0",
							"Erreur",
				    		JOptionPane.ERROR_MESSAGE);
				}
				Pneu unPneu = new Pneu(diam, larg, haut,
						saison, prix, nbPneus);					
				InterfaceRecherche.stockPneus.ajouterPneu(unPneu);
			}

		} 

	}



}
