import express from "express";
import { Config } from "./lib/config";
import mysql from "mysql2/promise";
import multer from "multer";
import cookieParser from "cookie-parser";
import cors from "cors";

import SurveyorRouter from "./routers/Surveyor";
import CasesRouter from "./routers/Cases";
import CustomerRouter from "./routers/Customer";
import InsuranceRouter from "./routers/Insurance";
import CarRouter from "./routers/Cars";

const app = express();
const PORT = Config.PORT;

app.use(express.json());
app.use(cookieParser());
app.use(cors(
  {
    origin: true,
    credentials: true,
  }
));

export let conn: mysql.Connection | null = null;
const Connect = async () => {
  conn = await mysql.createConnection({
    host: Config.DB_HOST,
    user: Config.DB_USER,
    password: Config.DB_PASSWORD,
    database: Config.DB_NAME,
    port: Config.DB_PORT,
  });
  console.log("Database Connected");
};


const multerMid = multer({
  storage: multer.memoryStorage(),
});

app.use(multerMid.array("file"));

app.get("/", (req, res) => {
  res.send("Hello World!");
});

app.use("/api/cars",CarRouter);
app.use("/api/surveyor", SurveyorRouter);
app.use("/api/cases", CasesRouter);
app.use("/api/customer",CustomerRouter);
app.use("/api/insurance",InsuranceRouter);

app.listen(PORT, async () => {
  await Connect();
  console.log(`⚡️[server]: Server is running at http://localhost:${PORT}`);
});
