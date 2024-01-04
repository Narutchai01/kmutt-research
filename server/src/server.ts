import express from "express";
import { Config } from "./lib/config";
import mysql from "mysql2/promise";
import multer from "multer";

import SurveyorRouter from "./routers/Surveyor";
import CarRouter from "./routers/Cars";
import CasesRouter from "./routers/Cases";

const app = express();
const PORT = Config.PORT;

app.use(express.json());

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

app.use("/api/surveyor", SurveyorRouter);
app.use("/api/cases", CasesRouter);
app.use("/api/cars", CarRouter);

app.listen(PORT, async () => {
  await Connect();
  console.log(`⚡️[server]: Server is running at https://localhost:${PORT}`);
});
