import { Request,Response } from "express";
import { conn } from "../../server";


export const GetCase = async (req: Request, res: Response) => {
    try {
        const sql = `SELECT * FROM Cases`;
        const result:any = await conn?.query(sql);
        res.status(200).json(result[0]);
    } catch (error) {
        console.log(error);
    }
};