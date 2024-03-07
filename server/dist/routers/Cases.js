"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const CreateCase_1 = require("../controller/Cases/CreateCase");
const GetCase_1 = require("../controller/Cases/GetCase");
const FindCaseByID_1 = require("../controller/Cases/FindCaseByID");
const GetcaseByCaseID_1 = require("../controller/Cases/GetcaseByCaseID");
const router = express_1.default.Router();
router.post('/createCase/:token', CreateCase_1.CreateCase);
router.get('/getCase', GetCase_1.GetCase);
router.get('/findCase/:token', FindCaseByID_1.findCaseBySurveyorID);
router.get('/getCaseByCaseID', GetcaseByCaseID_1.GetcaseByCaseID);
exports.default = router;
