import { Response, Request } from 'express';

export const helloController = {
  sayHello(_req: Request, res: Response): void {
    res.status(200).json({ hello: 'world' });
  }
};
