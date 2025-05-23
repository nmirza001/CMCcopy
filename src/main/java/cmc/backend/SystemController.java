package cmc.backend;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import cmc.CMCException;
import cmc.backend.controllers.DatabaseController;
import cmc.backend.entities.University;

public class SystemController {
	private DatabaseController myDBController;
	private AccountController myAC;
	private UniversityController myUC;
	private SearchController mySearchController; // Added field declaration
	
	// Construct a SystemController using the basic (no parameter)
	// DatabaseController as the underlying database access.
	public SystemController() {
		this.myDBController = new DatabaseController();
		this.myAC = new AccountController();
		this.myUC = new UniversityController();
		this.mySearchController = new SearchController(myUC);
	}
	
	public SystemController(DatabaseController injectDb) {
		myDBController = injectDb;
		myAC = new AccountController(injectDb);
		myUC = new UniversityController(injectDb);
		mySearchController = new SearchController(myUC);
	}
	
	/**
	 * Verify whether the username and password provided match a user in the
	 * database.  Return a Boolean indicating yes or no.
	 * 
	 * TODO: how could we distinguish a DB error from a failed login?
	 * 
	 * @param username the username to check
	 * @param password the password to check for matching the username
	 * @return the matching User object if the username and password match
	 * a database entry, or null otherwise
	 * @throws CMCException
	 */
	public User login(String username, String password) throws CMCException {
		User u = this.myDBController.getUser(username);
		if (u == null)
			return null;
		
		if (!u.isActivated() || !u.password.equals(password)) {
			return null;
		}
		else {
			return u;
		}
	}
	
	// this ADMIN ONLY method attempts to add a user to the database with the
	// provided details
	public boolean addUser(User u) {
		try {
			return this.myAC.addUser(u);
		} catch (CMCException e) {
			// TODO: should we let the calling class report the error more
			//       clearly by passing it on?
			return false;
		}
	}
	
	// this ADMIN ONLY method attempts to remove a user from the database
	// based on the provided username
	public boolean removeUser(User u) {
		try {
			return this.myAC.removeUser(u);
		} catch (CMCException e) {
			// TODO: should we let the calling class report the error more
			//       clearly by passing it on?
			return false;
		}
	}
	
	/**
	 * Gets the SearchController for performing university searches.
	 * @return The search controller
	 */
	public SearchController getSearchController() {
		return mySearchController;
	}
	
	// this REGULAR USER ONLY method attempts to add the provided school
	// to the list of saved schools for the provided username
	public boolean saveSchool(String user, String school) throws CMCException {
		return this.myDBController.saveSchool(user, school);
	}
	
	/**
	 * This REGULAR USER ONLY method attempts to remove the provided school
	 * from the list of saved schools for the provided username
	 * 
	 * @param user Username of the user
	 * @param school Name of the school to remove
	 * @return true if school was successfully removed, false otherwise
	 * @throws CMCException if there is an error with database operation
	 */
	public boolean removeSchool(String user, String school) throws CMCException {
		// Get the current saved schools for this user
		List<String> savedSchools = this.getSavedSchools(user);
		
		// Check if the school is actually in the user's saved list
		if (savedSchools == null || !savedSchools.contains(school)) {
			return false;
		}
		
		// Use the database controller to remove the saved school
		return this.myDBController.removeSchool(user, school);
	}
	
	// this REGULAR USER ONLY method attempts to retrieve the list of saved
	// schools for the provided username
	public List<String> getSavedSchools(String user) {
		Map<String, List<String>> usersToSavedSchools = this.myDBController.getUserSavedSchoolMap();
		return usersToSavedSchools.get(user);
	}
	
	/*
	 * helper method called viewSchools
	 * @param String schoolName takes an entry for the school to view
	 * @return sb.toString()
	 * @return return schoolName + " " + "is not on the list"
	 * @author Rick Masaana
	 * @version March 24 2025
	 */
	public String viewSchool (String schoolName) {
		List <University> allSchools = this.myUC.getAllSchools();
		
		//loop through list
		for (University school : allSchools) {
			
			//checks to see if the school is there
			if (school.getName().equals(schoolName)) {
			StringBuilder sb = new StringBuilder(); //string builder sb
			sb.append("School Name: ").append(school.getName()).append("\n");
			sb.append("State: ").append(school.getState()).append("\n");
			sb.append("Location: ").append(school.getLocation()).append("\n");
			sb.append("Control: ").append(school.getControl()).append("\n");
			sb.append("Number of Students: ").append(school.getNumStudents()).append("\n");
			sb.append("Percent Female: ").append(school.getPercentFemale()).append("\n");
			sb.append("SAT Verbal: ").append(school.getSatVerbal()).append("\n");
			sb.append("SAT Math: ").append(school.getSatMath()).append("\n");
			sb.append("Expenses: ").append(school.getExpenses()).append("\n");
			sb.append("Percent Financial Aid: ").append(school.getPercentFinancialAid()).append("\n");
			sb.append("Number of Applicants: ").append(school.getNumApplicants()).append("\n");
			sb.append("Percent Admitted: ").append(school.getPercentAdmitted()).append("\n");
			sb.append("Percent Enrolled: ").append(school.getPercentEnrolled()).append("\n");
			sb.append("Academics Scale: ").append(school.getScaleAcademics()).append("\n");
			sb.append("Social Scale: ").append(school.getScaleSocial()).append("\n");
			sb.append("Quality of Life Scale: ").append(school.getScaleQualityOfLife()).append("\n");
			sb.append("Emphases: ");
			
			//additional special info
			if (school.getEmphases().isEmpty()) {
				sb.append("no special info\n");
			}
			else {
				sb.append(String.join(", ", school.getEmphases())).append("\n");
			}
			
			return sb.toString(); //proper return
			}
		}
		
		return schoolName + " " + "is not on the list";
	}
	
	public static boolean editUniversityDetails (University editedUniversity) throws CMCException {
		return SystemController.editUniversityDetails(editedUniversity);
	}
	
	
	/**
	 * Gets a list of every university in the database.
	 * @return All universities in the database.
	 * @author Roman Lefler
	 * @version Mar 24, 2025
	 */
	public List<University> getAllUniversities() {

		return myUC.getAllSchools();
	}
	
	/**
	 * Adds a new university to the database by calling the database controller.
	 * @param uni University
	 * @return {@code true} if the operation succeeded.
	 * @throws IllegalArgumentException if uni is null
	 * @author Roman Lefler
	 * @version Mar 13, 2025
	 */
	public boolean addNewUniversity(University uni) {
		
		return myUC.addNewUniversity(uni);
	}
	
	/**
	 * Removes a university from the database by calling the database controller.
	 * @param u University
	 * @return {@code true} if the operation succeeded.
	 * @throws IllegalArgumentException if u is {@code null}.
	 */
	public boolean removeUniversity(University u) {
 
		return myUC.removeUniversity(u);
	}
	
	/**
	 * 
	 * @param University uni takes given entry
	 * @return {@code true} on success
	 * @throws IllegalArgumentException is null
	 * @author Rick Masaana
	 * @version 4/15/2025
	 */
	public boolean editUniversity (University uni){
		if (uni == null) throw new IllegalArgumentException ("University is null");
			return myUC.editUniversity(uni);
	}
	/**@param username the username of the user to update
	 * @param newFirstName new first name
	 * @param newLastName new last name
	 * @param newPassword new password
	 * @return true if update is successful
	 * @throws CMCException if error occurs
	 */
	public boolean updateUserInfo (String username, String newFirstName, String newLastName, String newPassword) throws CMCException{
		User user = this.myDBController.getUser(username);
		if(user == null) {
			return false;
		}
		if (newFirstName != null && !newFirstName.isEmpty()) {
			user.setFirstName(newFirstName);
		}
		if (newLastName != null && !newLastName.isEmpty()) {
			user.setLastName(newLastName);
		}
		if (newPassword != null && !newPassword.isEmpty()) {
			user.setPassword(newPassword);
		}
	return this.myAC.editUser(user);
}
}