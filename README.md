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

## Deploy to heroku

## Contributing to the repo