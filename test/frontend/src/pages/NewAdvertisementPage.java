package pages;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

public class NewAdvertisementPage extends NavbarPage {
	

	  public NewAdvertisementPage(WebDriver driver) {
		    super(driver);
		  }

	  public void fillInFields(String title, String height, String width, String desc) {
	      WebElement tit = driver.findElement(By.id("advertisement_title"));
	      WebElement h = driver.findElement(By.id("advertisement_height"));
	      WebElement w = driver.findElement(By.id("advertisement_width"));
	      WebElement description = driver.findElement(By.id("advertisement_description"));

	      tit.sendKeys(title);
	      h.sendKeys(height);
	      w.sendKeys(width);
	      description.sendKeys(desc);
	  }
	  
	  public NewAdvertisementPage submitAdFail() {
	      WebElement submitAd = driver.findElement(By.id("submit-ad"));
	      submitAd.click();
	      return this;
	  }
	  
	  public DashboardPage submitAdSuccess(boolean pic) {
		  WebElement submitAd;
		  if (pic) {
		       submitAd = driver.findElement(By.id("submit-ad-pic"));

		  }
		  else {
		       submitAd = driver.findElement(By.id("submit-ad-nopic"));

		  }
 	      submitAd.click();
	      return new DashboardPage(driver);
	  }
}
