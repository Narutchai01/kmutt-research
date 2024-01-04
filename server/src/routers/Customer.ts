import express from 'express';
import { addCustomer } from '../controller/Customer/addCustomer';


const router = express.Router();

router.post('/addCustomer',addCustomer);


export default router;