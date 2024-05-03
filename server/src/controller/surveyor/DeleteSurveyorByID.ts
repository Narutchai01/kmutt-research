import { Request, Response } from "express";
import { conn } from "../../server"


export const DeleteSurveyorByID = async (req: Request, res: Response) => {
    try {
        const { id } = req.params;
        const sql = `DELETE FROM Surveyor WHERE SurveyorID = ?`;
        await conn?.query(sql, [id]);
        res.json({ message: `Surveyor with id ${id} deleted.` });
    } catch (error) {
        console.log(error);
    }
};