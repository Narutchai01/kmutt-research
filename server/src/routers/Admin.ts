import express from 'express';
import { CreateAdmin } from '../controller/admin/CreateAdmin';
import { loginAdmin } from '../controller/admin/LoginAdmin';
import { getAdminByID } from '../controller/admin/GetAdminByID';
import { getSurveyorByID } from '../controller/admin/Surveyor/getSurveyorByID';
import { getCaseBySurveyorID } from '../controller/admin/Case/getCaseBySurveyorID';
import { getCaseByCaseID } from '../controller/admin/Case/getCaseByCaseID';
import { EditSurveyor } from '../controller/admin/Surveyor/EditSurveyor';
import { getCarByCustomerID } from '../controller/admin/Car/GetCarByCustomerID';
import { GetCustomerByCustomerID } from '../controller/admin/Customer/GetCustomerByCustomerID';
import { EditCustomer } from '../controller/admin/Customer/EditCustomer';
import { EditCaseByID } from '../controller/admin/Case/EditCaseByID';

const router = express.Router();

router.post('/createadmin',CreateAdmin);
router.post('/loginadmin',loginAdmin);
router.get('/getadmin',getAdminByID);
router.get('/getsurveyor/:id',getSurveyorByID);
router.get('/getCaseBySurveyorID/:surveyorID',getCaseBySurveyorID);
router.get('/getCaseByCaseID/:caseId',getCaseByCaseID);
router.put('/updateSurveyor/:id',EditSurveyor);
router.get("/getCarByCustomerID/:CustomerID",getCarByCustomerID);
router.get("/getCustomerByCustomerID/:CustomerID",GetCustomerByCustomerID)
router.put('/updateSurveyor/:id',EditSurveyor);
router.put("/updateCustomer/:id",EditCustomer);
router.put("/updateCase/:caseID",EditCaseByID);        




export default router;