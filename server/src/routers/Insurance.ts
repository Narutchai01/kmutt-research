import express from "express";
import { addInsurance } from "../controller/Insurance/addInsurance";
import { getInsurance } from "../controller/Insurance/GetInsurance";
import {auth} from "../middleware/auth";

const router = express.Router();


router.post("/addInsurance", addInsurance);
router.get("/getInsurance", getInsurance);

export default router;