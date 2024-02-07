import { Request ,Response } from "express";
import { conn ,Connect} from "../../server";


export const getCustomer = async (req: Request, res: Response) => {
    try {
        await Connect();
        const sql = `SELECT * FROM Customer`;
        const result:any = await conn?.query(sql);
        res.status(200).json(result[0]);
    } catch (error) {
        console.log(error);
        
    }
};