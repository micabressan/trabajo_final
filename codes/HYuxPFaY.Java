import java.awt.BorderLayout;
import java.awt.GridBagConstraints;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;

public class Chat extends JPanel{
	
	Accueil accueilPanel;
	
	public Chat(Accueil accueilPanel){
			
		this.accueilPanel = accueilPanel;
		
		this.setLayout(new BorderLayout());
		
		ListeMessage messages = new ListeMessage();
		JScrollPane scroll = new JScrollPane(messages);
		
		JPanel blocBas = new JPanel();
		blocBas.setLayout(new BorderLayout());
		
		JTextField entree = new JTextField();
		JButton bouton = new JButton("Envoyer");
		bouton.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				String texte = entree.getText();
				entree.setText("");
				messages.addMessage(accueilPanel.prenom + " : " + texte);
			}
		});
		
		blocBas.add(entree, BorderLayout.CENTER);
		blocBas.add(bouton, BorderLayout.EAST);
		
		this.add(scroll, BorderLayout.CENTER);
		this.add(blocBas, BorderLayout.SOUTH );
		
		
	}

}