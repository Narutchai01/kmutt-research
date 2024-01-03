import dotenv from 'dotenv';
import { ICONFIG } from '../interface/Interface';
dotenv.config();

export const Config:ICONFIG = {
    DB_URL: String(process.env.DATABASE_URL), 
    PORT: Number(process.env.PORT)
};