import * as express from "express";
import { restRouter } from './api/rest/rest-router';


export const app: express.Application = express(); // express app

app.use('/api', restRouter);

app.all("*", (_req, res) => {
  res.json({nothingFound: true})
});
