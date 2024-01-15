import { Request,Response } from "express";
import { conn } from "../../server";

export const getCarByID = async (req: Request, res: Response) => {
    try {
        const { CarID, Province } = req.query;
        const sql = `SELECT * FROM Car WHERE CarID LIKE ? AND Province LIKE ?`;
        const result:any = await conn?.query(sql,[CarID, Province]);
        if (!result[0]) {
            res.status(400).json({ message: "ไม่พบข้อมูลรถ" });
            return false;
        }
        res.status(200).json(result[0]);
    } catch (error) {
        console.log(error);
    }
};