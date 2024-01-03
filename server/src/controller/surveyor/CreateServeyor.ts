import { Request,Response } from "express";
import { conn } from "../../server";
import { hashPassword } from "../../utils/ManagePassWord";


export const CreateSurveyor = async (req:Request,res:Response) => {
    try {
        const { SurveyorID ,First_name , Last_name , email , Password , Phone_number} = req.body;
        const sql = `INSERT INTO Surveyor (SurveyorID ,First_name , Last_name , email , Password , Phone_number) VALUES (?, ?, ?, ?, ?, ?)`;
        const dataSurveyor = {
            SurveyorID,
            First_name,
            Last_name,
            email,
            Password: await hashPassword(Password),
            Phone_number
        };
        await conn?.query(sql,dataSurveyor);
        res.status(200).json({message: "Create Surveyor Success"});
    } catch (error) {
        console.log(error);
        
    }
};