import { Request, Response } from "express";
import { conn } from "../../server";
import { upLoadImageCar } from "../../utils/UploadImage";

export const AddCar = async (req: Request, res: Response) => {
  try {
    const { CarId, Province, CustomerID, Policy_number, Brand, Model, Color } =
      req.body;
    const ImageCar = req.files;
    const sql = `INSERT INTO car (CarId , Province , CustomerID ,Policy_number , Image , Brand , Model ,Color) VALUES (?,?,?,?,?,?,?)`;
    const ImageCarURL = await Promise.all(
      (ImageCar as Express.Multer.File[]).map(async (file: any) => {
        const url = await upLoadImageCar(file.buffer);
        return url;
      })
    );
    const carData = {
      CarId,
      ImageCarURL,
      Province,
      CustomerID,
      Policy_number,
      Brand,
      Model,
      Color,
    };
    await conn?.query(sql, [
      carData.CarId,
      carData.Province,
      carData.CustomerID,
      carData.Policy_number,
      carData.ImageCarURL[0],
      carData.Brand,
      carData.Model,
      carData.Color,
    ]);
    res.status(200).json({ message: "Add Car Success" });
  } catch (error) {
    console.log(error);
  }
};
