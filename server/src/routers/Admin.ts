import express from 'express';
import { CreateAdmin } from '../controller/admin/CreateAdmin';
import { loginAdmin } from '../controller/admin/LoginAdmin';
import { getAdminByID } from '../controller/admin/GetAdminByID';
import { getSurveyorByID } from '../controller/admin/Surveyor/getSurveyorByID';
import { getCaseBySurveyorID } from '../controller/admin/Case/getCaseBySurveyorID';

const router = express.Router();

router.post('/createadmin',CreateAdmin);
router.post('/loginadmin',loginAdmin);
router.get('/getadmin',getAdminByID);
router.get('/getsurveyor/:id',getSurveyorByID);
router.get('/getCaseBySurveyorID/:surveyorID',getCaseBySurveyorID);




export default router;