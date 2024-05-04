import { client, conn } from "../../server";
import { Request, Response } from "express";

export const GetReport = async (req: Request, res: Response) => {
  try {
    const sql = `SELECT Image_link FROM Image WHERE CaseID = ?`;
    const { caseID } = req.query;
    const ImgaeArr: any = await conn?.query(sql, [caseID]);
    const report: any = await client
      .db("kmutt")
      .collection("report")
      .findOne({ CaseID: caseID });

    const newReportArr: any = [];

    await ImgaeArr[0].map(async (item: any) => {
      const car_partArr: any = [];
      const { Image_link } = item;
      const newReport: any = report.report[0][Image_link];
      const { car_part_results, report: reportData ,image_meta_data} = newReport;
      const { car_part, damage } = reportData;

      await damage.map((item: string, index: number) => {
        if (item !== "") {
          car_partArr.push({
            ...car_part_results[index],
            class: `${car_part[index]} ${item.split(" ")[1]}`,
            namePart: car_part[index],
            damage: item.split(" ")[1],
          });
        }
      });
      await newReportArr.push({
        [Image_link]: {
          image_meta_data: image_meta_data,
          car_part_results: car_partArr,
        },
      });
      car_partArr.length = 0;
    });

    res.status(200).send({
      ImageArr: ImgaeArr[0],
      report: newReportArr,
    });
  } catch (error) {
    console.log(error);
  }
};
