import { Request, Response } from "express";
import { conn } from "../../server";
import { v4 as uuidv4 } from "uuid";

export const CreateCase = async (req: Request, res: Response) => {
  try {
    const { SurveyorID, CarID, Province, ImageCars } = req.body;
    const CaseID = uuidv4();
    const addImageSQL = `INSERT INTO image (CaseID,Image_link) VALUES (?,?)`;
    const sql = `INSERT INTO Cases (CaseID,SurveyorID,CarID,Province) VALUES (?, ?,?,?)`;

    Promise.all(
      ImageCars.map(async (item: any) => {
        const dataImage = {
          CaseID,
          Image_link: item,
        };
        await conn?.query(addImageSQL, dataImage);
      })
    );
    const dataCase = {
      CaseID,
      SurveyorID,
      CarID,
      Province,
    };
    await conn?.query(sql, [dataCase.CarID ,dataCase.SurveyorID, dataCase.CarID, dataCase.Province]);
    res.status(200).json({ message: "Create Case Success" });
  } catch (error) {
    console.log(error);
  }
};
