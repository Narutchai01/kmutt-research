import { Request,Response } from "express";
import {conn , Connect} from "../../../server";


export const getCaseBySurveyorID = async (req:Request,res:Response) => {
    try {
        await Connect();
        const {surveyorID} = req.params;
        const newtypeSurveyorID = parseInt(surveyorID);
        const sql = `SELECT * FROM Cases WHERE SurveyorID = ?`;
        const result:any = await conn?.query(sql,[newtypeSurveyorID]);
        if (!result) {
            return res.status(400).send("Surveyor not found");
        }
        res.status(200).send(result[0]);
    } catch (error) {
        console.log(error);
        
    }
}