import { Request,Response } from "express";
import { conn } from "../../server";


export const AddCar = async (req: Request, res: Response) => {
    try {
        const {CarID , Province , CustomerID ,Policy_number , Brand , Model ,Color } = req.body;
        const sql = `INSERT INTO Car (CarID , Province , CustomerID ,Policy_number , Brand , Model ,Color) VALUES (?,?,?,?,?,?,?)`;
        await conn?.query(sql,[CarID , Province , CustomerID ,Policy_number , Brand , Model ,Color]);
        // res.status(200).json({CarID , Province , CustomerID ,Policy_number , Brand , Model ,Color});
        res.status(200).json({message: "Add Car Success"});
    } catch (error) {
        console.log(error);
        
    }
};