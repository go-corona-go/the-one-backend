import * as express from 'express';
import { restRouter } from './api/rest/rest-router';
import { apolloServer } from './apollo-server';

export const app: express.Application = express(); // express app

app.use('/api', restRouter);

apolloServer.applyMiddleware({ app, path: '/api/graphql' });

app.all('*', (_req, res) => {
  res.json({ nothingFound: true });
});
