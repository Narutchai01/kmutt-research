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
import {auth } from '../middleware/auth';
import { GetSurveyor } from '../controller/surveyor/GetSurveyor';
import { GetCars } from '../controller/Car/GetCars';
import { GetCase } from '../controller/Cases/GetCase';
import { getCustomer } from '../controller/Customer/getCustomer';
import { getInsurance } from '../controller/Insurance/GetInsurance';
import { cardCounter } from '../controller/admin/Chart/CardCounter';
import { ChartLine } from '../controller/admin/Chart/ChartLine';
import { ChartDoughnut } from '../controller/admin/Chart/ChartDoughnut';
import { ChartBar } from '../controller/admin/Chart/ChartBar';



const router = express.Router();

router.post('/createadmin',auth,CreateAdmin);
router.post('/loginadmin',loginAdmin);
router.get('/getadmin',auth,getAdminByID);
router.get('/getsurveyor/:id',auth,getSurveyorByID);
router.get('/getCaseBySurveyorID/:surveyorID',auth,getCaseBySurveyorID);
router.get('/getCaseByCaseID/:caseId',auth,getCaseByCaseID);
router.put('/updateSurveyor/:id',auth,EditSurveyor);
router.get("/getCarByCustomerID/:CustomerID",auth,getCarByCustomerID);
router.get("/getCustomerByCustomerID/:CustomerID",auth,GetCustomerByCustomerID)
router.put('/updateSurveyor/:id',auth,EditSurveyor);
router.put("/updateCustomer/:id",auth,EditCustomer);
router.put("/updateCase/:caseID",auth,EditCaseByID);        
router.get('/getsurveyor',auth,GetSurveyor)
router.get("/getCars",auth,GetCars);
router.get("/getCase",auth,GetCase)
router.get("/getCustomer",auth,getCustomer)
router.get("/getInsurance",auth,getInsurance)
router.get("/getChartCard",auth,cardCounter)
router.get("/getChartLine",auth,ChartLine)
router.get("/getChartDoughnut",auth,ChartDoughnut)
router.get("/getChartBar",auth,ChartBar)





export default router;