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
public class DialogSupprimerPneus extends JDialog{
	JPanel panneauSupprimerInfo =  new JPanel();;
	JLabel descrip = new JLabel("Description:");;
	JLabel nbPneus = new JLabel("Nombre de pneus:");;
	JTextField textDescrip = new JTextField();;
	JTextField textNbPneus = new JTextField();;

	JPanel panneauSupprimerBoutton =  new JPanel();;
	JButton annuler = new JButton("Annuler");;
	JButton supprimer = new JButton("Supprimer");;

	DialogSupprimerPneus(){
		setTitle("Nordic Pneus (SGI) - Suppression");
		setLayout(new GridLayout(2,1, 5, 5));
		setBounds(400, 300, 600, 250);

		//création du panneauSupprimerInfo.
		panneauSupprimerInfo.setBorder(new TitledBorder(null, "Information du pneu",
				TitledBorder.LEADING, TitledBorder.TOP, null, null));
		panneauSupprimerInfo.setLayout(new GridLayout(2, 2, 10, 4));			
		panneauSupprimerInfo.add(descrip);
		panneauSupprimerInfo.add(textDescrip);
		panneauSupprimerInfo.add(nbPneus);
		panneauSupprimerInfo.add(textNbPneus);
		
		textDescrip.setText(InterfaceRecherche.description);
		textNbPneus.setText(Integer.toString(InterfaceRecherche.nombrePneus));

		textDescrip.setEditable(false);

		//création du panneauSupprimerBoutton.
		panneauSupprimerBoutton.setLayout(new FlowLayout(FlowLayout.RIGHT));
		Ecouteur ecouteur = new Ecouteur();
		supprimer.addActionListener(ecouteur);
		annuler.addActionListener(ecouteur);
		panneauSupprimerBoutton.add(supprimer);		
		panneauSupprimerBoutton.add(annuler);

		//ajouter des panneaux dans le dialog.
		add(panneauSupprimerInfo);
		add(panneauSupprimerBoutton);
	}

	public class Ecouteur implements ActionListener {

		public void actionPerformed(ActionEvent e) {
			if (e.getSource().equals(supprimer)){
				int nbPneus = Integer.parseInt(textNbPneus.getText());
				InterfaceRecherche.pneuChoisi.diminuer(nbPneus);
			}
		} 
	}
}
