import { Request, Response } from "express";
import { conn } from "../../server";
import jwt from "jsonwebtoken";

export const FindSurveyorByID = async (req: Request, res: Response) => {
  try {
    const token = req.params.token;

    // Check if the token is provided
    if (!token) {
      return res.status(400).send("Token not found");
    }

    const secret = process.env.JWT_SECRET!;

    try {
      // Verify the JWT token
      const decoded: any = jwt.verify(token, secret);

      // Check if the decoded token is valid
      if (!decoded) {
        return res.status(400).send("Invalid token");
      }

      // Fetch surveyor data from the database based on the decoded ID
      const sql = `SELECT * FROM Surveyor WHERE SurveyorID = ?`;
      const result: any = await conn?.query(sql, [decoded.ID]);

      // Check if any surveyor data is found
      if (result && result.length > 0) {
        return res.status(200).send(result[0]);
      } else {
        return res.status(404).send("Surveyor not found");
      }
    } catch (jwtError) {
      // Handle JWT verification errors
      console.log(jwtError);
      return res.status(401).send("Unauthorized: Invalid token");
    }
  } catch (error) {
    // Handle other errors
    console.log(error);
    return res.status(500).send("Internal Server Error");
  }
};
