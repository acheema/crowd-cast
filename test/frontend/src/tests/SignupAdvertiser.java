package tests;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.annotations.Test;

import pages.FrontPage;
import pages.SearchPage;
import strings.LocatorStrings;
import util.Helper;

public class SignupAdvertiser {	
	  @Test 
	  public void signupAdvertiser() {
	    WebDriver driver = new FirefoxDriver();
	      
	    try {
	        // Each test method needs to create it's own driver instance
	        FrontPage f = new FrontPage(driver).open().clickSignup();
	        WebDriverWait wait = new WebDriverWait(driver, 10);
	        WebElement element = wait.until(ExpectedConditions.elementToBeClickable(By.id("signup")));
	        String advertiserUsername = LocatorStrings.UsernameAdvertiser + "" + Helper.getTimestampAsID() + " ";
	       
	        
	        SearchPage s = f.signupAdv(advertiserUsername, LocatorStrings.UsernameAdvertiser, LocatorStrings.AdvertiserEmail, LocatorStrings.AdvertiserCompany);
	        // assert that after an advertiser signs up, they are directed to the search page
	        wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("add-ad-button")));
	        String curUrl = s.getUrl();
		    assert curUrl.contains("search"): "After signing up, advertisers should be directed to search page but got: " + curUrl;

	    }
	    finally {
	    	   //update how many test advertiser accounts that we have 
	    	driver.quit();
	    }
	  }

}
