import exp from 'constants';
import express from 'express';
const router = express.Router();
import { addInsurance } from '../controller/Insurance/addInsurance';


router.post('/addInsurance', addInsurance)


export default router;