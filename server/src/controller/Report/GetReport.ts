import { report } from 'process';
import {client ,conn,Connect } from "../../server";
import { Request, Response } from "express";

export const GetReport = async (req: Request, res: Response) => {
    try {
        await Connect();
        const sql = `SELECT Image_link FROM Image WHERE CaseID = ?`;
        const { caseID } = req.query;
        const ImgaeArr: any = await conn?.query(sql, [caseID]);
        const report = await client.db("kmutt").collection("report").findOne({ CaseID: caseID });

       

        res.status(200).send({
            ImageArr: ImgaeArr[0], // Fixed the syntax error by removing the unnecessary comma and adding a colon
            report
        });
    } catch (error) {
        console.log(error);
    }
};