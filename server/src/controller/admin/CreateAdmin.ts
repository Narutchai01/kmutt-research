import { Request, Response } from "express";
import { conn } from "../../server";
import { upLoadeImageAdmin } from "../../utils/UploadImage";
import { hashPassword } from "../../utils/ManagePassWord";

export const CreateAdmin = async (req: Request, res: Response) => {
  try {
    const { First_name, Last_name, Birth_date, Phone_number, Email, Password } =
      req.body;
    const Images = req.files;
    const sql = `INSERT INTO Admin (First_name, Last_name, Birth_date, Phone_number, Email, Password, Image) VALUES (?,?,?,?,?,?,?)`
    const ImageURL = await Promise.all(
      (Images as any[]).map(async (file: any) => {
        const url = await upLoadeImageAdmin(file.buffer);
        return url;
      })
    );
    const DataAdmin = {
        First_name,
        Last_name,
        Birth_date,
        Phone_number,
        Email,
        Password : await hashPassword(Password),
        ImageURL,
    };
    
    await conn?.query(sql,[DataAdmin.First_name,DataAdmin.Last_name,DataAdmin.Birth_date,DataAdmin.Phone_number,DataAdmin.Email,DataAdmin.Password,DataAdmin.ImageURL[0]])
    res.status(200).json({
        status: "success",
        data: DataAdmin,
    });
  } catch (error) {
    console.log(error);
  }
};
