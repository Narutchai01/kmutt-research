import { Request, Response } from "express";
import { conn } from "../../server";
import jwt from "jsonwebtoken";
import { comparePassword } from "../../utils/ManagementPassword";

export const LoginSurveyor = async (req: Request, res: Response) => {
  try {
    const { email, PassWord } = req.body;
    const sql = `SELECT * FROM surveyor WHERE email = ${email}`;
    const result:unknown = await conn?.query(sql)
    if (!result){
      return false
    }
    const user:any = result[0][0]
    if (!user){
      return false
    }
    const compare = await comparePassword(PassWord, user.PassWord)
    if (!compare){
      res.status(400).json({message:"Password is not correct"})
      return false
    }
    const payload = {
      SurveyorID: user.SurveyorID,
      email: user.email,
    };
    const token = jwt.sign(payload, "secert", {
      expiresIn: "1h",
    });
    res.cookie("token", token, { httpOnly: true });
    res.status(200).json({message : "login success"});
  } catch (error) {
    console.log(error);
  }
};