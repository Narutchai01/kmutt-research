import { Request,Response } from "express";
import { conn, Connect } from "../../../server";

export const ChartDoughnut = async (req: Request, res: Response) => {
    try {
        await Connect();
        const Province :string[] = []
        const ProvinceCounter :number[] = []
        const sql = `SELECT Province , COUNT(*) as counter FROM Cases GROUP by Province;`
        const reult: any = await conn?.query(sql);
        reult[0].forEach((element: any) => {
            Province.push(element.Province);
            ProvinceCounter.push(element.counter);
        });
        res.status(200).json({Province,ProvinceCounter});
    } catch (error :any) {
       console.log(error.message);
    }
};