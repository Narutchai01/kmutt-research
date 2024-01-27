import { Request, Response } from "express";
import { conn } from "../../server";
import { upLoadImageCustomer } from "../../utils/UploadImage";

export const addCustomer = async (req: Request, res: Response) => {
  try {
    const { First_name, Last_name, Email, Address, Phone_number, Line } =
      req.body;
    const Image = req.files;
    const addCustomer = `INSERT INTO Customer (First_name , Last_name , Email , Address , Phone_number , Line , Image) VALUES (?,?,?,?,?,?,?)`;
    const ImageURL = await Promise.all(
      (Image as Express.Multer.File[]).map(async (file: any) => {
        const url = await upLoadImageCustomer(file.buffer);
        return url;
      })
    );
    const DataCustomer = {
      First_name,
      Last_name,
      Email,
      Address,
      Phone_number,
      Line,
      Image: ImageURL[0] || "https://firebasestorage.googleapis.com/v0/b/kmutt-recearch.appspot.com/o/user-icon-in-trendy-flat-style-isolated-on-grey-background-user-symbol-for-your-web-site-design-logo-app-ui-illustration-eps10-free-vector.jpg?alt=media&token=cab37aca-7b80-44b5-940c-cdab08f0f97c",
    };
    await conn?.query(addCustomer, [
      DataCustomer.First_name,
      DataCustomer.Last_name,
      DataCustomer.Email,
      DataCustomer.Address,
      DataCustomer.Phone_number,
      DataCustomer.Line,
      DataCustomer.Image,
    ]);
    res.status(200).json({ message: "Add Customer Success" });
  } catch (error) {
    console.log(error);
  }
};
