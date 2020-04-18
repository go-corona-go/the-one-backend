import { AzureFunction, Context, HttpRequest } from "@azure/functions"
import { ApolloServer } from "apollo-server-azure-functions";
import { schema } from "../src/api/graphql";



const server = new ApolloServer({schema});

const httpTrigger: AzureFunction = async function (context: Context, req: HttpRequest): Promise<void> {
    context.log('HTTP trigger function processed a request.', req);
    server.createHandler()(context, req);
}
export default httpTrigger;