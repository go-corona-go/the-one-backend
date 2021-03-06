import { ApolloServer } from 'apollo-server-express';
import { schema } from './api/graphql/schema';
import { FileUploadService } from './services/file-upload-service';

export const apolloServer = new ApolloServer({
  schema,
  uploads: {
    // Limits here should be stricter than config for surrounding
    // infrastructure such as Nginx so errors can be handled elegantly by
    // graphql-upload:
    // https://github.com/jaydenseric/graphql-upload#type-processrequestoptions
    maxFileSize: 5 * 1024 * 1024, // 5 MB
    maxFiles: 1
  },
  introspection: true,
  context: {
    fileUploadService: new FileUploadService()
  }
});
