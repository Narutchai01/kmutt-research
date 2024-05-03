import { conn  } from '../../server';
import { Request,Response } from 'express';


export const GetDamageDetail = async (req: Request, res: Response) => {
    try {
    const {caseID} = req.query;
    const getDamageDetail = `SELECT * FROM Damage_detail WHERE CaseID = ?`;
    const result:any = await conn?.query(getDamageDetail, [caseID]);
    res.status(200).send(result[0]);    
    } catch (error) {
        console.log(error);
    }
};