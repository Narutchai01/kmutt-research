import { Request,Response ,NextFunction } from "express";

export const auth = (req:Request,res:Response,next:NextFunction) => {
    try {
        const token = req.cookies.token;
        if (!token) return res.status(401).json({errorMessage: "Unauthorized"});
        next();    
    } catch (error) {
        console.log(error);
    }
};