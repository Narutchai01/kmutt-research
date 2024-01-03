import dotenv from 'dotenv';
import { ICONFIG,test_db } from '../interface/Interface';
dotenv.config();

export const Config:ICONFIG = {
    DB_URL: String(process.env.DATABASE_URL), 
    PORT: Number(process.env.PORT)
};


export const ConfigDB:test_db = {
    TEST_DB_HOST: String(process.env.TEST_DATABASE_HOST),
    TEST_DB_USER: String(process.env.TEST_DATABASE_USERNAME),
    TEST_DB_PASSWORD: String(process.env.TEST_DATABASE_PASSWORD),
    TEST_DB_NAME: String(process.env.TEST_DATABASE_NAME),
    TEST_DB_PORT: Number(process.env.TEST_DATABASE_PORT),
}
