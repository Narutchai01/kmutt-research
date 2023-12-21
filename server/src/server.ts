// import zone
import mysql from 'mysql2/promise';
import { Config } from './lib/config';
import express from 'express';


// define Zone
const app = express();
const PORT = 3000;
app.use(express.json());

export const ConnenctDB = async () => {
    await mysql.createConnection(Config.DB_URL);
};





app.listen(PORT,async () => {
    await ConnenctDB();
    console.log(`Server is running on PORT ${PORT}`);
});

