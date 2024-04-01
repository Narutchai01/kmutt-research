import { Request,Response } from "express";
import { conn, Connect } from "../../../server";

export const ChartBar = async (req: Request, res: Response) => {
    try {
        await Connect();
        const Policy_type :string[] = []
        const coun_policy :number[] = []
        const sql = `SELECT Policy_type , COUNT(*) as coun_policy from Insurance GROUP by Policy_type;`
        const result: any = await conn?.query(sql);
        result[0].forEach((element: any) => {
            Policy_type.push(element.Policy_type);
            coun_policy.push(element.coun_policy);
        });
        res.status(200).json({Policy_type,coun_policy});
    } catch (error: any) {
        console.log(error.message);
    }
};