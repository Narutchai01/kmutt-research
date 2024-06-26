import { Request,Response } from "express";
import { conn  } from "../../server";
import jwt from "jsonwebtoken";


export const findCaseBySurveyorID = async (req:Request,res:Response) => {
    try {
        const token = req.params.token;
        const secert = process.env.JWT_SECRET!;
        const decoded:any= jwt.verify(token, secert) ;
        const sql = `SELECT * FROM Cases WHERE SurveyorID = ?`;
        const result:any = await conn?.query(sql,[decoded.ID]);
        res.status(200).send(result[0]);
    } catch (error) {
        console.log(error);
    }
};