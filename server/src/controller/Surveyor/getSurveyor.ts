import { Request,Response } from "express";
import { conn } from "../../server";

export const getSurveyor = async (_req: Request, res: Response) => {
  try {
      const sql = `SELECT * FROM surveyor`;
      const result = await conn?.query(sql);
      if (!result || !result[0]) {
        return false;
      }
      res.status(200).json(result[0]);
  } catch (error) {
    console.log(error);
  }
};

