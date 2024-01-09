import exporess from 'express';
import { CreateCase } from '../controller/Cases/CreateCase';
const router = exporess.Router();

router.post('/createCase', CreateCase)



export default router;