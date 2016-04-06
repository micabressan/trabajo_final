package OReillySwing;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

/**
 * Created by CJ on 2015.08.16..
 */
public class TextFieldTest extends Component implements ActionListener {
    String name;
    JTextField field;
    JFrame frame;

    public static void main(String[] args) {
        TextFieldTest test = new TextFieldTest();
        test.go();
    }

    private void go() {
        frame = new JFrame("Text test");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        JPanel panel = new JPanel();

        JLabel label = new JLabel("Dogs first name: ");
        field = new JTextField("Enter Dog's name here");
        field.requestFocus();
        field.addActionListener(this);

        panel.add(label);
        panel.add(field);

        frame.getContentPane().add(panel, BorderLayout.NORTH);
        frame.setVisible(true);
        frame.setSize(300, 300);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        name = field.getText();
        if (name != null) {
            JOptionPane.showMessageDialog(this, "your dog's name: ");
        }
    }
}