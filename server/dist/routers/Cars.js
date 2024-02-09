"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const AddCar_1 = require("../controller/Car/AddCar");
const GetCars_1 = require("../controller/Car/GetCars");
const GetCarByID_1 = require("../controller/Car/GetCarByID");
// import { GetCarByCustomerID } from "../controller/Car/GetCarByCustomerID";
// import { DeleteCarByID } from "../controller/Car/DeleteCarByID";
const router = express_1.default.Router();
router.post("/addCar", AddCar_1.AddCar);
router.get("/getCars", GetCars_1.GetCars);
router.get("/getCarByID", GetCarByID_1.getCarByID);
// router.get("/getCarByCustomerID/:CustomerID", GetCarByCustomerID);
// router.delete("/deleteCarByID/:id", DeleteCarByID);
exports.default = router;
