import { Request,Response } from "express";
import {conn ,Connect} from "../../../server";


export const GetCustomerByCustomerID = async (req: Request, res: Response) => {
    try {
        await Connect();
        const {CustomerID} = req.params;
        const newCustomerID = Number(CustomerID);
        const sql = `SELECT * FROM Customer WHERE CustomerID = ?`;
        const result: any = await conn?.query(sql,[newCustomerID]);
        res.status(200).json(result[0]);
    } catch (error) {
        console.log(error);
        
    }
};