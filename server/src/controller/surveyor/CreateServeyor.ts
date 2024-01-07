import { Request, Response } from "express";
import { conn } from "../../server";
import { hashPassword } from "../../utils/ManagePassWord";

export const CreateSurveyor = async (req: Request, res: Response) => {
  try {
    const { First_name, Last_name, Email, PassWord, Phone_number, Birth_date } =req.body;
    const sql = `INSERT INTO Surveyor ( First_name, Last_name, Birth_date , Phone_number ,Email , PassWord) VALUES ( ?, ?, ?, ?, ?, ?)`;
    const dataSurveyor = {
      First_name,
      Last_name,
      Email,
      Birth_date,
      PassWord: await hashPassword(PassWord),
      Phone_number,
    };
    await conn?.query(sql, [
        dataSurveyor.First_name,
        dataSurveyor.Last_name,
        dataSurveyor.Birth_date,
        dataSurveyor.Phone_number,
        dataSurveyor.Email,
        dataSurveyor.PassWord,
    ]);
    res.status(200).json(Image);
  } catch (error) {
    console.log(error);
  }
};
