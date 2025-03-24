package cmc.frontend;

import java.util.Arrays;
import java.util.List;
import java.util.Scanner;
import cmc.*;
import cmc.backend.entities.*;

public class Driver {
	
	// the static UserInteraction object to use for all calls into CMC code
	private static UserInteraction ui = new UserInteraction();
	
	// other classes should *not* instantiate this class.  It is "pure static".
	private Driver() throws CMCException {
		throw new CMCException("Attempt to instantiate a Driver");
	}
		
	// print the header for the current menu
	private static void printHeader(String title) {
		String dashes = "";
		for (int i = 0; i < title.length(); i++)
			dashes += "-";

		System.out.println(dashes);
		System.out.println(title);
		System.out.println(dashes);
	}
	
	private static void adminUserListMenu(Scanner s) {
		printHeader("Admin User List");
		
		// TODO: it would be nice if this was refactored into a list of User objects...
		List<String[]> allUsers = ui.getAllUsers();
		for (String[] user : allUsers) {
			System.out.println(user[2] + " | " + user[0] + " | " + user[1]);
		}
		System.out.println();
		
		int choice = ConsoleUtils.getMenuOption(s, Arrays.asList("Add User", "Remove User", "Go Back"));
		
		switch(choice) {
		case 1:
			if (!ui.addUser(s))
				System.out.println("Failed to add new user.  (Username already exists?)");
			break;
		case 2:
			if (!ui.removeUser(s))
				System.out.println("Failed to remove user.  (Invalid username?)");
			break;
		case 3:
			return;
		default:
			System.err.println("Internal error: Unsupported option.");
			System.exit(1);
		}
	}
	
	private static void adminMenu(Scanner s) {
		printHeader("Admin Menu");
		
		int choice = ConsoleUtils.getMenuOption(s, Arrays.asList("View List of Users", "New University",
				"Logout"));
		
		switch(choice) {
		case 1:
			adminUserListMenu(s);
			break;
		case 2:
			University uni = AdminAddSchool.prompt(s);
			if(uni == null) {
				System.out.println("\nAdd University canceled.");
			}
			else {
				boolean succ = ui.addNewUniversity(uni);
				if(succ) System.out.println("Successfully added university to system.");
				else System.out.println("Failed to insert to database.");
			}
			adminMenu(s);
			break;
		case 3:
			ui.logout();
			break;
		default:
			System.err.println("Internal error: Unsupported option.");
			System.exit(1);
		}
	}
	
	private static void searchResultsMenu(Scanner s, List<University> results) {
		printHeader("Search Results");

		for (University school : results) {
			System.out.println(school.getName() + " | " + school.getState());
		}
		System.out.println();

		int choice = ConsoleUtils.getMenuOption(s, Arrays.asList("Save School", "Go Back"));

		switch(choice) {
		case 1:
			if (!ui.saveSchool(s))
				System.out.println("Failed to save school.  (Already in saved list?)");
			break;
		case 2:
			return;
		default:
			System.err.println("Internal error: Unsupported option.");
			System.exit(1);
		}
	}
	
	private static void userSavedSchoolListMenu(Scanner s) {
		printHeader("User Saved School List");
		
		// TODO: it would be nice if this was refactored into a list of objects
		//       so we can display some data about the school...
		List<String> schools = ui.getSavedSchools();
		for (String school : schools) {
			System.out.println(school);
		}
		System.out.println();
		
		int choice = ConsoleUtils.getMenuOption(s, Arrays.asList("Go Back"));
		
		switch(choice) {
		case 1:
			return;
		default:
			System.err.println("Internal error: Unsupported option.");
			System.exit(1);
		}
	}
	
	private static void regularUserMenu(Scanner s) {
		printHeader("User Menu");
		
		int choice = ConsoleUtils.getMenuOption(s, Arrays.asList("Search", "View Saved Schools", "Logout"));
		
		switch(choice) {
		case 1:
			// TODO: it would be cleaner to use objects here (rather than
			//       arrays of strings)
			List<University> searchResult = ui.search(s);
			searchResultsMenu(s, searchResult);
			break;
		case 2:
			userSavedSchoolListMenu(s);
			break;
		case 3:
			ui.logout();
			break;
		default:
			System.err.println("Internal error: Unsupported option.");
			System.exit(1);
		}
	}

	private static void topMenu(Scanner s) {
		printHeader("Welcome to Choose My College (CMC)!");
		System.out.println("Please log in.");

		String username = "";
		while (username.trim().isEmpty()) {
			System.out.print("Username: ");
			username = s.nextLine();
		}

		System.out.print("Password: ");
		String password = s.nextLine();

		boolean success = ui.login(username, password);
		if (success)
			System.out.println("Redirecting to main menu.");
	}

	// main just forever prints the relevant menu
	public static void main(String[] args) {
		Scanner s = new Scanner(System.in);
		
		while (true) {
			if (ui.getLoggedInUser() == null)
				topMenu(s);
			else if (ui.getLoggedInUser().isAdmin())
				adminMenu(s);
			else
				regularUserMenu(s);
		}
	}

}
