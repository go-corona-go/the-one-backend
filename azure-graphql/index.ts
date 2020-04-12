import { AzureFunction } from "@azure/functions"
import { ApolloServer } from "apollo-server-azure-functions";
import { helloWorldResolver, typeDefs } from "../src/api/graphql";


const server = new ApolloServer({
    typeDefs,
    resolvers: [
        helloWorldResolver
    ],
});

const httpTrigger: AzureFunction = server.createHandler({
    cors: {
        origin: '*',
        credentials: true,
        allowedHeaders: 'Content-Type, Authorization'
    },
});

export default httpTrigger;