import { Request, Response } from "express";
import { CheckDataEdit } from "../../../utils/ChackDataEdit";
import {  conn } from "./../../../server";

export const EditCar = async (req: Request, res: Response) => {
  try {
    const { id, province } = req.params;
    const { Brand, Model, Color } = req.body;
    const sqlFindCar = `SELECT * FROM car WHERE CarID = ? AND Province = ?`;
    const updatesql = `UPDATE car SET  Brand = ?, Model = ?, Color = ? WHERE CarID = ? AND Province = ?`;
    const findCar: any = await conn?.query(sqlFindCar, [id, province]);
    if (findCar.length === 0) {
      res.status(404).json({ message: "Car not found" });
      return;
    }
    const data = {
      Brand: CheckDataEdit(Brand) || findCar[0][0].Brand,
      Model: CheckDataEdit(Model) || findCar[0][0].Model,
      Color: CheckDataEdit(Color) || findCar[0][0].Color,
    };
    await conn?.query(updatesql, [
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
