"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const CreateServeyor_1 = require("../controller/surveyor/CreateServeyor");
const GetSurveyor_1 = require("../controller/surveyor/GetSurveyor");
const LoginSurveyor_1 = require("../controller/surveyor/LoginSurveyor");
const FindSurveyorByID_1 = require("../controller/surveyor/FindSurveyorByID");
const ChangePassWord_1 = require("../controller/surveyor/ChangePassWord");
const router = express_1.default.Router();
router.post('/createSurveyor', CreateServeyor_1.CreateSurveyor);
router.get('/getsurveyor', GetSurveyor_1.GetSurveyor);
router.post('/loginSurveyor', LoginSurveyor_1.LoginSurveyor);
router.get('/findSurveyorByID/:token', FindSurveyorByID_1.FindSurveyorByID);
router.post('/changePassWord/:token', ChangePassWord_1.ChangePassWord);
exports.default = router;
