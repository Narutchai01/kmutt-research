import dotenv from 'dotenv';
import { ICONFIG } from '../interface/Interface';
dotenv.config();

export const Config:ICONFIG= {
    PORT: Number(process.env.PORT),
    DB_HOST: String(process.env.DBHOST),
    DB_USER : String(process.env.DBUSER) ,
    DB_PASSWORD : String(process.env.DBPASS),
    DB_NAME : String(process.env.DBNAME) ,
    DB_PORT : Number(process.env.DBPORT) 
};