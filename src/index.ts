import { app } from './server';
import { config } from 'dotenv';

config();
const port = process.env.PORT || 5001;

app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
