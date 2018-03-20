# Heroku Connect Demo
This is a dummy Rails app using Postgres that demonstrates connecting to a Salesforce backend using Heroku Connect. I am using a free Salesforce Developer Edition account to do this. 

### Deploying to Heroku
After cloning this repo, within the repo do: 
```
heroku create
heroku addons:create herokuconnect:demo
heroku addons:add papertrail
git push heroku master
```
Then go to https://dashboard.heroku.com/apps to locate your app and check that Heroku Connect is there as an add-on. 
