import { Request , Response } from 'express';
import {conn , Connect} from "../../../server"

export const getSurveyorByID = async (req: Request , res: Response) => {
    try {
        await Connect()
        const id = req.params.id;
        const sql = `SELECT * FROM Surveyor WHERE SurveyorID = ?`;
        const reuslt:any = await conn?.query(sql , [id]);
        res.status(200).send(reuslt[0]);
    } catch (error) {
        console.log(error);
        
    }
};