== CROWDCAST
Iteration 1:
To run the application, have psql running. 
rake db:reset
rake db:migrate
Run rails s in the app folder.

To run tests:
rake test TESTSERVER="#{the url of the localhost}"
ie. rake test TESTSERVER="http://localhost:3000"  
