import { Request, Response } from "express";
import { conn } from "../../server";
import { hashPassword } from "../../utils/ManagePassWord";

export const CreateSurveyor = async (req: Request, res: Response) => {
  try {
    const { First_name, Last_name, Email, PassWord, Phone_number, Birth_date } =req.body;
    const sql = `INSERT INTO Surveyor ( First_name, Last_name, Image , Birth_date , Phone_number ,Email , Password) VALUES ( ?, ?, ?, ?, ?, ? ,?)`;
    const dataSurveyor = {
      First_name,
      Last_name,
      Image : "https://firebasestorage.googleapis.com/v0/b/kmutt-recearch.appspot.com/o/user-icon-in-trendy-flat-style-isolated-on-grey-background-user-symbol-for-your-web-site-design-logo-app-ui-illustration-eps10-free-vector.jpg?alt=media&token=cab37aca-7b80-44b5-940c-cdab08f0f97c",
      Email,
      Birth_date,
      PassWord: await hashPassword(PassWord),
      Phone_number,
    };
    await conn?.query(sql, [
      dataSurveyor.First_name,
      dataSurveyor.Last_name,
      dataSurveyor.Image,
      dataSurveyor.Birth_date,
      dataSurveyor.Phone_number,
      dataSurveyor.Email,
      dataSurveyor.PassWord,
    ]);
    res.status(200).json(dataSurveyor.Image);
  } catch (error) {
    console.log(error);
  }
};
