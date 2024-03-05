import { Connect, conn } from "./../../../server";
import { Request, Response } from "express";
import { CheckDataEdit } from "../../../utils/ChackDataEdit";

export const EditCustomer = async (req: Request, res: Response) => {
  try {
    const { id } = req.params;
    const { FirstName, LastName, Email, Phone_number, Address, Line } =
      req.body;
    await Connect();
    const findCustomer: any = await conn?.query(
      "SELECT * FROM customer WHERE id = ?",
      [id]
    );
    if (!findCustomer) {
      return res.status(400).json({ message: "Customer not found" });
    }
    const data = {
      FirstName: CheckDataEdit(FirstName) || findCustomer[0][0].FirstName,
      LastName: CheckDataEdit(LastName) || findCustomer[0][0].LastName,
      Email: CheckDataEdit(Email) || findCustomer[0][0].Email,
      Phone_number:
        CheckDataEdit(Phone_number) || findCustomer[0][0].Phone_number,
      Address: CheckDataEdit(Address) || findCustomer[0][0].Address,
      Line: CheckDataEdit(Line) || findCustomer[0][0].Line,
    };
    await conn?.query("UPDATE Customer SET ? WHERE id = ?", [data, id]);
    res.status(200).json({ message: "Edit Customer Success" });
  } catch (error) {
    console.log(error);
  }
};
