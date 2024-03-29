"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const CreateAdmin_1 = require("../controller/admin/CreateAdmin");
const LoginAdmin_1 = require("../controller/admin/LoginAdmin");
const GetAdminByID_1 = require("../controller/admin/GetAdminByID");
const getSurveyorByID_1 = require("../controller/admin/Surveyor/getSurveyorByID");
const getCaseBySurveyorID_1 = require("../controller/admin/Case/getCaseBySurveyorID");
const getCaseByCaseID_1 = require("../controller/admin/Case/getCaseByCaseID");
const EditSurveyor_1 = require("../controller/admin/Surveyor/EditSurveyor");
const GetCarByCustomerID_1 = require("../controller/admin/Car/GetCarByCustomerID");
const GetCustomerByCustomerID_1 = require("../controller/admin/Customer/GetCustomerByCustomerID");
const EditCustomer_1 = require("../controller/admin/Customer/EditCustomer");
const EditCaseByID_1 = require("../controller/admin/Case/EditCaseByID");
const router = express_1.default.Router();
router.post('/createadmin', CreateAdmin_1.CreateAdmin);
router.post('/loginadmin', LoginAdmin_1.loginAdmin);
router.get('/getadmin', GetAdminByID_1.getAdminByID);
router.get('/getsurveyor/:id', getSurveyorByID_1.getSurveyorByID);
router.get('/getCaseBySurveyorID/:surveyorID', getCaseBySurveyorID_1.getCaseBySurveyorID);
router.get('/getCaseByCaseID/:caseId', getCaseByCaseID_1.getCaseByCaseID);
router.put('/updateSurveyor/:id', EditSurveyor_1.EditSurveyor);
router.get("/getCarByCustomerID/:CustomerID", GetCarByCustomerID_1.getCarByCustomerID);
router.get("/getCustomerByCustomerID/:CustomerID", GetCustomerByCustomerID_1.GetCustomerByCustomerID);
router.put('/updateSurveyor/:id', EditSurveyor_1.EditSurveyor);
router.put("/updateCustomer/:id", EditCustomer_1.EditCustomer);
router.put("/updateCase/:caseID", EditCaseByID_1.EditCaseByID);
exports.default = router;
