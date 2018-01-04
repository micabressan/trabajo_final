package gui.view.tree;
import javax.swing.tree.DefaultMutableTreeNode;

import gui.SingletonMainFrame;
import gui.model.Parameter;
import gui.model.Product;
import gui.model.Wizard;
import gui.model.Workspace;



public class RemoveNodeFromTree {

	public static void removeNode() {
		DefaultMutableTreeNode sel = (DefaultMutableTreeNode) SingletonMainFrame.getInstance().getMainFrame().getTree().getLastSelectedPathComponent();
		
		if (sel != null && !sel.isRoot()) {
			DefaultMutableTreeNode par = (DefaultMutableTreeNode) sel.getParent();
			Object o = par.getUserObject();
			
			if(o instanceof Workspace){
				((Workspace) o).deleteProduct((Product) sel.getUserObject());
			} else if(o instanceof Product) {
				((Product) o).deleteWizard((Wizard) sel.getUserObject());
			} else {
				((Wizard) o).deleteParameter((Parameter) sel.getUserObject());
			}
				
			SingletonMainFrame.getInstance().getMainFrame().getModel().removeNodeFromParent(sel);
		}
	}
}