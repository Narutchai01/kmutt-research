import exporess from 'express';
import { CreateCase } from '../controller/Cases/CreateCase';
import { GetCase } from '../controller/Cases/GetCase';
import { findCaseBySurveyorID } from '../controller/Cases/FindCaseByID';
const router = exporess.Router();

router.post('/createCase/:token', CreateCase);
router.get('/getCase', GetCase);
router.get('/findCase/:token', findCaseBySurveyorID);



export default router;