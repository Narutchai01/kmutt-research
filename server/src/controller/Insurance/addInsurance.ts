import { Request, Response } from "express";
import { conn, Connect } from "../../server";
import { dataInsurance } from "./data";

export const addInsurance = async (req: Request, res: Response) => {
  try {
    await Connect();
    const addInsurance = `INSERT INTO Insurance (Policy_number , CustomerID , Policy_type , Start_date , End_date ,Status) VALUES (?,?,?,?,?,?)`;
    const result = await dataInsurance.map(async (insurance) => {
      const DataInsurance = {
        Policy_number: insurance.Policy_number,
        CustomerID: insurance.CustomerID,
        Policy_type: insurance.Policy_type,
        Start_date: insurance.Start_date,
        End_date: insurance.End_date,
        Status: "Active",
      };
      await conn?.query(addInsurance, [
        DataInsurance.Policy_number,
        DataInsurance.CustomerID,
        DataInsurance.Policy_type,
        DataInsurance.Start_date,
        DataInsurance.End_date,
        DataInsurance.Status,
      ]);
      
    });
    res.status(200).json({ message: "Add Insurance Success" });
  } catch (error) {
    console.log(error);
  }
};
