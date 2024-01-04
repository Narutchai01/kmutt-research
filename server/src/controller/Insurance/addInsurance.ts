import { addCustomer } from './../Customer/addCustomer';
import { Request,Response } from "express";
import { conn } from "../../server";

export const addInsurance = async (req: Request, res: Response) => {
    try {
        const { Policy_number ,CustomerID , Policy_type , Start_date , End_date } = req.body;
        const sql = `INSERT INTO Insurance (Policy_number ,CustomerID , Policy_type , Start_date , End_date) VALUES (?,?,?,?,?)`;
        await conn?.query(sql,[Policy_number ,CustomerID , Policy_type , Start_date , End_date]);
        // res.status(200).json({ Policy_number ,CustomerID , Policy_type , Start_date , End_date});
        res.status(200).json({message: "Add Insurance Success"});
    } catch (error) {
        console.log(error);
        
    }
};