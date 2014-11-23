package pages;

import org.openqa.selenium.WebDriver;

public abstract class Page {

	  protected WebDriver driver = null;

	  protected Page(WebDriver driver) {
	    this.driver = driver;
	  }
	    
		  public String getUrl() {
			  return driver.getCurrentUrl();
		  }
}