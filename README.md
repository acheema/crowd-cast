== CROWDCAST
Iteration 1:
To run the application, have psql running. 
rake db:reset
rake db:migrate
Run rails s in the app folder.

To run tests locally:
rake test

or in postman, get
http://crowd-cast.herokuapp.com/api/TESTAPI_tests for the heroku app
or
heroku run rake test RAILS_ENV=test

To use paypal:
username: crowdcast-buyer@gmail.com
password: crowdcast#
