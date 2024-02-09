"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.Config = void 0;
const dotenv_1 = __importDefault(require("dotenv"));
dotenv_1.default.config();
exports.Config = {
    PORT: Number(process.env.PORT),
    DB_HOST: String(process.env.DBHOST),
    DB_USER: String(process.env.DBUSER),
    DB_PASSWORD: String(process.env.DBPASS),
    DB_NAME: String(process.env.DBNAME),
    DB_PORT: Number(process.env.DBPORT)
};
