import { Request,Response } from "express";
import {conn ,Connect} from "../../../server";


export const getCarByCustomerID = async (req: Request, res: Response) => {
    try{
        await Connect();
        const {CustomerID} = req.params;
        const newCustomerID = Number(CustomerID);
        const sql = `SELECT CarID , Province , Brand , Model , Color  FROM Car WHERE CustomerID = ?`;
        const result: any = await conn?.query(sql,[newCustomerID]);
        res.status(200).json(result[0]);
    }
    catch(error){
        console.log(error);
    }
};