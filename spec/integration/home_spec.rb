require 'spec_helper'

describe "People" do
  before(:all) do
    @verification_errors = []

    @browser = Selenium::Client::Driver.new(
      :host => "localhost",
      :port => 4444,
      :browser => "*firefox"
      :url => "http://localhost:3000",
      :timeout_in_second => 90)

    @browser.start
  end

  before(:each) do
    @browser.start_new_browser_session
  end

  append_after(:each) do
    @browser.close_current_browser_session
    @verification_errors.should == []
  end

  it "should create a new Person with valid input" do
    @browser.open "/""
  end
end
