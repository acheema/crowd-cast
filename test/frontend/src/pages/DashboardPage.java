package pages;

import java.util.Iterator;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

public class DashboardPage extends NavbarPage{
	  public DashboardPage(WebDriver driver) {
		    super(driver);
		  }
	  
	  public DashboardPage clickMyAds() {
	      WebElement myAds = driver.findElement(By.id("my-advs"));
	      myAds.click();
		  return this;
	  }
	 
	  public boolean getMyAds(String targetAd) {
	      WebElement adTable = driver.findElement(By.id("ad-table"));

		    List<WebElement> tableSettings = adTable.findElements(By.tagName("tr"));
		    
		    String[] adList = new String[tableSettings.size()];
		    
		    int countAds = 0;
		    Iterator<WebElement> ads = tableSettings.iterator();
		    while(ads.hasNext()){
			     if (ads.next().getText() == targetAd) {
			    	 return true;
			     }
	  }
		    
		    return false;
	  }
	  
	  public boolean likedListing(String listingTitle) {
	        return driver.findElements(By.linkText("listingTitle")).size() >= 1;
	  }
}
