import express from "express";
import { AddCar } from "../controller/Car/AddCar";
import { GetCars } from "../controller/Car/GetCars";


const router = express.Router();

router.post("/addCar", AddCar);
router.get("/getCars", GetCars);

export default router;