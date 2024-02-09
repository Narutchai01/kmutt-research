import express from "express";
import { AddCar } from "../controller/Car/AddCar";
import { GetCars } from "../controller/Car/GetCars";
import { getCarByID } from "../controller/Car/GetCarByID";
// import { GetCarByCustomerID } from "../controller/Car/GetCarByCustomerID";
// import { DeleteCarByID } from "../controller/Car/DeleteCarByID";

const router = express.Router();

router.post("/addCar", AddCar);
router.get("/getCars", GetCars);
router.get("/getCarByID", getCarByID);
// router.get("/getCarByCustomerID/:CustomerID", GetCarByCustomerID);
// router.delete("/deleteCarByID/:id", DeleteCarByID);

export default router;