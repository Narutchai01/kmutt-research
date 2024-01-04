import express  from 'express';
const router = express.Router();
import { AddCar } from '../controller/Car/AddCar';
import { GetCars } from '../controller/Car/GetCars';


router.post('/addCar', AddCar)
router.get('/getCars', GetCars)


export default router;