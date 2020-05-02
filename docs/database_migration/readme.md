# Steps to migrate database schema between different servers.
- We already have a schema of the databse with name **up.sql** in same folder. This can be used unless there is no change is schema and up.sql is not updated with it.
- To setup migration from command line [Hasura Cli](https://hasura.io/docs/1.0/graphql/manual/hasura-cli/install-hasura-cli.html#install-hasura-cli) needs to be installed
- Steps mentioned below are taken from [Hasura migration docs](https://hasura.io/docs/1.0/graphql/manual/migrations/config-v1/manage-migrations.html#manage-migrations-v1). Adding the steps below explicitly incase site gets update with newer version of docs. This can be taken as reference as tested way to migrate database schema.
1. `hasura init --directory my-project --endpoint <hasura-server-endpoint>` where `<hasura-server-endpoint>` looks like *https://wfto-covid19-dev.herokuapp.com/* in this case.
2. `cd my-project`
3. `hasura migrate create "init" --from-server`. This step outputs a version please note it down, it will be reuired in next step.
4. `hasura migrate apply --version "<version>" --skip-execution` version in this case is the one we noted in step above.
5. **Optional Step** If you want to check if you have all the migraitons locally you can run `hasura console` this will launch the hasura console UI hosted on your local server.
6. `hasura migrate apply --endpoint <new-hasura-server-endpoint>` where `<new-hasura-server-endpoint>` is the url of new hasura server where you want to migrate your database.

When this was applied we found a error where if schema contains enum applying schema to new server was failing. This is a known issue at Hasura fix to the issue is [linked here](https://github.com/hasura/graphql-engine/issues/3142#issuecomment-542367937).