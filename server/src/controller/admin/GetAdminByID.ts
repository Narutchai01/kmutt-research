import { Request, Response } from "express";
import { conn} from "../../server";
import jwt from "jsonwebtoken";


export const getAdminByID = async (req: Request, res: Response) => {
  try {
    const Token = req.cookies.token;
    const secret = process.env.JWT_SECRET;
    const verifyToken:any = jwt.verify(Token, String(secret));
    const findAdmin :any = await conn?.query(`SELECT * FROM Admin WHERE AdminID = ?`,[verifyToken.id]);
    if (!findAdmin) {
      return res.status(404).json({
        status: "fail",
        message: "Admin not found",
      });
    }
    const Admin = findAdmin[0][0];
    return res.status(200).send(Admin);
  } catch (error) {
    console.log(error);
  }
};
