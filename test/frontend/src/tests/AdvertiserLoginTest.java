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
public class AdvertiserLoginTest {
 
  @Test 
  public void advertiserLoginTest() {
		  
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
        String curUrl = f.getUrl();
        assert curUrl.contains("search"): "expected advertiser to be taken to search page after logging in, but got this url instead: " + curUrl;
    }
    finally {
    	driver.quit();
    }
  }
}
