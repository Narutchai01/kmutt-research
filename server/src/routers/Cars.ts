import express  from 'express';
import router from './Surveyor';
const routers = express.Router();
import { AddCar } from '../controller/Car/AddCar';



router.post('/addCar', AddCar)



export default routers;