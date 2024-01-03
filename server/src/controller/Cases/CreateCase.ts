import { Request, Response } from "express";
import {conn} from "../../server"
import { v4 as uuidv4 } from "uuid";

export const CreateCase = async (req: Request, res: Response) => {
  try {
    const CaseID = uuidv4();
    const { images, SurveyorID, CarID };

    const addImage = images.map((item:any)=>{
        const ImageID = uuidv4()
        const DataImage = {
            ImageID,
            CaseID,
            Image_Link: "dasdasdasd"
        }
    })

    const DataCase = {
      CaseID,
      SurveyorID,
      CarID,
      Province:"somthing",
      Date_opened: new Date(),
      Status: "In Progress",
    };
    const addCase = `INSERT INTO cases (CaseID,SurveyorID,CarID,Province,Date_opened,Status) VALUE (?,?,?,?,?,?)`
    await conn?.query(addCase,DataCase)
  } catch (error) {
    console.log(error);
  }
};
