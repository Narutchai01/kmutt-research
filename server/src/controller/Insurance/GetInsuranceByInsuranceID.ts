import { Request,Response } from "express";
import { conn,Connect } from "../../server";


export const getInsuranceByInsuranceID = async (req: Request, res: Response) => {
    try {
        const { InsuranceID } = req.params;
        await Connect();
        const getInsuranceByInsuranceID = `SELECT * FROM Insurance WHERE Policy_number = ?`;
        const result :any = await conn?.query(getInsuranceByInsuranceID,[InsuranceID]);
        res.status(200).send(result[0]);
    } catch (error) {
        console.log(error);
    }
};