import { Request, Response } from "express";
import { conn ,Connect} from "../../server";

export const getCarByID = async (req: Request, res: Response) => {
  try {
    await Connect();
    const { CarID, Province } = req.query;
    const sql = `
SELECT Cus.First_name , Cus.Last_name 
, C.CarID 
, Cus.image as Customer_image 
, C.image as Car_Image, Cus.Address 
, C.Model 
,C.Province as Province
, C.Brand
, C.Color 
, Insu.Policy_number 
, Insu.Policy_type 
, Insu.Start_date
, Insu.End_date 
,Cus.Email
,Cus.Phone_number
,Cus.Line
FROM Car AS C
JOIN Customer AS Cus ON C.CustomerID = Cus.CustomerID
JOIN Insurance AS Insu ON C.Policy_number = Insu.Policy_number
WHERE C.CarID = ? AND C.Province = ? 
    `;
    const result: any = await conn?.query(sql, [CarID, Province]);
    res.status(200).json(result[0]);
  } catch (error) {
    console.log(error);
  }
};
