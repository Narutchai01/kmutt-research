import { Request ,Response} from "express";
import { Connect , conn} from '../../../server';


export const EditSurveyor = async (req: Request, res: Response) => {
    try {
        const id = req.params.id;
        const {First_name , Last_name , Birthday , Emaill , Telephone , Password} = req.body;
        const sql = `UPDATE Surveyor SET First_name = ? , Last_name = ? , Birthday = ? , Emaill = ? , Telephone = ? , Password = ? WHERE SurveyorID = ?`;
        await Connect();
        const dataUpdate = {
            First_name,
            Last_name,
            Birthday,
            Emaill,
            Telephone,
            Password,
            id
        }
        res.json({dataUpdate});
    } catch (error) {
        console.log(error);
        
    }
};