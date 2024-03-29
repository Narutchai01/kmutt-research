import express from 'express';
import { CreateSurveyor } from '../controller/surveyor/CreateServeyor';
import { GetSurveyor } from '../controller/surveyor/GetSurveyor';
import { LoginSurveyor } from '../controller/surveyor/LoginSurveyor';
import { FindSurveyorByID } from '../controller/surveyor/FindSurveyorByID';
import { ChangePassWord } from '../controller/surveyor/ChangePassWord';
import { DeleteSurveyorByID } from '../controller/surveyor/DeleteSurveyorByID';

const router = express.Router();

router.post('/createSurveyor',CreateSurveyor);
router.get('/getsurveyor',GetSurveyor);
router.post('/loginSurveyor',LoginSurveyor);
router.get('/findSurveyorByID/:token', FindSurveyorByID);
router.post('/changePassWord/:token',ChangePassWord);
router.delete('/deleteSurveyorByID/:id',DeleteSurveyorByID);

export default router;