import { Request, Response } from "express";
import { conn, Connect } from "../../../server";

export const getCaseByCaseID = async (req: Request, res: Response) => {
  try {
    const { caseId } = req.params;
    const sql = `SELECT * FROM Cases WHERE CaseID = ?`;
    await Connect();

    const result: any = await conn?.query(sql, [caseId]);
    if (!result) {
      return res.status(400).json({ message: "Case not found" });
    }
    return res.status(200).json(result[0]);
  } catch (error) {
    console.log(error);
  }
};
