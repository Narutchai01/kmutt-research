import express from "express";
import { AddCar } from "../controller/Car/AddCar";
import { GetCars } from "../controller/Car/GetCars";
import { getCarByID } from "../controller/Car/GetCarByID";

const router = express.Router();

router.post("/addCar", AddCar);
router.get("/getCars", GetCars);
router.get("/getCarByID", getCarByID);

export default router;