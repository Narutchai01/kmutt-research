import { Request, Response } from "express";
import { conn } from "../../server";
import { hashPassword } from "../../utils/ManagementPassword";
import { v4 as uuidv4 } from "uuid";

export const CreateSurveyor = async (req: Request, res: Response) => {
  try {
    const { First_name, Last_name, Phone_number, email, PassWord } =
      req.body;
    const createUser = {
      SurveyorID: uuidv4(),
      First_name,
      Last_name,
      Phone_number,
      email,
      PassWord : await hashPassword(PassWord)
    };
    const sql = `INSERT INTO surveyor (SurveyorID, First_name, Last_name, Phone_number, email, PassWord) VALUES (?,?,?,?,?,?)`;
    await conn?.query(sql, [
      createUser.SurveyorID,
      createUser.First_name,
      createUser.Last_name,
      createUser.Phone_number,
      createUser.email,
      createUser.PassWord
    ]);
    res.status(200).json({message:"Create Surveyor Success"});
  } catch (error) {
    console.log(error);
  }
};

