import gql from 'graphql-tag';
import { makeExecutableSchema } from 'apollo-server';
import { fileUploadResolver, helloWorldResolver } from '../resolvers';

const typeDefs = gql`
  scalar Upload
  type File {
    filename: String!
    link: String!
    lastModified: ID!
  }
  type Query {
    hello: String
  }
  type Mutation {
    uploadFile(file: Upload!): File!
  }
`;

export const schema = makeExecutableSchema({
  typeDefs,
  resolvers: [helloWorldResolver, fileUploadResolver]
});
