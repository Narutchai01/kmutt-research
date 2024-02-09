import { Request, Response } from "express";
import { conn,Connect } from "../../server";
import { hashPassword, comparePassword } from "../../utils/ManagePassWord";
import jwt from "jsonwebtoken";

export const ChangePassWord = async (req: Request, res: Response) => {
    try {
        await Connect();
        const { oldPassword, newPassword } = req.body;
        const secert = process.env.JWT_SECRET!;
        const { token } = req.params;
        const decode:any = await jwt.verify(token, secert);
        const findsurveyorSQL = `SELECT * FROM Surveyor WHERE SurveyorID = ?`;
        const updatePasswordSQL = `UPDATE Surveyor SET Password = ? WHERE SurveyorID = ?`;
        const surveyor:any =  await conn?.query(findsurveyorSQL, [decode.ID]);
        if (!surveyor) {
            res.status(400).json({ message: "Surveyor not found" });
            return;
        }
        const isMatch = await comparePassword(oldPassword, surveyor[0][0].Password);
        if (!isMatch) {
            res.status(400).json({ message: "Old password is incorrect" });
            return;
        }
        const hash = await hashPassword(newPassword);
        await conn?.query(updatePasswordSQL, [hash, decode.ID]);
        res.status(200).json({ message: "Change password success" });
    } catch (error) {
        console.log(error);
    }
};
