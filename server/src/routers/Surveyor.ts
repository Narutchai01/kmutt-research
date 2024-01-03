import express from 'express';
import { CreateSurveyor} from '../controller/Surveyor/SurveyorController';
import { LoginSurveyor } from '../controller/Surveyor/LoginSurveyor';

const router = express.Router();


router.post('/createsurveyor', CreateSurveyor);
// router.get('/getallsurveyor', getSurveyor)
router.post('/loginSurveyor', LoginSurveyor)
export default router;