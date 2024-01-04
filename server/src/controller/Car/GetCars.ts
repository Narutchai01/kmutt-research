import { Request,Response } from "express";
import {conn} from '../../server'


export const GetCars = async (req:Request,res:Response) => {
    try {
        const sql = 'SELECT * FROM car';
        const result:any = await conn?.query(sql);
        if (!result[0]){
            res.status(404).json({message: 'Not Found'})
        }
        res.status(200).send(result[0]);
    } catch (error) {
        console.log(error);
    }
}