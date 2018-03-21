# Heroku Connect Demo
This is a dummy Rails app using Postgres that demonstrates connecting to a Salesforce backend using Heroku Connect. I am using a free Salesforce Developer Edition account to do this.

### Set Up  
If you don't have any of the following, install or register for them first: 
- Register for a free [Heroku account](https://signup.heroku.com/login)
- Download and install [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli)
- Register for a free [Salesforce Developer Edition](https://developer.salesforce.com/signup)

### Initial App
First, I generated a new Rails app without any models, using a postgres db.
```
rails new my_hc_demo --database=postgresql
```
You can double check that your app uses postgres by checking the `config/database.yml` file. 

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

### Translation between Salesforce and Heroku Postgres
When you map objects, Heroku Connect will create or update the database tables used to store data for the mapped object. [This page from the Heroku Connect documentation site](https://devcenter.heroku.com/articles/heroku-connect-database-tables) is very helpful in describing exactly how Salesforce objects get translated to objects in the Postgres database. I've copied and pasted some of the most important ideas and sections from that site below:  

**[Database table structure](https://devcenter.heroku.com/articles/heroku-connect-database-tables#database-table-structure)**
- Mapping tables use a lowercase version of the Salesforce object name, for example the `Account` Salesforce object is mapped to the `account` database table.
- Column names use a lowercase version of the Salesforce field name, for example the `AccountNumber` Salesforce field is mapped to the `accountnumber` database column.
- Creating a new mapping creates a new database table that Heroku Connect will automatically populate with data from Salesforce.
- Editing an existing mapping will modify the existing database table using `ALTER TABLE` SQL commands. Heroku Connect will populate any newly mapped fields with data from Salesforce.  

**Another note from Heroku:**  
You should avoid creating mapped tables yourself. Heroku Connect will not replace an existing table when creating a new mapping and therefore, if the table is not created correctly, you will experience errors when syncing data.  

**[Querying mapped tables](https://devcenter.heroku.com/articles/heroku-connect-database-tables#querying-mapped-tables)**  
Mapped tables can be queried like any other table in your Postgres database. You will need to qualify table names with the schema name you chose when provisioning the add-on, for example using the default salesforce schema name:
```
SELECT * FROM salesforce.account;
```

### Working with your Heroku Postgres database
[This Heroku documentation page](https://devcenter.heroku.com/articles/getting-started-with-rails5) describes how to use Rails in Heroku. Relevant commands:
- `heroku run rake db:migrate`
- `heroku open` to visit app in browser
- `heroku run rails console`
- `heroku pg:psql` to access your database  

To check that our Salesforce objects are in our database, we can run
```
heroku pg:psql
rocky-brook-29385::DATABASE=> select * from salesforce.account;
rocky-brook-29385::DATABASE=> select * from salesforce.contact;
```
To look at the schema of these tables, run
```
rocky-brook-29385::DATABASE=> \d salesforce.account
                                           Table "salesforce.account"
     Column     |            Type             |                            Modifiers                            
----------------+-----------------------------+-----------------------------------------------------------------
 createddate    | timestamp without time zone | 
 isdeleted      | boolean                     | 
 name           | character varying(255)      | 
 systemmodstamp | timestamp without time zone | 
 accountnumber  | character varying(40)       | 
 billingcity    | character varying(40)       | 
 sfid           | character varying(18)       | 
 id             | integer                     | not null default nextval('salesforce.account_id_seq'::regclass)
 _hc_lastop     | character varying(32)       | 
 _hc_err        | text                        | 
 ...
rocky-brook-29385::DATABASE=> \d salesforce.contact
                                           Table "salesforce.contact"
     Column     |            Type             |                            Modifiers                            
----------------+-----------------------------+-----------------------------------------------------------------
 lastname       | character varying(80)       | 
 accountid      | character varying(18)       | 
 name           | character varying(121)      | 
 isdeleted      | boolean                     | 
 systemmodstamp | timestamp without time zone | 
 createddate    | timestamp without time zone | 
 firstname      | character varying(40)       | 
 email          | character varying(80)       | 
 sfid           | character varying(18)       | 
 id             | integer                     | not null default nextval('salesforce.contact_id_seq'::regclass)
 _hc_lastop     | character varying(32)       | 
 _hc_err        | text                        | 
...
```

To quit out of the shell, run `\q`. 


### Generating Rails Scaffold
Based on the schemas and the fields we want for each model, we can generate them like so:
```
rails generate scaffold Account name:string accountnumber:string billingcity:string sfid:string isdeleted:boolean
rails generate scaffold Contact firstname:string lastname:string email:string accountid:string sfid:string isdeleted:boolean
git add .
git commit -m "Generated scaffolds"
git push heroku master
heroku run rails db:setup
heroku run rails db:migrate
```


