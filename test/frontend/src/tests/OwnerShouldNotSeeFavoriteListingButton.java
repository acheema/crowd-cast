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

public class OwnerShouldNotSeeFavoriteListingButton {
	 @Test 
	 /* Owner shouldn't see favorite listing or reserve on view listing page */
	  public void ownerShouldNotSeeCertainButtonsTest() {
			  
	    WebDriver driver = new FirefoxDriver();
	      
	    try {
	        FrontPage f = new FrontPage(driver).open().clickLogin();
	        WebDriverWait wait = new WebDriverWait(driver, 10);
	        WebElement element = wait.until(ExpectedConditions.elementToBeClickable(By.id("login")));
	        String credentials = LocatorStrings.UsernameOwner;
	        f.loginSuccess(credentials,credentials);
	        
	        wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("create-listing-button")));
	        SearchPage s =  f.search("San Francisco");
	        s.clickOnListing("SJKFLSSDF");
	        
	        assert driver.findElements(By.id("fave")).size() < 1: "Owners shouldn't see favorite listing button";
	        
	    }
	    finally {
	    	driver.quit();
	    }
	  }
}
