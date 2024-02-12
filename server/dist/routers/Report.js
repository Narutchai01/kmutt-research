"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const GetReport_1 = require("../controller/Report/GetReport");
const router = express_1.default.Router();
router.get("/get-report", GetReport_1.GetReport);
exports.default = router;
