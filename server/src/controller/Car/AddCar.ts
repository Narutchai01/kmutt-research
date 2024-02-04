import { Request, Response } from "express";
import { conn,Connect } from "../../server";
import { upLoadImageCar } from "../../utils/UploadImage";
import { dataCar } from "./data";


const randomnumber = (min: number, max: number) => {
  return Math.floor(Math.random() * (max - min + 1)) + min;
};


export const AddCar = async (req: Request, res: Response) => {
  try {
    await Connect();
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
    const sqlInsurance = "SELECT Policy_number, CustomerID FROM Insurance;"

    const insuranceData:any = await conn?.query(sqlInsurance);

    const result = await dataCar.map(async (car,index) => {
      const DataCar = {
        CarID: addSpace(car.CarID),
        Province: car.Province,
        CustomerID: insuranceData[0][index].CustomerID,
        Policy_number: insuranceData[0][index].Policy_number,
        Image: ImageURLs[randomnumber(0, ImageURLs.length - 1)],
        Brand: car.Brand,
        Model: car.Model,
        Color: car.Color,
        Status: "Active",
      };
      
      await conn?.query(sql, [
        DataCar.CarID,
        DataCar.Province,
        DataCar.CustomerID,
        DataCar.Policy_number,
        DataCar.Image,
        DataCar.Brand,
        DataCar.Model,
        DataCar.Color,
        DataCar.Status,
      ]);
    });
    

    res.status(200).send({ message: "Add Car Success" });
  } catch (error) {
    console.log(error);
  }
};
