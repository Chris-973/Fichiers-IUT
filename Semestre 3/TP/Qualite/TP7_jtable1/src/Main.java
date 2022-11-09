import gui.view.StudentListFrame;

import java.util.List;

import javax.swing.SwingUtilities;

import data.loader.DataLoader;
import data.model.Student;

public class Main {

	public static void main(String[] args) {
		
		SwingUtilities.invokeLater(new Runnable() {
			@Override
			public void run() {
				List<Student> listStudentsTest = DataLoader.loadDataFromFile("", "");			
				StudentListFrame slf = new StudentListFrame(listStudentsTest);
				slf.setVisible(true);
			}
		});
	}

}
