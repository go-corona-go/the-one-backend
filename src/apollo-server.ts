import { ApolloServer } from "apollo-server-express";
import { schema } from "./api/graphql/schema";

export const apolloServer = new ApolloServer({
  schema,
  uploads: {
    // Limits here should be stricter than config for surrounding
    // infrastructure such as Nginx so errors can be handled elegantly by
    // graphql-upload:
    // https://github.com/jaydenseric/graphql-upload#type-processrequestoptions
    maxFileSize: 10000000, // 10 MB
    maxFiles: 20,
  }});