import { Router } from 'express';
import { helloRouter } from "./routers/hello-router";

export const restRouter: Router = Router();
restRouter.use('/hello', helloRouter);