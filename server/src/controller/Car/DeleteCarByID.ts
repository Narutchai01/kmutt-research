import { Request, Response } from "express";
import { conn} from "../../server";
import { log } from "console";


export const DeleteCarByID = async (req: Request, res: Response) => {
    try {
        const { id } = req.params;
        const sql = `DELETE FROM Car WHERE CarID = ?`;
        await conn?.query(sql, [id]);
        console.log(id);
        res.json({ message: `Car with id ${id} deleted.` });
    } catch (error) {
        console.log(error);
    }
};