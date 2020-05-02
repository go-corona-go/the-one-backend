# the-one-backend

## Build
### Dev build
```
yarn
```
- install all the dependencies from package.json (This will pull the dependecy versions from yarn.lock)
- tsc - convert all the ts files to js files & put them in the dist folder

## Run in local
After building all the files, run the below command to start the server in local
```
yarn start
```
By default this will start the server on 5001 port. If you want to use your custom port then use PORT env variable to set the custom value

> Accessing GraphQL endpoint
```
http://localhost:5001/api/graphql
```

> Accessing REST endpoint
```
http://localhost:5001/api/{rest-endpoint}
```

### Debug in local
To run the server in debug mode, launch your server from vscode debug launcher using `Start the server in debug mode` launcher

Note: Make sure you set all the env variables in your .env file

### Set environment variables
Set below environment variables in a .env file at the root as shown in the [].env.example]() file
- PORT
- AZURE_STORAGE_CONNECTION_STRING `(To upload the file blob on azure)`


## Deploy to heroku
Note: First, install the [heroku-cli](https://devcenter.heroku.com/articles/heroku-cli)

>Follow the below steps to deploy the master branch to your heroku app (for now app is - wfto-covid19-service)
- Login to heroku in your terminal
```
heroku login
```
This will redirect to the login page in your default browser. Enter your login details => Close the page => Return back to the terminal (You should be logged in now)
- Use git to deploy the master branch to git
```
git push heroku master
```
> To check the deployment logs
```
heroku logs --tail (to check the last few lines of the logs)
heroku logs (to get all the logs)
```

> To see the changes deployed to heroku
- clone the source code from heroku git, to the local machine
```
heroku git:clone -a <app-name>
cd <app-name>
```

### Set environment variables 
App => Settings => config vars
Add all the env variables you're using in your local to the heroku app


## Contributing to the repo
- Try to use as much typescript as possible (Though you have the option to write plain javascipt as well in .ts files)
- Working with GraphQL
  - Add the resolver with the business logic
  - Update the schema to reflect your resolver, its input & output
- Working with REST
  - Create the controller with the business logic
  - Map the controller methods to the specific endpoint & HTTP method in `routers`
  - Map the router in `rest-router.ts`
- All the services used either in the REST or the GrpahQL flow, should be put under `services` folder

### Repo structure
Follow this structure while adding your code to this repo
- Api
  - graphql
    - resolvers
    - schema
  - rest
    - controllers (endpoint controllers)
    - routers (map the rest endpoints with the controller methods)
- services