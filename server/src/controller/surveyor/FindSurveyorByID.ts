import { Request,Response } from "express";
import { conn } from "../../server";


export const FindSurveyorByID = async (req: Request, res: Response) => {
    try {
        const { id } = req.params;
        const sql = `SELECT LPAD(SurveyorID, 5, '0') AS PaddedSurveyorID, First_name, Last_name, Birth_date, Phone_number, Email, Password FROM Surveyor WHERE SurveyorID = ?`;
        const result:any = await conn?.query(sql, [id]);
        res.json(result[0]);
    } catch (error) {
        console.log(error);
        
    }
};