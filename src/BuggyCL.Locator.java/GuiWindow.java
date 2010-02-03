import java.awt.Dimension;
import java.awt.GridLayout;
import java.awt.Panel;
import java.awt.Toolkit;

import javax.swing.*;


/*	TODO: this could be a response window asking testers to assign 
		 a task for seaching buggy changelist. 
		 
	TODO: try your best to make it multithreading, otherwise, the 
		 GUI will be frozen due to long during of test.
*/
class GuiWindow extends JFrame{
	
	public static final String[] plaforms = { "PC" ,"XBox360", "PS3"};
	
	public GuiWindow(){
		
		this.setTitle("Assign a task ...");
		
		JLabel bugDesciption = new JLabel("Bug Description");
		JLabel platform = new JLabel("Platform");
		JLabel clstart = new JLabel("CL# Start");
		JLabel clend = new JLabel("CL# End");
		JLabel notifier = new JLabel("To notify");
		
		JTextField description = new JTextField("Add some description of the bug.");
		JComboBox t_plaform = new JComboBox(plaforms);
		JTextField t_clstart = new JTextField();
		//TODO: sanity checking content? 
		
		JTextField t_clend = new JTextField();
		
		JButton btn_search = new JButton("Create search task");
		
		Panel bugInfoPanel = new Panel();
		GridLayout bug_layout = new GridLayout(5,2);
		bugInfoPanel.setLayout(bug_layout);
		
		bugInfoPanel.add(bugDesciption);
		bugInfoPanel.add(description);
		bugInfoPanel.add(platform);
		bugInfoPanel.add(t_plaform);
		bugInfoPanel.add(clstart);
		bugInfoPanel.add(t_clstart);
		bugInfoPanel.add(clend);
		bugInfoPanel.add(t_clend);
		bugInfoPanel.add(btn_search );
		
		description.select(0, description.getText().length() - 1);
		
		
		Panel log_panel = new Panel();
		JTextArea log = new JTextArea();
		log.setEditable(true);
		log.setEditable(true);
		log.setBounds(100, 100, 500, 500);
		log_panel.add(log);
		
		Panel container = new Panel();
		container.setLayout(new GridLayout(2,1));
		container.add(bugInfoPanel);
		container.add(log_panel);
		this.getContentPane().add(container);

		
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		
		this.pack(); //setSize(200, 200);
	    Dimension dim = Toolkit.getDefaultToolkit().getScreenSize();
	    int w = this.getSize().width;
	    int h = this.getSize().height;
	    int x = (dim.width-w)/2;
	    int y = (dim.height-h)/2;
		this.setLocation(x, y);
		
		
		this.setVisible(true);
				
	}
	
	
	public static void main(String args[]){
		GuiWindow win = new GuiWindow();
	}
}