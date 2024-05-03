import { Request, Response } from "express";
import { conn } from "../../../server";

export const EditCaseByID = async (req: Request, res: Response) => {
  try {
    const { caseID } = req.params;
    const { Descriptcion } = req.body;
    const sqlFindCase = `SELECT * FROM case WHERE CaseID = ?`;
    const updatesql = `UPDATE Case SET Descriptcion = ? WHERE CaseID = ?`;
    const findCase: any = await conn?.query(sqlFindCase, [caseID]);
    if (findCase.length === 0) {
      res.status(404).json({ message: "Case not found" });
      return;
    }
    await conn?.query(updatesql, [Descriptcion, caseID]);
    res.status(200).json({ message: "Edit case success" });
  } catch (error) {
    console.log(error);
  }
};
