import { Request,Response } from "express";
import { conn ,Connect} from "../../server";


export const GetSurveyor = async (req:Request,res:Response) => {
    try {
        await Connect();
        const sql = `SELECT LPAD(SurveyorID, 5, '0') AS PaddedSurveyorID, First_name, Last_name, Birth_date, Phone_number, Email, Password FROM Surveyor;`;
        const result:any = await conn?.query(sql);
        res.status(200).json(result[0]);
    } catch (error) {
        console.log(error);
    }
}