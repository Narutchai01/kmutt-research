import { Request, Response } from "express";
import { CheckDataEdit } from "../../../utils/ChackDataEdit";
import { Connect, conn } from "./../../../server";

export const EditCar = async (req: Request, res: Response) => {
  try {
    const { id, province } = req.params;
    const { CustomerID, Policy_number, CarID, Province, Brand, Model, Color } =
      req.body;
    const sqlFindCar = `SELECT * FROM car WHERE CarID = ? AND Province = ?`;
    const updatesql = `UPDATE car SET CustomerID = ?, Policy_number = ?, CarID = ?, Province = ?, Brand = ?, Model = ?, Color = ? WHERE CarID = ? AND Province = ?`;
    await Connect();
    const findCar: any = await conn?.query(sqlFindCar, [id, province]);
    if (findCar.length === 0) {
      res.status(404).json({ message: "Car not found" });
      return;
    }
    const data = {
      CustomerID: CheckDataEdit(CustomerID) || findCar[0][0].CustomerID,
      Policy_number:
        CheckDataEdit(Policy_number) || findCar[0][0].Policy_number,
      CarID: CheckDataEdit(CarID) || findCar[0][0].CarID,
      Province: CheckDataEdit(Province) || findCar[0][0].Province,
      Brand: CheckDataEdit(Brand) || findCar[0][0].Brand,
      Model: CheckDataEdit(Model) || findCar[0][0].Model,
      Color: CheckDataEdit(Color) || findCar[0][0].Color,
    };
    await conn?.query(updatesql, [
      data.CustomerID,
      data.Policy_number,
      data.CarID,
      data.Province,
      data.Brand,
      data.Model,
      data.Color,
      id,
      province,
    ]);
    res.status(200).json({ message: "Edit car success" });
  } catch (error) {
    console.log(error);
  }
};
