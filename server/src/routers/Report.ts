import express from "express";
import { GetReport } from "../controller/Report/GetReport";

const router = express.Router();

router.get("/get-report", GetReport)




export default router;