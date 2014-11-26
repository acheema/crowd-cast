package pages;

import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

public class NavbarPage extends Page{

	/* Functions that correspond to navbar */

	  public NavbarPage(WebDriver driver) {
		    super(driver);
		  }
	  
	  public void clickOnUserDropdown() {
	      WebElement dropdown = driver.findElement(By.id("user-dropdown-toggle"));
	      dropdown.click();
	  }
	  
	  public DashboardPage clickOnLogoLoggedIn() {
	      WebElement logo = driver.findElement(By.id("d-logo"));
	      logo.click();
	      return new DashboardPage(driver);

	  }
	  
	  public FrontPage clickOnLogoLoggedOut() {
	      WebElement logo = driver.findElement(By.id("d-logo"));
	      logo.click();
	      return new FrontPage(driver);
	  }
	  
	  public FrontPage clickLogout() {
	      WebElement logo = driver.findElement(By.className("signout-link"));
	      logo.click();
	      return new FrontPage(driver);
	  }
	  
	  public MyAccountPage clickMyAccount() {
	      WebElement myAcc = driver.findElement(By.id("link-my-account"));
	      myAcc.click();
	      return new MyAccountPage(driver);
	  }
	  
	  public NewAdvertisementPage clickNewAd() {
	      WebElement ad = driver.findElement(By.id("add-ad-button"));
	      ad.click();
	      return new NewAdvertisementPage(driver);

	  }
	  
	  public SearchPage search(String city) {
	      WebElement sb = driver.findElement(By.id("searchbar"));
	      sb.sendKeys(city);
	      sb.sendKeys(Keys.ENTER);
	      return new SearchPage(driver);
	  }

}
