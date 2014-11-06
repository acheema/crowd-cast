import unittest
import os
import testLib

class TestBadUnitTests(testLib.RestTestCase):
    """Issue a REST API request to run the unit tests, and analyze the result"""
    def testErrorUnitTest(self):
        """
        errorUnitTests is an incorrectly formatted ruby file that should through an error
        """
        respData = self.makeRequest("/TESTAPI/errorUnitTests", method="POST")
        self.assertTrue('output' in respData)
        self.assertFalse('nrFailed' in respData)
        self.assertFalse('totalTests' in respData)

    def unitTestHelper(self, respData, nrFailed, totalTests):
        self.assertTrue('output' in respData)
        self.assertTrue('nrFailed' in respData)
        self.assertTrue('totalTests' in respData)
        self.assertEquals(respData['nrFailed'], nrFailed)
        self.assertEquals(respData['totalTests'], totalTests)
    
    """
    API calls purely for testing unitTests
    This was useful because unit tests outputs are different for different cases, 
    and I wanted to make sure to capture all of them

    Cases:
       unit tests that error out
       unit tests with no tests
       fail a single unit tests
       fail 2 unit tests
       pass a valid unit test
       pass and fail a unit test
    """
   
    def testMockUnitTest1(self):
        respData = self.makeRequest("/TESTAPI/mockUnitTests1", method="POST")
        self.unitTestHelper(respData, 0, 0)

    def testMockUnitTest2(self):
        respData = self.makeRequest("/TESTAPI/mockUnitTests2", method="POST")
        self.unitTestHelper(respData, 1, 1)

    def testMockUnitTest3(self):
        respData = self.makeRequest("/TESTAPI/mockUnitTests3", method="POST")
        self.unitTestHelper(respData, 2, 2)

    def testMockUnitTest4(self):
        respData = self.makeRequest("/TESTAPI/mockUnitTests4", method="POST")
        self.unitTestHelper(respData, 0, 1)
    
    def testMockUnitTest5(self):
        respData = self.makeRequest("/TESTAPI/mockUnitTests5", method="POST")
        self.unitTestHelper(respData, 1, 2)
    
class TestAddAdditionalUser(testLib.RestTestCase):
    """Test adding users"""
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)

    def testAddExistingUser(self):
        # Attempt to add the same user
        self.makeRequest("/users/add", method="POST", data = { 'user' : 'user1', 'password' : 'password'} )
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'user1', 'password' : 'password'} )
        self.assertResponse(respData, count = None, errCode = testLib.RestTestCase.ERR_USER_EXISTS)
    
    def testAddSlightlyDifferentUser(self):
        self.makeRequest("/users/add", method="POST", data = { 'user' : 'user1', 'password' : 'password'} )
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'User1', 'password' : 'password'} )
        self.assertResponse(respData, count = 1)
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'user1  ', 'password' : 'password'} )
        self.assertResponse(respData, count = 1)
    
    def testAddEmptyUser(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : '', 'password' : 'password'} )
        self.assertResponse(respData, count = None, errCode = testLib.RestTestCase.ERR_BAD_USERNAME)

    def testAddMoreThanMaxLengthUser(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'a' * 129, 'password' : 'password'} )
        self.assertResponse(respData, count = None, errCode = testLib.RestTestCase.ERR_BAD_USERNAME)
   
    def testAddMaxLengthUser(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'a' * 128, 'password' : 'password'} )
        self.assertResponse(respData, count = 1, errCode = testLib.RestTestCase.SUCCESS)

    def testAddMoreThanMaxLengthPassword(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'user1', 'password' : 'a' * 129} )
        self.assertResponse(respData, count = None, errCode = testLib.RestTestCase.ERR_BAD_PASSWORD)
   
    def testAddMaxLengthPassword(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'user1', 'password' : 'a' * 128} )
        self.assertResponse(respData, count=1, errCode = testLib.RestTestCase.SUCCESS)

    def testAddEmptyPassword(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'user1', 'password' : ''} )
        self.assertResponse(respData, count = 1, errCode = testLib.RestTestCase.SUCCESS)

    def testAddBadUserAndPassword(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : '', 'password' : 'a' * 129} )
        self.assertResponse(respData, count = None, errCode = testLib.RestTestCase.ERR_BAD_USERNAME)

class TestLoginUser(testLib.RestTestCase):
    """Test logging users"""
    def _set_up(self):
        self.makeRequest("/users/add", method="POST", data={ 'user': 'user1', 'password': 'password'} )   
        self.makeRequest("/users/add", method="POST", data={ 'user': 'user2', 'password': 'password'} )   
    
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)

    def testLoginExistingUser(self):
        self._set_up()
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'user1', 'password' : 'password'} )
        self.assertResponse(respData, count = 2)

    def testLoginUserWithBadPassword(self):
        self._set_up()
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'user1', 'password' : 'passwor'} )
        self.assertResponse(respData, count = None, errCode = testLib.RestTestCase.ERR_BAD_CREDENTIALS)
    
    def testLoginNonExistingUser(self):
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'does not exist', 'password' : 'password'} )
        self.assertResponse(respData, count = None, errCode = testLib.RestTestCase.ERR_BAD_CREDENTIALS)
   
    def testLogin(self):
        self._set_up()
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'user1', 'password' : 'password'} )
        self.assertResponse(respData, count = 2)
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'user1', 'password' : 'password'} )
        self.assertResponse(respData, count = 3)
        # Verify that logging and adding users incorrectly doesn't affect the counts of the actual user
        self.makeRequest("/users/login", method="POST", data = { 'user' : 'user1', 'password' : 'passw'} )
        self.makeRequest("/users/add", method="POST", data = { 'user' : 'user1', 'password' : 'password'} )
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'user1', 'password' : 'password'} )
        self.assertResponse(respData, count = 4)
        # Verify that logging into a user doesn't affect other users
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'user2', 'password' : 'password'} )
        self.assertResponse(respData, count = 2)

class TestResetFixture(testLib.RestTestCase):
    """Test adding users"""
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)

    def testResetFixtureBasic(self):
        respData = self.makeRequest("/TESTAPI/resetFixture", method="POST" )
        self.assertResponse(respData, count = None)

    def testResetFixture(self):
        # Add users through API, resetFixture, and then do a couple of API calls to verify that they were deleted
        # And that we can re-add them
        self.makeRequest("/users/add", method="POST", data={ 'user': 'user1', 'password': 'password'} )   
        self.makeRequest("/users/add", method="POST", data={ 'user': 'user2', 'password': 'password'} )   
        respData = self.makeRequest("/TESTAPI/resetFixture", method="POST" )
        self.assertResponse(respData, count = None)
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'user1', 'password' : 'password'} )
        self.assertResponse(respData, count = None, errCode = testLib.RestTestCase.ERR_BAD_CREDENTIALS)
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'user2', 'password' : 'password'} )
        self.assertResponse(respData, count = None, errCode = testLib.RestTestCase.ERR_BAD_CREDENTIALS)
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'user1', 'password' : 'password'} )
        self.assertResponse(respData, count = 1)
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'user2', 'password' : 'password'} )
        self.assertResponse(respData, count = 1)

