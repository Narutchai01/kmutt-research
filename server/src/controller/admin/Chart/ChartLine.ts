import { Request, Response } from "express";
import { conn, Connect } from "../../../server";
import dayjs from "dayjs";

export const ChartLine = async (req: Request, res: Response) => {
  try {
    await Connect();
    const couter: number[] = [];
    const date: string[] = [];

    const sql = `SELECT DATE(Date_opened) AS case_day, COUNT(*) AS case_couter
FROM Cases
WHERE Date_opened >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
GROUP BY case_day
ORDER BY case_day DESC;
;`;
    const result: any = await conn?.query(sql);

    result[0].forEach((element: any) => {
      couter.push(element.case_couter);
      date.push(dayjs(element.case_day).format("DD/MM/YYYY"));
    });

    res.status(200).json({ message: "Success", date: date, couter: couter });
  } catch (error: any) {
    console.log(error.message);
  }
};
