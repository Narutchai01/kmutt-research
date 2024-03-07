import { Request,Response } from "express";
import{conn ,Connect} from "../../server";


export const GetcaseByCaseID = async (req: Request, res: Response) => {
    try {
    const {caseID} = req.query;
    await Connect();
    const sql = `SELECT * FROM Cases WHERE CaseID = ?`;
    const result:any = await conn?.query(sql, [caseID]);
    res.status(200).send(result[0]);    
    } catch (error) {
        console.log(error);
    }
};