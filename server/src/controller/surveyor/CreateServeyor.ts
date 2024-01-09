import { Request, Response } from "express";
import { conn } from "../../server";
import { hashPassword } from "../../utils/ManagePassWord";
import { uploadImageSurveyor } from "../../utils/UploadImage";

export const CreateSurveyor = async (req: Request, res: Response) => {
  try {
    const Images = req.files
    const { First_name, Last_name, Email, PassWord, Phone_number, Birth_date } =req.body;
    const sql = `INSERT INTO Surveyor ( First_name, Last_name, Image , Birth_date , Phone_number ,Email , Password) VALUES ( ?, ?, ?, ?, ?, ? ,?)`;
    const ImageURL =  await Promise.all((Images as any[]).map(async (file:any) => {
      const url = await uploadImageSurveyor(file.buffer)
      return url
    }))
    const dataSurveyor = {
      First_name,
      Last_name,
      Image : ImageURL || "https://firebasestorage.googleapis.com/v0/b/kmutt-recearch.appspot.com/o/user-icon-in-trendy-flat-style-isolated-on-grey-background-user-symbol-for-your-web-site-design-logo-app-ui-illustration-eps10-free-vector.jpg?alt=media&token=cab37aca-7b80-44b5-940c-cdab08f0f97c",
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
    res.status(200).json({ message: "Create Surveyor Success" });
  } catch (error) {
    console.log(error);
  }
};
