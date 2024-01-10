import express from "express";
import { addInsurance } from "../controller/Insurance/addInsurance";

const router = express.Router();


router.post("/addInsurance", addInsurance);


export default router;