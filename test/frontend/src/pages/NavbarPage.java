package pages;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.annotations.Test;

import strings.LocatorStrings;

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
	  

}
