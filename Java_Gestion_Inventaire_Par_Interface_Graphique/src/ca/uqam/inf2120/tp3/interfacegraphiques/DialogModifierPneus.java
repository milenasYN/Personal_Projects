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


@SuppressWarnings("serial")
public class DialogModifierPneus extends JDialog{
	JPanel panneauModifierInfo = new JPanel();
	JRadioButton radioBoutonHiver = new JRadioButton();
	JRadioButton radioBoutonEte = new JRadioButton();
	JLabel labelPrix = new JLabel("Prix:");
	JLabel labelNbPneus = new JLabel("Nombre de pneus:");	
	JLabel grpLarg = new JLabel("Largeur:");
	JLabel grpHaut = new JLabel("Hauteur:");
	JLabel grpDiam = new JLabel("Diam鑤re:");
	JComboBox<Integer> textLarg;
	JComboBox<Integer> textHaut;
	JComboBox<Integer> textDiam;
	JTextField textPrix = new JTextField();
	JTextField textNbPneus = new JTextField();

	JPanel panneauModifierBoutton = new JPanel();
	JButton annuler = new JButton("Annuler");
	JButton modifier = new JButton("Modifier");
	
	Integer[] larg = {165, 175, 185, 215, 225, 265, 275, 285, 295};
	Integer[] haut = {50, 55, 60, 65, 70, 75, 80, 85};
	Integer[] diam = {14, 15, 16, 17, 18, 19, 20, 21};

	@SuppressWarnings({ "unchecked", "rawtypes" })
	DialogModifierPneus(){
		setTitle("Nordic Pneus (SGI) - Modification");
		setLayout(new GridLayout(2,1, 5, 5));
		setBounds(400, 300, 400, 400);
		//cr閍tion du panneauModifierInfo.
		panneauModifierInfo.setBorder(new TitledBorder(null, "Information du pneu",
				TitledBorder.LEADING, TitledBorder.TOP, null, null));
		panneauModifierInfo.setLayout(new GridLayout(6, 2, 10, 4));
		radioBoutonHiver.setSelected(true);
		radioBoutonHiver.setText("Hiver");
		radioBoutonEte.setText("Ete");
		textLarg = new JComboBox(larg);
		textHaut = new JComboBox(haut);
		textDiam = new JComboBox(diam);
		
		panneauModifierInfo.add(radioBoutonHiver);
		panneauModifierInfo.add(radioBoutonEte);
		panneauModifierInfo.add(grpLarg);
		panneauModifierInfo.add(textLarg);
		panneauModifierInfo.add(grpHaut);
		panneauModifierInfo.add(textHaut);
		panneauModifierInfo.add(grpDiam);
		panneauModifierInfo.add(labelPrix);
		panneauModifierInfo.add(textPrix);
		panneauModifierInfo.add(labelPrix);
		panneauModifierInfo.add(textPrix);
		panneauModifierInfo.add(labelNbPneus);
		panneauModifierInfo.add(textNbPneus);
		
		if (InterfaceRecherche.saison == "Hiver"
				&& InterfaceRecherche.saison == "蓆�"){
			radioBoutonHiver.setSelected(true);
			radioBoutonEte.setSelected(true);
		}else if(InterfaceRecherche.saison == "Hiver"){
			radioBoutonHiver.setSelected(true);
		}else if (InterfaceRecherche.saison == "蓆�"){
			radioBoutonEte.setSelected(true);
		}
		textLarg.setSelectedItem(InterfaceRecherche.largeur);
		textHaut.setSelectedItem(InterfaceRecherche.hauteur);
		textDiam.setSelectedItem(InterfaceRecherche.diametreRoue);
		textPrix.setText(Float.toString(InterfaceRecherche.prix));
		textNbPneus.setText(Integer.toString( InterfaceRecherche.nombrePneus));

		//cr閍tion du panneauModifierBoutton.
		panneauModifierBoutton.setLayout(new FlowLayout(FlowLayout.RIGHT));
		Ecouteur ecouteur = new Ecouteur();
		modifier.addActionListener(ecouteur);
		annuler.addActionListener(ecouteur);
		panneauModifierBoutton.add(modifier);		
		panneauModifierBoutton.add(annuler);

		add(panneauModifierInfo);
		add(panneauModifierBoutton);

	}

	public class Ecouteur implements ActionListener {

		public void actionPerformed(ActionEvent e) {
			if (e.getSource().equals(modifier)){
				String saison;
				if (radioBoutonHiver.isSelected() && radioBoutonEte.isSelected()){
					saison = "Hiver et 蓆"; 
				}else if (radioBoutonHiver.isSelected()){
					saison = "Hiver";
				}else{
					saison = "蓆�";
				} 
				int larg = (int) textLarg.getSelectedItem();
				int haut = (int) textHaut.getSelectedItem();
				int diam = (int) textDiam.getSelectedItem();
				float prix = Float.parseFloat(textPrix.getText());
				int nbPneus = Integer.parseInt(textNbPneus.getText());
				if (prix <= 0){
					JOptionPane.showMessageDialog(null,
							"Le prix doit 阾re un nombre r閑l sup閞ieur �0",
							"Erreur",
				    		JOptionPane.ERROR_MESSAGE);
				}else if (nbPneus <= 0){
					JOptionPane.showMessageDialog(null,
							"Le nombre de pneus doit 阾re un nombre entier sup閞ieur �0",
							"Erreur",
				    		JOptionPane.ERROR_MESSAGE);
				}
				Pneu unPneu = new Pneu(diam, larg, haut,
						saison, prix, nbPneus);					
				InterfaceRecherche.stockPneus.modifierPneu(unPneu);
			}else{
				System.exit(0);
			}

		} 
	}
}
