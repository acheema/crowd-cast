package tests;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.annotations.Test;

import pages.FrontPage;
import strings.LocatorStrings;


@Test
public class LoginLogout {
 
  @Test 
  public void loginLogout() {
		  
    WebDriver driver = new FirefoxDriver();
      
    try {
        // Each test method needs to create it's own driver instance
        FrontPage f = new FrontPage(driver).open().clickLogin();
        WebDriverWait wait = new WebDriverWait(driver, 10);
        WebElement element = wait.until(ExpectedConditions.elementToBeClickable(By.id("login")));
        String credentials = LocatorStrings.UsernameAdvertiser;
        
        f.loginSuccess(credentials,credentials);
        // assert that after an advertiser logs in, they are directed to the search page
        wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("add-ad-button")));
       f.clickOnUserDropdown();
       FrontPage endFrontPage = f.clickLogout();
       endFrontPage.clickOnLogoLoggedOut();
       // after logging out, try clicking on logo. should lead back to main page
       assert !endFrontPage.getUrl().contains("dashboard"): "After logging out, clicking on logo shouldn't reach lead us to the dashboard";
    }
    finally {
    	driver.quit();
    }
  }
}
