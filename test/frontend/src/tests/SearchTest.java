package tests;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.annotations.Test;

import pages.FrontPage;
import pages.SearchPage;

public class SearchTest {
	
	 @Test 
	  public void searchTest() {
			  
	    WebDriver driver = new FirefoxDriver();
	      
	    try {
	        // Each test method needs to create it's own driver instance
	        FrontPage f = new FrontPage(driver).open();
	       SearchPage s = f.search("San Francisco");
	       
	       WebDriverWait wait = new WebDriverWait(driver, 10);
	       wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("googlemap")));
	       String curUrl = s.getUrl();
	       assert curUrl.contains("city=San+Francisco"): "Expected search url to contain city that we searched for (SF) but got: " + curUrl;
	    }
	    finally {
	    	driver.quit();
	    }
	  }

}
