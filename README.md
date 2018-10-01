# TSICMS

Content Management System for TSI Course

## Run locally

To install TSICMS locally follow these instructions:

1. **Prerequisite**

	First you need to install the follow packages

 	```
 	nodejs
 	libpq-dev
 	postgresql
 	postgresql-contrib
 	imagemagick
 	```

	Its necessary to install the Bundler and the Rails gems

 	```
 	gem install bundler
 	gem install rails
 	```

2. **Clone the project**

	Clone the project repository using the command

	`git clone git@github.com:TSIDW5/tsicms.git`
	`cd tsicms`

3. **Install dependencies**

	`bundle install`

4. **Set up postgres password**

	`cp config/application.yml.example config/application.yml`

	In this file change postgres username and password and host
    	```
	database: &database
  		db.username: postgres
  		db.password: postgres
  		db.host: localhost
    	```

	After change mailer host and port
	```
	mailer: &mailer
		mailer.host: localhost
		mailer.port: '3000'
	```

5.  **Create the database and the tables**

	```
	$ rails db:create
	$ rails db:migrate
	$ rails db:seed
	```

6. **Run the application**

	```
	$ rails s
	```

	Access the public namespace url [http://localhost:3000](http://localhost:3000)

	Access the url admin namespace [http://localhost:3000/admins](http://localhost:3000/admins)


## Contribute

We hope that you will consider contributing to TSICMS.


### Fork

First perform the fork of the [https://github.com/TSIDW5/tsicms.git](repository)


### Get your fork

Access your profile https://github.com/YourUser
Find repository TSICMS

### Clone it

Run `git clone https://github.com/YourUser/tsicms.git`

### Enter directory

`cd tsicms`

### Point to original repository

`git remote add upstream https://github.com/TSIDW5/tsicms.git`

Now we have two repositories on disk:

1. o _**origin**_, which points to your project fork on GitHub. You have read and write access on this remote.
2. o _**upstream**_, which points to the main project repository in GitHub. You only have read access on this remote.


### Developing your contribution

1. Go to the master branch

    Run `git checkout master`

2. Update the two repositories

    Run `git pull upstream master && git push origin master`

3. Create your branch to develop your contributions, define a name that reminds you of what you are eveloping.

    Run `git checkout -b name-your-branch`

4.  Run the test and ensure that all test are green. We just accpeted functionaly, bug fix, etc. with its respective test.

    Run `Bundle exec rspec`

### Developing with Docker

1. **Prerequisites**
 	```
 	docker
 	docker-compose
 	```
2. **How to Use**

+ Run `docker-compose up -d`
+ Run `docker exec -it web5_app /bin/bash`
+ Run `cd /var/www`

3. **Set up postgres password**

	`cp config/application.yml.example config/application.yml`

	In this file change postgres username and password and host
    	```
	database: &database
  		db.username: postgres
  		db.password: postgres
  		db.host: db
    	```


### Creating Pull Request

After finishing developing you need to submit a request for your contribution to be added to the main repository, for this we use the pull request.

1. First add your changes

    Run `git add .`

    First commit your changes, put a message to define what was done

    Run `git commit -m "Your message"`

2. Send your changes

    Run `git pull upstream master && git push -u origin name-your-branch`


The command creates a branch in your project / fork in GitHub. The -u flag binds this branch to its remote; so in the future, you can simply type git push origin.

Go back to the browser and access your project's fork (https://github.com/YourUser/tsicms) and you'll see that your new branch is listed at the top with a convenient "Compare & pull request"

After clicking on "Compare & pull request" you can send a comment about your pull request

If this is done, wait until the administrator of the source repository accepts or refuses, if you refuse to remember to always get the messages that will come along with the refusal, they will always be present in the reasons for the refusal.


## Copyright
SGE is covered [MIT License](https://opensource.org/licenses/MIT).
