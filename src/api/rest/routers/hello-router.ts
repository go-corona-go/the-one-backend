import { Router } from 'express';
import { helloController } from '../controllers/hello-controller';

export const helloRouter: Router = Router();

helloRouter.route('/').get(helloController.sayHello);
