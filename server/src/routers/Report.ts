import express from "express";
import { GetReport } from "../controller/Report/GetReport";
import { GetDamageDetail } from "../controller/Report/GetDamageDetail";

const router = express.Router();

router.get("/getreport", GetReport)
router.get("/getdamagedetail", GetDamageDetail)




export default router;