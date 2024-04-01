import { Request, Response } from "express";
import { conn, Connect } from "../../../server";

export const cardCounter = async (req: Request, res: Response) => {
  try {
    await Connect();
    const caseSQL = `SELECT COUNT(*) TotalCase FROM Cases;`;
    const customerSQL = `SELECT COUNT(*) as TotalCustomer FROM Customer`;
    const insuranceSQL = `SELECT COUNT(*) as TotalInsurance FROM Insurance`;
    const carSQL = `SELECT COUNT(*) as TotalCar FROM Car`;

    const caseResult: any = await conn?.query(caseSQL);
    const customerResult: any = await conn?.query(customerSQL);
    const insuranceResult: any = await conn?.query(insuranceSQL);
    const carResult: any = await conn?.query(carSQL);
    const data = [
      {
        title: "Cases",
        value: caseResult[0][0].TotalCase,
      },
      {
        title: "Customers",
        value: customerResult[0][0].TotalCustomer,
      },
      {
        title: "Insurances",
        value: insuranceResult[0][0].TotalInsurance,
      },
      {
        title: "Cars",
        value: carResult[0][0].TotalCar,
      },
    ];
    res.status(200).json({
      status: "success",
      data: data,
    });
    
  } catch (error: any) {
    console.log(error.message);
  }
};
