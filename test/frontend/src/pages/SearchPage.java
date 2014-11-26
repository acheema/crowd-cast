package pages;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

public class SearchPage extends NavbarPage{
	
	  public SearchPage(WebDriver driver) {
		    super(driver);
		  }
	  
	  public ViewListingPage clickOnListing(String listingName) {
	      WebElement listing = driver.findElement(By.linkText(listingName));
	      listing.click();
		  return new ViewListingPage(driver);
	  }
	  
	  public SearchPage clickFavorite() {
	      WebElement fave = driver.findElement(By.id("fave"));
	      fave.click();
	      return this;
	  }
	  
	  public SearchPage clickUnfavorite() {
	      WebElement unfave = driver.findElement(By.id("unfave"));
	      unfave.click();
	      return this;
	  }
}
