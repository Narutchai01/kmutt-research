import { Request, Response } from "express";
import { conn } from "../../server";
import { v4 as uuidv4 } from "uuid";
import jwt from "jsonwebtoken";
import { upLoadImageCase } from "../../utils/UploadImage";

export const CreateCase = async (req: Request, res: Response) => {
  try {
    const token = req.cookies.token;
    const secert = process.env.JWT_SECRET!;
    const decoded: any = jwt.verify(token, secert);
    const CaseID = uuidv4();
    const { CarID, Province, Description } = req.body;
    const Images = req.files;
    const addCase = `INSERT INTO Cases (CaseID, SurveyorID, CarID, Province, Description) VALUES (?,?,?,?,?)`;
    const addImageCase = `INSERT INTO Image (CaseID , Image_link) VALUES (?,?)`;
    const date = new Date();
    const Date_opened = `${date.getFullYear()}-${(date.getMonth() + 1).toString().padStart(2, "0")}-${date.getDate().toString().padStart(2, "0")}`;
    const DataCase = {
      CaseID,
      SurveyorID: decoded.ID,
      CarID,
      Province,
      Date_opened,
      Description,
    };
    await conn?.query(addCase, [
      DataCase.CaseID,
      DataCase.SurveyorID,
      DataCase.CarID,
      DataCase.Province,
      DataCase.Date_opened,
      DataCase.Description,
    ]);
    await Promise.all(
      (Images as Express.Multer.File[]).map(async (file: any) => {
        const url = await upLoadImageCase(file.buffer);
        const DataImageCase = {
          CaseID: CaseID,
          Image_link: url,
        };
        await conn?.query(addImageCase, [
          DataImageCase.CaseID,
          DataImageCase.Image_link,
        ]);
      })
    );

    res.status(200).json({ message: "Create Case Success" });
  } catch (error) {
    console.log(error);
  }
};
