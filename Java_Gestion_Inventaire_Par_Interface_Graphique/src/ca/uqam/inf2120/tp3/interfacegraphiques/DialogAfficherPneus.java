package ca.uqam.inf2120.tp3.interfacegraphiques;

import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.border.TitledBorder;


@SuppressWarnings("serial")
public class DialogAfficherPneus extends JDialog{
	//panneauAfficherInfo et ses composants.
	JPanel panneauAfficherInfo = new JPanel();	
	JLabel labelSaison = new JLabel("Saison");;		
	JLabel labelLarg = new JLabel("Largeur:");
	JLabel labelHaut = new JLabel("Haute:");
	JLabel labelDiam = new JLabel("Diamètre:");
	JLabel labelPrix = new JLabel("Prix:");
	JLabel labelNbPneus = new JLabel("Nombre de pneus:");		
	JTextField textSaison = new JTextField();
	JTextField textLarg = new JTextField();
	JTextField textHaut = new JTextField();
	JTextField textDiam = new JTextField();
	JTextField textPrix = new JTextField();
	JTextField textNbPneus = new JTextField();

	//panneauAfficherInfo et ses composants.
	JPanel panneauAfficherBoutton = new JPanel();
	JButton fermer = new JButton("Fermer");	

	DialogAfficherPneus(){
		setTitle("Nordic Pneus (SGI) - Affichage");
		setLayout(new GridLayout(2,1, 5, 5));
		setBounds(400, 300, 400, 400);

		//création du panneauAfficherInfo.
		panneauAfficherInfo.setBorder(new TitledBorder(null, "Information du pneu",
				TitledBorder.LEADING, TitledBorder.TOP, null, null));
		panneauAfficherInfo.setLayout(new GridLayout(6, 2, 10, 4));
		panneauAfficherInfo.add(labelSaison);
		panneauAfficherInfo.add(textSaison);
		panneauAfficherInfo.add(labelLarg);
		panneauAfficherInfo.add(textLarg);
		panneauAfficherInfo.add(labelHaut);
		panneauAfficherInfo.add(textHaut);
		panneauAfficherInfo.add(labelDiam);
		panneauAfficherInfo.add(textDiam);
		panneauAfficherInfo.add(labelPrix);
		panneauAfficherInfo.add(textPrix);
		panneauAfficherInfo.add(labelNbPneus);
		panneauAfficherInfo.add(textNbPneus);
		textSaison.setText(InterfaceRecherche.saison);
		textLarg.setText(Integer.toString(InterfaceRecherche.largeur));
		textHaut.setText(Integer.toString(InterfaceRecherche.hauteur));
		textDiam.setText(Integer.toString(InterfaceRecherche.diametreRoue));
		textPrix.setText(Float.toString(InterfaceRecherche.prix));
		textNbPneus.setText(Integer.toString(InterfaceRecherche.nombrePneus));
		textSaison.setEditable(false);
		textLarg.setEditable(false);
		textHaut.setEditable(false);
		textDiam.setEditable(false);
		textPrix.setEditable(false);
		textNbPneus.setEditable(false);

		//création du panneauAfficherBoutton.

		panneauAfficherBoutton.setLayout(new FlowLayout(FlowLayout.RIGHT));
		panneauAfficherBoutton.add(fermer);
		Ecouteur ecouteur = new Ecouteur();
		fermer.addActionListener(ecouteur);

		add(panneauAfficherInfo);
		add(panneauAfficherBoutton);
	}
	
	public class Ecouteur implements ActionListener{

		public void actionPerformed(ActionEvent evt) {
			if (evt.getSource().equals(fermer)){
				System.exit(0);
			}
			
		}
		
	}
}
