import { Request,Response } from "express";
import {conn , Connect} from '../../server'


export const GetCars = async (req:Request,res:Response) => {
    try {
        await Connect();
        const sql = 'SELECT Cus.First_name , Cus.Last_name , Cus.image ,C.CarID ,C.Province FROM Car as C JOIN Customer as Cus USING(CustomerID)';
        const result:any = await conn?.query(sql);
        if (!result[0]){
            res.status(404).json({message: 'Not Found'})
        }
        res.status(200).send(result[0]);
    } catch (error) {
        console.log(error);
    }
}