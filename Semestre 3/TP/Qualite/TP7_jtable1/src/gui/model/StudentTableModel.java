package gui.model;


import java.util.ArrayList;
import java.util.List;

import javax.swing.JOptionPane;
import javax.swing.table.AbstractTableModel;

import data.model.Student;

/**
 * @author André PENINOU
 * @author Fabrice PELLEAU
 */

public class StudentTableModel extends AbstractTableModel {

	private static final long serialVersionUID = 1L;
	
	private List<Student> studentlist = null;
	
	private String[] colName = {"Id", "Nom", "Prénom", "Groupe"};

	/**
	 * Constructeur.
	 */ 
	public StudentTableModel(  ) {
		this.studentlist = new ArrayList<>();
	}
	
	@Override
	public String getColumnName(int i) {
		return colName[i];
	}
	
	@Override 
	public boolean isCellEditable(int lig, int col) {
		if(col < 1) {
			return false;
		}
		
		return true;
	
	}
	
	@Override
	public void setValueAt(Object valeur, int lig, int col) {
		String nom = this.studentlist.get(lig).surname;
		String prenom = this.studentlist.get(lig).firstname;
		String groupe = this.studentlist.get(lig).TPgroup;
		
		switch (col) {
			case 1:
				if(nom != null) {
					nom = (String) valeur;
				} else {
					System.out.println("c'est null");
				}
				
			break;
			case 2:
				if(prenom != null) {
					prenom = (String) valeur;
				} else {
					System.out.println("c'est null");
				}
				
			break;
			case 3:
				if(groupe != null) {
					groupe = (String) valeur;
					groupe.toUpperCase();
				} else {
					System.out.println("c'est null");
				}
			break;
		}
		
	}
		
	// =======================================================================
	// Surcharges des méthodes abstraites de la classe AbstractTableModel
	// =======================================================================
	
	@Override
	public int getColumnCount() {
		return 4;
	}

	@Override
	public int getRowCount() {
		int nbRow = 0;
		if (this.studentlist!=null) {
			nbRow = this.studentlist.size();
		}
		return nbRow;
	}

	@Override
	public Object getValueAt(int lig, int col) {
		if (this.studentlist==null) { return "!!!"; }
		switch (col) {
			case 0:
				return ""+this.studentlist.get(lig).id;
			case 1:
				return this.studentlist.get(lig).surname;
			case 2:
				return this.studentlist.get(lig).firstname;
			case 3:
				return ""+this.studentlist.get(lig).TPgroup;
			default:
				return "???";
		}

	}
	
	// =======================================================================
	// Méthodes spécifiques à la classe StudentTableModel
	// =======================================================================
	/**
	 * Lecture (ou relecture forcée) des données dans la base
	 * 
	 * @param listeDonnees	  ArrayList contenant les students à présenter dans la table
	 */
	public void loadDatas( List<Student> listeDonnees ) {
		this.studentlist = listeDonnees;
		this.fireTableDataChanged();
	}
	
	
	/**
	 * Retourner la copie d'un élément de type Student représentant l'enregistrement de la ligne "lig".
	 * 
	 * @param lig numéro de la ligne (dans la table).
	 * 
	 * @return l'élément concerné ou NULL en cas d'erreur
	 */
	public Student getStudentAt(int lig) {
		Student stud = null;
		if ( this.studentlist != null ) {
			if (this.studentlist.size()>lig) {
				stud = new Student(this.studentlist.get(lig));
			}
		}
		return stud;
	}
}
