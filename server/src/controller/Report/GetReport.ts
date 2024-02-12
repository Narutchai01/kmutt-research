import { report } from 'process';
import {client ,conn,Connect } from "../../server";
import { Request, Response } from "express";

export const GetReport = async (req: Request, res: Response) => {
    try {
        await Connect();
        const sql = `SELECT * FROM Image WHERE CaseID = ?`;
        const { caseID } = req.query;
        const ImgeArr: any = await conn?.query(sql, [caseID]);
        const report = await client.db("kmutt").collection("report").findOne({ CaseID: caseID });

        res.status(200).json({
            image: ImgeArr,
            report: report
        });
    } catch (error) {
        console.log(error);
    }
};