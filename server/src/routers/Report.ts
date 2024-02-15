import express from "express";
import { GetReport } from "../controller/Report/GetReport";

const router = express.Router();

router.get("/getreport", GetReport)




export default router;