import express from 'express';
import { CreateSurveyor } from '../controller/surveyor/CreateServeyor';
import { GetSurveyor } from '../controller/surveyor/GetSurveyor';

const router = express.Router();

router.post('/createSurveyor',CreateSurveyor);
router.get('/getsurveyor',GetSurveyor);

export default router;