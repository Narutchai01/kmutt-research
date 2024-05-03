import { Request, Response } from "express";
import { conn } from "../../server";

export const getInsurance = async (req: Request, res: Response) => {
    try {
        const getInsurance = `SELECT Policy_number ,Car.CustomerID , Policy_type , Start_date , End_date ,CarID ,Car.Province  FROM Insurance JOIN Car USING(Policy_number)`;
        const result :any = await conn?.query(getInsurance);
        res.status(200).send(result[0]);
    } catch (error) {
        console.log(error);
    }
};