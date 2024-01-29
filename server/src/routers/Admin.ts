import express from 'express';
import { CreateAdmin } from '../controller/admin/CreateAdmin';

const router = express.Router();

router.post('/createadmin',CreateAdmin);




export default router;