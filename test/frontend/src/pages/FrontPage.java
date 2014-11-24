package pages;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

public class FrontPage extends Page{
	

	  public FrontPage(WebDriver driver) {
		    super(driver);
		  }

		  public FrontPage open() {
		    // Navigate to base URL
		    driver.get("localhost:3000");
		    return this;
		  }
		  
		  public FrontPage clickLogin() {
		      WebElement loginButton = driver.findElement(By.id("loginmodalbutton"));
			  loginButton.click();
			  return this;
		  }
		  
		  public FrontPage loginFail(String username, String password) {
		      WebElement innerLoginButton = driver.findElement(By.id("login"));
		      WebElement usernameInput = driver.findElement(By.id("username-login"));
		      WebElement passwordInput = driver.findElement(By.id("password-login"));
		      
			  // Expecting a failure to occur
			  usernameInput.sendKeys(username);
			  passwordInput.sendKeys(password);
			  innerLoginButton.click();
			  return this;  
		  }
		  
		  public DashboardPage loginSuccess(String username, String password) {
			  WebElement loginButton = driver.findElement(By.id("loginmodalbutton"));
			  loginButton.click();
		      WebElement innerLoginButton = driver.findElement(By.id("login"));
		      WebElement usernameInput = driver.findElement(By.id("username-login"));
		      WebElement passwordInput = driver.findElement(By.id("password-login"));
		      
			  // Expecting a failure to occur
			  usernameInput.sendKeys(username);
			  passwordInput.sendKeys(password);
			  innerLoginButton.click();
			  return new DashboardPage(driver);  
		  }
		  
		  
		  public FrontPage signUp() {
			  return this;
		  }
		  
}
