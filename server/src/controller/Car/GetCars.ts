import { Request,Response } from "express";
import {conn , Connect} from '../../server'


export const GetCars = async (req:Request,res:Response) => {
    try {
        await Connect();
        const sql = 'SELECT Car.CarID , Car.Province , Customer.First_name , Customer.Last_name , Insurance.Policy_type  ,Car.image  FROM Customer JOIN Car USING(CustomerID) JOIN Insurance USING(Policy_number);';
        const result:any = await conn?.query(sql);
        if (!result[0]){
            res.status(404).json({message: 'Not Found'})
        }
        res.status(200).send(result[0]);
    } catch (error) {
        console.log(error);
    }
}