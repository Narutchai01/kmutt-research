import { Request, Response } from "express";
import { conn, Connect } from "../../server";
import { CustomerMockData } from "./Data";
import { upLoadImageCustomer } from "../../utils/UploadImage";






export const addCustomer = async (req: Request, res: Response) => {
  try {
    await Connect();
    const slq =
      "INSERT INTO Customer (First_name, Last_name, Email, Address, Phone_number, Line , Image) VALUES (?,?,?,?,?,?,?)";
    const Images = req.files;

    const Image = await Promise.all(
      (Images as any).map(async (image: any) => {
        return await upLoadImageCustomer(image);
      })
    );
  const result :any [] = await  CustomerMockData.map(async (customer ,index ) => {
      const data = {
        First_name: customer.First_name,
        Last_name: customer.Last_name,
        Email: customer.Email,
        Address: customer.Address,
        Phone_number: customer.Phone_number.replace(/-/g, ""),
        Line: customer.Line,
        Image: Image[index],
      };
      await conn?.query(slq,[data.First_name, data.Last_name, data.Email, data.Address, data.Phone_number, data.Line, data.Image]);
    });
    res.send("Customer Added");
  } catch (error) {
    console.log(error);
  }
};
