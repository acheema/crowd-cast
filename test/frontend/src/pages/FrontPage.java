package pages;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

public class FrontPage extends NavbarPage {
	

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
		  public FrontPage clickSignup() {
		      WebElement signupButton = driver.findElement(By.id("signupmodalbutton"));

		      signupButton.click();
			  return this;
		  }
		  
		  public SearchPage signupAdv(String username, String pass, String email, String co) {
		      WebElement signupButton = driver.findElement(By.id("signup"));
		      WebElement usernameInput = driver.findElement(By.id("username-signup"));
		      WebElement passwordInput = driver.findElement(By.id("password-signup"));
		      WebElement emailInput = driver.findElement(By.id("email-signup"));
		      WebElement coInput = driver.findElement(By.id("company-signup"));
		      WebElement adOption = driver.findElement(By.id("advertiser-option"));
		      adOption.click();
		      usernameInput.sendKeys(username);
			  passwordInput.sendKeys(pass);
			  emailInput.sendKeys(email);
			  coInput.sendKeys(co);
			  signupButton.click();
			  
			  return new SearchPage(driver);
		  }
		  public NewListingPage signUpOwner(String username, String pass, String email, String co) {
		      WebElement signupButton = driver.findElement(By.id("signup"));
		      WebElement usernameInput = driver.findElement(By.id("username-signup"));
		      WebElement passwordInput = driver.findElement(By.id("password-signup"));
		      WebElement emailInput = driver.findElement(By.id("email-signup"));
		      WebElement coInput = driver.findElement(By.id("company-signup"));
		      WebElement adOption = driver.findElement(By.id("owner-option"));
		      adOption.click();
		      usernameInput.sendKeys(username);
			  passwordInput.sendKeys(pass);
			  emailInput.sendKeys(email);
			  coInput.sendKeys(co);
			  signupButton.click();
			  
			  return new NewListingPage(driver);
		  }
		 
		  
		  public DashboardPage loginSuccess(String username, String password) {
		      WebElement innerLoginButton = driver.findElement(By.id("login"));
		      WebElement usernameInput = driver.findElement(By.id("username-login"));
		      WebElement passwordInput = driver.findElement(By.id("password-login"));
		      
			  usernameInput.sendKeys(username);
			  passwordInput.sendKeys(password);
			  innerLoginButton.click();
			  return new DashboardPage(driver);  
		  }
		  
		  
	
		  
		  
}
