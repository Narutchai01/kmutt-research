import express from 'express';
import { CreateAdmin } from '../controller/admin/CreateAdmin';
import { loginAdmin } from '../controller/admin/LoginAdmin';

const router = express.Router();

router.post('/createadmin',CreateAdmin);
router.post('/loginadmin',loginAdmin);




export default router;