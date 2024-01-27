import { Request, Response } from "express";
import { conn } from "../../server";
import { upLoadImageCar } from "../../utils/UploadImage";

export const AddCar = async (req: Request, res: Response) => {
  try {
    const {
      CarID,
      Province,
      Policy_number,
      CustomerID,
      Brand,
      Model,
      Color,
      Status,
    } = req.body;
    const Image = req.files;
    const ImageURL = Promise.all(
      (Image as any[]).map(async (file: any) => {
        const url = await upLoadImageCar(file.buffer);
        return url;
      })
    );
    const ImageURLs = await ImageURL;

    const addSpace = (str: string) => {
      const symbol = " ";
      str = str.split(" ").join("");
      if (str.length === 6 || str.length === 7) {
        let newStr = str.slice(0, str.length - 4) + symbol + str.slice(str.length - 4);
        return newStr;
      }
    };

    const sql = `INSERT INTO Car (CarID,Province,CustomerID,Policy_number,Image,Brand,Model,Color,Status) VALUES (?,?,?,?,?,?,?,?,?)`;
    const data = {
      CarID : addSpace(CarID),
      Province,
      CustomerID,
      Policy_number,
      Image: ImageURLs[0],
      Brand,
      Model,
      Color,
      Status: "Active",
    };
    await conn?.query(sql, [
      data.CarID,
      data.Province,
      data.CustomerID,
      data.Policy_number,
      data.Image,
      data.Brand,
      data.Model,
      data.Color,
      data.Status,
    ]);
    res.status(200).json(data);
  } catch (error) {
    console.log(error);
  }
};
