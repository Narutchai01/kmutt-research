import { Secret, Jwt } from './../../../node_modules/@types/jsonwebtoken/index.d';
import { Request, Response } from "express";
import { conn } from "../../server";
import {comparePassword} from '../../utils/ManagePassWord';
import jwt from 'jsonwebtoken';
import { PayLoad } from '../../interface/Interface';

export const LoginSurveyor = async (req: Request, res: Response) => {
  try {
    const { email, PassWord } = req.body;
    const findSurveyorSQL = `SELECT * FROM Surveyor WHERE Email = ?`;
    const secret = process.env.JWT_SECRET;
    const findSurveyor: any = await conn?.query(findSurveyorSQL, [email]);
    if (!findSurveyor[0]) {
      res.status(400).json({ message: "Email not found" });
      return;
    }
    const checkPassword = await comparePassword(PassWord, findSurveyor[0][0].Password);
    if (!checkPassword) {
      res.status(400).json({ message: "Password is incorrect" });
      return;
    }
    const payLoad: PayLoad = {
      ID: findSurveyor[0][0].SurveyorID,
    };
    const token = jwt.sign(payLoad, secret as Secret, {
      expiresIn: "1h",
    });
    res.status(200).json({ token }); // Add the message field to the response
  } catch (error) {
    console.log(error);
  }
};
