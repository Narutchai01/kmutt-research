import { Request, Response } from "express";
import { conn, Connect } from "../../server";

export const GetCarByCustomerID = async (req: Request, res: Response) => {
    try {
        await Connect();
        const { CustomerID } = req.params;
        const castedCustomerID = Number(CustomerID);
        const sql = `SELECT CarID , Brand , Model , Color  FROM Car WHERE CustomerID = ?`;
        const result :any = await conn?.query(sql, [castedCustomerID]);
        res.status(200).send(result[0]);    
    } catch (error) {
        console.log(error);
    }
};
