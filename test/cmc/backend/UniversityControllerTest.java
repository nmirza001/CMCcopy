package cmc.backend;

import static org.junit.Assert.*;

import java.util.List;
import java.util.Random;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.Assert;

import cmc.backend.controllers.MockDatabaseController;
import cmc.backend.entities.University;

/**
 * Test the database and its interactions with the University class.
 * @author Roman Lefler
 * @version Mar 15, 2024
 */
public class UniversityControllerTest {
	
	private UniversityController uc;
	private String name1;
	private String name2;
	
	private University getUni(String name) {
		return uc.getUniversity(name);
	}
	
	@Before
	public void setUp() {
		
		Random rand = new Random();
		name1 = "TEST SCHOOL " + rand.nextInt();
		// No 2 will only be added and removed in test methods
		name2 = "TEST SCHOOL NO 2 " + rand.nextInt();
		
		uc = new UniversityController(new MockDatabaseController());
		University uni = new University(name1);
		boolean succ = uc.addNewUniversity(uni);
		Assert.assertTrue(succ);
	}
	
	@After
	public void tearDown() {
		University u = getUni(name1);
		Assert.assertNotNull(u);
		boolean succ = uc.removeUniversity(u);
		Assert.assertTrue(succ);
		uc = null;
	}
	
	@Test
	public void testEditEmphasis() {
		University initial = getUni(name1);
		initial.addEmphasis("LIBERAL ARTS");
		uc.editUniversity(initial);
		initial = null;
		
		// Add a emphasis
		University later = getUni(name1);
		List<String> emphases = later.getEmphases();
		Assert.assertEquals(emphases.size(), 1);
		Assert.assertEquals(emphases.get(0), "LIBERAL ARTS");
		
		// Remove an emphasis
		later.removeEmphasis("LIBERAL ARTS");
		uc.editUniversity(later);
		later = null;
		
		University fffinal = getUni(name1);
		Assert.assertEquals(fffinal.getEmphases().size(), 0);
	}
	
	@Test
	public void deleteWithEmphasis() {
		University u = new University(name2);
		u.addEmphasis("LIBERAL ARTS");
		uc.addNewUniversity(u);
		boolean success = uc.removeUniversity(u);
		Assert.assertTrue(success);
	}
	
	@Test
	public void editWithExtendedTable() {
		final String LEBRON = "https://lebronjames.com";
		final String LEIMAGE =
				"https://upload.wikimedia.org/wikipedia/commons/a/a7/LeBron_James_Lakers.jpg";
;		
		University initial = getUni(name1);
		initial.setWebpageUrl(LEBRON);
		initial.setImageUrl(LEIMAGE);
		boolean editSuccess = uc.editUniversity(initial);
		Assert.assertTrue(editSuccess);
		initial = null;
		
		University after = getUni(name1);
		Assert.assertEquals(LEBRON, after.getWebpageUrl());
		Assert.assertEquals(LEIMAGE, after.getImageUrl());
	}

}
