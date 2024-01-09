import express from 'express';
import { CreateSurveyor } from '../controller/surveyor/CreateServeyor';
import { GetSurveyor } from '../controller/surveyor/GetSurveyor';
import { LoginSurveyor } from '../controller/surveyor/LoginSurveyor';
import { FindSurveyorByID } from '../controller/surveyor/FindSurveyorByID';

const router = express.Router();

router.post('/createSurveyor',CreateSurveyor);
router.get('/getsurveyor',GetSurveyor);
router.post('/loginSurveyor',LoginSurveyor);
router.get('/findSurveyorByID/:id', FindSurveyorByID);

export default router;