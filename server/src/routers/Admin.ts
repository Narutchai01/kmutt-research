import express from 'express';
import { CreateAdmin } from '../controller/admin/CreateAdmin';
import { loginAdmin } from '../controller/admin/LoginAdmin';
import { getAdminByID } from '../controller/admin/GetAdminByID';

const router = express.Router();

router.post('/createadmin',CreateAdmin);
router.post('/loginadmin',loginAdmin);
router.get('/getadmin',getAdminByID);




export default router;