import { Request,Response } from "express";
import { conn } from "../../server";
import { hashPassword } from "../../utils/ManagePassWord";
import { v4 as uuidv4 } from 'uuid';


export const CreateSurveyor = async (req: Request, res: Response) => {
    try {
        const { First_name, Last_name, email, PassWord, Phone_number } = req.body;
        const sql = `INSERT INTO surveyor (SurveyorID, First_name, Last_name, Phone_number , email ,PassWord) VALUES (?, ?, ?, ?, ?, ?)`;
        const dataSurveyor = {
            SurveyorID: uuidv4(),
            First_name,
            Last_name,
            email,
            PassWord: await hashPassword(PassWord),
            Phone_number
        };
        await conn?.query(sql, [dataSurveyor.SurveyorID, dataSurveyor.First_name, dataSurveyor.Last_name, dataSurveyor.Phone_number, dataSurveyor.email, dataSurveyor.PassWord]);
        res.status(200).json({ message: "Create Surveyor Success" });
    } catch (error) {
        console.log(error);
    }
};