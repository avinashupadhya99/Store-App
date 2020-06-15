# STORE APP

This is an simple Ruby on Rails application used to manage inventories and orders of a store.


## Developer Documentation

### Requirements

1. Docker
2. Docker Compose
3. An editor of your choice (VS Code, Sublime, Atom, etc)

### Clone Repository

```
git clone https://github.com/avinashupadhya99/Store-App.git
```

> *Note:* The above command clones over HTTP anonymously. If you have Github account and configured SSH keys then you must clone over SSH to push changes to your forked repository.

### Setting up Development Environment

Create a file named `.env` in source root with the following contents

```
RAILS_ENV=development

MYSQL_SERVER=db
MYSQL_DATABASE=storedb
MYSQL_USERNAME=root
MYSQL_PASSWORD=storedbpassword

```

Create a file named `.env.mysql` in source root with the following content

```
MYSQL_ROOT_PASSWORD=storedbpassword
```

Start the application server and MySQL using the command-

```
docker-compose up
```

This will build the docker image based on `Dockerfile` and bring up

1. MySQL Server
2. Rails Application Server (in Development Mode)

Once both the containers are running, point your browser to `http://localhost:8800`.

### Creating an admin user
To access the application, you need to first create an admin user and then the admin can create other employees.
The following command will create an admin user-

```
docker-compose run app rake db:seed
```
Run this command only after running ``` docker-compose up ``` once before. 
This will create an admin user with the credenatials **admin@store.com** and password **password**. You can edit these after logging in or before seeding in the `db/seeds.rb`.
