package tests;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.annotations.Test;

import pages.DashboardPage;
import pages.FrontPage;
import pages.SearchPage;
import strings.LocatorStrings;

public class FavoriteListingTest {

	 public void favoriteListingTest() {
			  
	    WebDriver driver = new FirefoxDriver();
	      
	    try {
	        FrontPage f = new FrontPage(driver).open().clickLogin();
	        WebDriverWait wait = new WebDriverWait(driver, 10);
	        WebElement element = wait.until(ExpectedConditions.elementToBeClickable(By.id("login")));
	        String credentials = LocatorStrings.UsernameAdvertiser;
	        f.loginSuccess(credentials,credentials);
	        
	        wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("add-ad-button")));
	        SearchPage s =  f.search("San Francisco");
	        // depends on database
	        s.clickOnListing("SJKFLSSDF");
	        s.clickFavorite();	        
	        DashboardPage d = s.clickOnLogoLoggedIn();
	        assert (d.likedListing("sjkflssdf") == true): "Could not find favorited listing on dashboard page";
	        
	        // unfave to pass other tests
	        SearchPage s2 =  f.search("San Francisco");
	        // depends on database
	        s2.clickOnListing("SJKFLSSDF");
	        s2.clickUnfavorite();
	    }
	    finally {
	    	
	    	driver.quit();
	    }
	  }
}