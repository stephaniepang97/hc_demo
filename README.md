# Heroku Connect Demo
This is a dummy Rails app using Postgres that demonstrates connecting to a Salesforce backend using Heroku Connect. I am using a free Salesforce Developer Edition account to do this.

### Initial App
I generated a new Rails app without any models.

### Deploying to Heroku
After cloning this repo, within the repo do: 
```
heroku create
heroku addons:create herokuconnect:demo
heroku addons:add papertrail
git push heroku master
```
Then go to https://dashboard.heroku.com/apps to locate your app and check that Heroku Connect is there as an add-on. 

### On the Heroku Dashboard
Click on Heroku Connect > Set Up Connection > Next > Authorize > Sign into your Salesforce account.  
Scroll down to the Mappings section. Here is where you can add mappings between your Rails Postgres db and your Salesforce backend. 

Create Mapping: Contact 
  - Add attributes Account ID, Email, First name , Last name  
Create Mapping: Account  
  - Add attributes Account Number, Billing City  

To poll (sync) data:  
  - Click on the Contact or Account mapping and on the right side, click Poll Now.  
