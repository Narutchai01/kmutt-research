import { Request,Response } from "express";
import { conn } from "../../server";


export const FindSurveyorByID = async (req: Request, res: Response) => {
    try {
        const { id } = req.params;
        const sql = `SELECT * FROM surveyor WHERE SurveyorID = ?`;
        const result:any = await conn?.query(sql, [id]);
        res.json(result[0]);
    } catch (error) {
        console.log(error);
        
    }
};