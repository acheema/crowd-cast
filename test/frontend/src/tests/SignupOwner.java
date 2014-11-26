package tests;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.annotations.Test;

import pages.FrontPage;
import pages.NewListingPage;
import strings.LocatorStrings;
import util.Helper;

public class SignupOwner {	
	  @Test 
	  public void signUpOwner() {
	    WebDriver driver = new FirefoxDriver();
	      
	    try {
	        // Each test method needs to create it's own driver instance
	        FrontPage f = new FrontPage(driver).open().clickSignup();
	        WebDriverWait wait = new WebDriverWait(driver, 10);
	        WebElement element = wait.until(ExpectedConditions.elementToBeClickable(By.id("signup")));
	        String ownerUsername = LocatorStrings.UsernameOwner + "" + Helper.getTimestampAsID() + " ";
	       
	        
	        NewListingPage s = f.signUpOwner(ownerUsername, LocatorStrings.UsernameOwner, LocatorStrings.OwnerEmail, LocatorStrings.OwnerCompany);
	        // assert that after an advertiser signs up, they are directed to the search page
	        wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("create-listing-button")));
	        String curUrl = s.getUrl();
		    assert curUrl.contains("listing"): "After signing up, advertisers should be directed to search page but got: " + curUrl;

	    }
	    finally {
	    	driver.quit();
	    }
	  }

}
