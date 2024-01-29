import express from "express";
import { AddCar } from "../controller/Car/AddCar";
import { GetCars } from "../controller/Car/GetCars";
import { getCarByID } from "../controller/Car/GetCarByID";
import { GetCarByCustomerID } from "../controller/Car/GetCarByCustomerID";

const router = express.Router();

router.post("/addCar", AddCar);
router.get("/getCars", GetCars);
router.get("/getCarByID", getCarByID);
router.get("/getCarByCustomerID/:CustomerID", GetCarByCustomerID);

export default router;