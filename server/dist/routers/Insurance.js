"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const addInsurance_1 = require("../controller/Insurance/addInsurance");
// import { getInsurance } from "../controller/Insurance/GetInsurance";
const router = express_1.default.Router();
router.post("/addInsurance", addInsurance_1.addInsurance);
// router.get("/getInsurance", getInsurance);
exports.default = router;
