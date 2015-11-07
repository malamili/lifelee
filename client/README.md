# Weaver

Powerful app building made simple for everybody.

## Development

### How to run

#### Install prerequisites
Install redis, npm, grunt and bower if not done so already.

1. brew install npm
2. brew install redis
3. npm install grunt-cli -g
4. npm install bower -g
5. brew install imagemagick (for favicon generation)

#### Install Weaver

##### Weaver Client

1. cd client
2. npm install
3. bower install

##### Weaver Server

1. cd server
2. npm install


#### Run Weaver

##### Weaver Client
1. cd client
2. grunt serve

##### Weaver Server
1. redis-server
2. cd server
3. nodemon main.coffee


## How to test

## How to build

1. grunt build
2. production files will be ready in the /dist folder


## Production


# Production: How to run it


# Technology stack

## Languages
- CoffeeScript
- JavaScript
- JSX
- LESS

## Frameworks
- Bootstrap
- AngularJS
- React

## Database
- Redis

## Tooling
- Fontello

## Testing framework
- Karma
- Jasmine

## Build system
- NPM
- Bower
- Grunt

## Run system
- Node & Forever
- nginx for serving client

## Libraries
- Socket.io
- localForage
- Cuid
- FingerpringJS
- Evercookie

## Angular Modules
- ui.router
- ui.bootstrap
- ngReact
- restangular
- btford.socket-io
- angular-cache
- angular-localForage
- chronicle
- angularjs-geolocation

## Future Migrations
- AngularJS 1.x to AngularJS 2
- CoffeeScript to TypeScript (due to AngularJS 2)


# Server

# Tech stack:

- Node
- Express
- Socket.io
- Redis

- RabbitMQ
- Java for CPU intensive stuff

## Structure

Partly based on the yeoman angular-fullstack generator, partly based on


# Naming conventions

- Controllers als UpperCamelCase and end with 'Ctrl'
- Services are UpperCamelCase
- variables are lowerCamelCase
- file names are lowercase-file-name


# Role of server


  	# Logic mostly in client, keep server atomic


# Hacks!
In angular-bootstrap-contextmenu added event.stopPropagation() in the context menu function, and allowed HTML
with the following line: (25)                 $a.html(typeof item[0] == 'string' ? item[0] : item[0].call($scope, $scope));


# Future libraries
- angular-ui-tree



## Server

### Role
* Data restriction
* Data manipulation
* Data notification


### Redis Schema

#### STRINGS

##### ID's that can increment to get a new id
* id_user
* id_project
* id_dataset
* id_model
* id_object
* id_app

##### Mappings
 Key           | Value       | Description
-------------- |-------------|--------------
user:cid:(cid) | cid         | client id -> user id

#### SETS

##### Collection of all models for quick reference

* tokens
* users
* projects
* datasets
* models
* objects
* apps


#### HASHES

##### token:(token value)
 Key           | Value       | Description
-------------- |-------------|--------------
active         | true / false| If the token is still active
user           | user id     | ID of the user belonging to this token


##### user:(id)
 Key           | Value       | Description
-------------- |-------------|--------------
cid            | cid         | Client ID generated on the client
name           | name        | Full name of the user

