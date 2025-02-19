package regression;

import static org.junit.Assert.*;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import cmc.CMCException;
import cmc.backend.DatabaseController;
import cmc.backend.SystemController;
import cmc.backend.User;
import junit.framework.Assert;

public class DeactivatedUserCanStillLogin {

	private static final String USERNAME = "test_test_test_acct";
	private static final String PASSWD = "pass123$";
	
	private DatabaseController db;
	
	@Before
	public void setUp() throws CMCException {
		db = new DatabaseController();
		db.addUser(USERNAME, PASSWD, 'u', "Test", "Acct");
		db.deactivateUser(USERNAME);
	}
	
	@After
	public void tearDown() throws CMCException {
		db.removeUser(USERNAME);
	}
	
	@Test
	public void test() throws CMCException {
		SystemController sc = new SystemController();
		User user = sc.login(USERNAME, PASSWD);
		Assert.assertNull(user);
	}

}
