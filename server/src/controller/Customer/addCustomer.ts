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
      Image: ImageURL[0],
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
