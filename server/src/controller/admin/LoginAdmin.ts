import { Request,Response } from "express";
import { conn} from "../../server";
import { comparePassword } from "../../utils/ManagePassWord";
import jwt from "jsonwebtoken";


export const loginAdmin = async (req:Request,res:Response) => {
    try {
        const secret = process.env.JWT_SECRET;
        const {Email,Password} = req.body;
        const findAdmin:any = await conn?.query(`SELECT * FROM Admin WHERE Email = ?`,[Email]);
        if (!findAdmin) {
            return res.status(404).json({
                status: "fail",
                message: "Admin not found",
            });
        }
        const Admin = findAdmin[0];
        const compare = await comparePassword(Password,Admin[0].Password);
        if (!compare) {
            return res.status(404).json({
                status: "fail",
                message: "Password is not correct",
            });
        }
        const token = jwt.sign({id:Admin[0].AdminID},secret as string,{expiresIn: "1d"});
        res.cookie("token",token,{httpOnly: true});
        return res.status(200).json({
            status: "success",
            message: "Login success",
            token,
        });
    } catch (error) {
        console.log(error);
    }
}    