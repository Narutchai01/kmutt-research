import { Request,Response } from "express";
import { conn } from "../../server";


export const AddCar = async (req: Request, res: Response) => {
    try {
        const {CarId , Province , CustomerID ,Policy_number , Brand , Model ,Color } = req.body;
    } catch (error) {
        console.log(error);
        
    }
};