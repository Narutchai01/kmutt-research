import { Request, Response } from "express";
import { conn,Co } from "../../server";
import { upLoadeImageAdmin } from "../../utils/UploadImage";
import { hashPassword } from "../../utils/ManagePassWord";

export const CreateAdmin = async (req: Request, res: Response) => {
  try {
    const { First_name, Last_name, Birt_date, Phone_number, Email, Password } =
      req.body;
    const Images = req.files;
    const ImageURL = await Promise.all(
      (Images as any[]).map(async (file: any) => {
        const url = await upLoadeImageAdmin(file);
        return url;
      })
    );
    const DataAdmin = {
        First_name,
        Last_name,
        Birt_date,
        Phone_number,
        Email,
        Password : await hashPassword(Password),
        ImageURL,
    };
    await con
  } catch (error) {
    console.log(error);
  }
};
