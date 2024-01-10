import express from "express";
import { addCustomer } from "../controller/Customer/addCustomer";
import { getCustomer } from "../controller/Customer/getCustomer";

const router = express.Router();


router.post("/addCustomer", addCustomer);
router.get("/getCustomer", getCustomer);



export default router;