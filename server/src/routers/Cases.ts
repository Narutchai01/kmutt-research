import exporess from 'express';
import { CreateCase } from '../controller/Cases/CreateCase';
import { GetCase } from '../controller/Cases/GetCase';
const router = exporess.Router();

router.post('/createCase', CreateCase);
router.get('/getCase', GetCase);



export default router;