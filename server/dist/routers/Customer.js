"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const addCustomer_1 = require("../controller/Customer/addCustomer");
const getCustomer_1 = require("../controller/Customer/getCustomer");
const router = express_1.default.Router();
router.post("/addCustomer", addCustomer_1.addCustomer);
router.get("/getCustomer", getCustomer_1.getCustomer);
exports.default = router;
