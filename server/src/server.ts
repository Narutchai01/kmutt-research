// import zone
import express from "express";
import { Config,ConfigDB } from "./lib/config";
import mysql from "mysql2/promise";
import Surveyor from "./routers/Surveyor"; 


// define zone
const PORT = Config.PORT;
const app = express();
app.use(express.json());

export let conn: mysql.Connection | null = null;


const ConnectDB = async () => {
    conn = await mysql.createConnection({
        host: ConfigDB.TEST_DB_HOST,
        user: ConfigDB.TEST_DB_USER,
        password: ConfigDB.TEST_DB_PASSWORD,
        database: ConfigDB.TEST_DB_NAME,
        port: ConfigDB.TEST_DB_PORT
    });
};



app.get("/", (req, res) => {
    res.send("Hello World");
});


app.use("/api/surveyor", Surveyor);


app.listen(PORT, async () => {
    await ConnectDB();
    console.log(`Server is running on port ${PORT}.`);
    
});