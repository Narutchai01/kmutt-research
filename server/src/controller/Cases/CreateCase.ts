import { Request, Response } from "express";
import { conn, Connect, client } from "../../server";
import { v4 as uuidv4 } from "uuid";
import jwt from "jsonwebtoken";
import { upLoadImageCase } from "../../utils/UploadImage";
import axios from "axios";

export const CreateCase = async (req: Request, res: Response) => {
  try {
    await client.connect();
    await Connect();
    const token = req.params.token;
    const API = String(process.env.AI_URL);
    const secert = process.env.JWT_SECRET!;
    const decoded: any = jwt.verify(token, secert);
    const CaseID = uuidv4();
    const { CarID, Province, Description } = req.body;
    const Images = req.files;
    const addCase = `INSERT INTO Cases (CaseID, SurveyorID, CarID, Province, Description) VALUES (?,?,?,?,?)`;
    const addImageCase = `INSERT INTO Image (CaseID , Image_link) VALUES (?,?)`;
    const addDamageDetails = `INSERT INTO Damage_detail (CaseID, Car_part , Damage_type ,Damage_severity) VALUE (?, ?, ?, ?)`;
    let reportArr: any = [];
    const ImageArr: string[] = [];
    const DataCase = {
      CaseID,
      SurveyorID: decoded.ID,
      CarID,
      Province,
      Description,
    };
    await conn?.query(addCase, [
      DataCase.CaseID,
      DataCase.SurveyorID,
      DataCase.CarID,
      DataCase.Province,
      DataCase.Description,
    ]);
    await Promise.all(
      (Images as Express.Multer.File[]).map(async (file: any) => {
        const url = await upLoadImageCase(file.buffer);
        ImageArr.push(url);
        const DataImageCase = {
          CaseID: CaseID,
          Image_link: url,
        };
        await conn?.query(addImageCase, [
          DataImageCase.CaseID,
          DataImageCase.Image_link,
        ]);
      })
    );

    await axios
      .post(`${API}/predict`, {
        urls: ImageArr,
        car_part_conf_thres: 0.3,
        car_part_iou_thres: 0.5,
        car_damage_conf_thres: 0.3,
        car_damage_iou_thres: 0.5,
      })
      .then((response) => {
        reportArr.push(response.data);
      })
      .catch((error) => {
        console.log(error);
      });

    await Promise.all(
      ImageArr.map(async (image) => {
        const Arr = reportArr[0][image].report;
        const damgeArr: string[] = Arr.damage;
        const CarPart = Arr.car_part;
        const split = damgeArr.map((item: any) =>
          item.split(", ").map((i: any) => i.split(" "))
        );
        await Promise.all(
          split.map(async (item, index) => {
            for (let i = 0; i < item.length; i++) {
              const dataDetail = {
                CaseID: CaseID,
                CarPart: CarPart[index],
                DamageType: item[i][1] || "None",
                DamageSeverity: item[i][0] || "None",
              };
              await conn?.query(addDamageDetails, [
                dataDetail.CaseID,
                dataDetail.CarPart,
                dataDetail.DamageType,
                dataDetail.DamageSeverity,
              ]);
            }
          })
        );
      })
    );

    if (reportArr.length !== 0) {
      const updateSQL = `UPDATE Cases SET Status = 'Success' WHERE CaseID = ?`;
      await conn?.query(updateSQL, [CaseID]);
      const data = {
        CaseID: CaseID,
        report: reportArr,
      };
      await client.db("kmutt").collection("report").insertOne(data);
    }

    res.status(200).json({ message: "Create Case Success" });
  } catch (error) {
    console.log(error);
  }
};
