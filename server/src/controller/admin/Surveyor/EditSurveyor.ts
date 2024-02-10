import { Request ,Response} from "express";
import { Connect , conn} from '../../../server';
import { CheckDataEdit } from "../../../utils/ChackDataEdit";


export const EditSurveyor = async (req: Request, res: Response) => {
    try {
        const id = req.params.id;
        const {First_name , Last_name , Birthday , Emaill , Telephone , Password} = req.body;
        const findsurveyorSQL = `SELECT * FROM Surveyor WHERE SurveyorID = ?`
        const updateSQL = `UPDATE Surveyor SET First_name = ? , Last_name = ? , Birth_date = ? , Email = ? , Phone_number = ? , Password = ? WHERE SurveyorID = ?`;
        await Connect();
        const findSurveyorBYID :any = await conn?.query(findsurveyorSQL,[id]);
        const data = {
            First_name : await CheckDataEdit(First_name) ? First_name : findSurveyorBYID[0][0].First_name,
            Last_name : await CheckDataEdit(Last_name) ? Last_name : findSurveyorBYID[0][0].Last_name,
            Birthday : await CheckDataEdit(Birthday) ? Birthday : findSurveyorBYID[0][0].Birthday,
            Email : await CheckDataEdit(Emaill) ? Emaill : findSurveyorBYID[0][0].Email,
            Telephone :await CheckDataEdit(Telephone) ? Telephone : findSurveyorBYID[0][0].Telephone,
            Password : await CheckDataEdit(Password) ? Password : findSurveyorBYID[0][0].Password,
        };
        await conn?.query(updateSQL,[data.First_name,data.Last_name,data.Birthday,data.Email,data.Telephone,data.Password,id]);
        res.status(200).json({message : "Update Success"});
    } catch (error) {
        console.log(error);
        
    }
};