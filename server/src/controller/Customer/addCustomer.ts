import { Request, Response } from "express";
import { conn } from "../../server";

export const addCustomer = async (req: Request, res: Response) => {
  try {
    const { First_name, Last_name, Address, Phone_number, Email, Line } =
      req.body;
    const sql = `INSERT INTO Customer (First_name, Last_name, Address, Phone_number, Email, Line) VALUES (?,?,?,?,?,?)`;
    await conn?.query(sql, [
      First_name,
      Last_name,
      Address,
      Phone_number,
      Email,
      Line,
    ]);
    res.status(200).json({ message: "Add Customer Success" });
  } catch (error) {
    console.log(error);
  }
};
