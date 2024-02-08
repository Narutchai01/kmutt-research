"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.FindSurveyorByID = void 0;
const server_1 = require("../../server");
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const FindSurveyorByID = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const token = req.params.token;
        const secert = process.env.JWT_SECRET;
        const decoded = jsonwebtoken_1.default.verify(token, secert);
        const sql = `SELECT * FROM Surveyor WHERE SurveyorID = ?`;
        const result = yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(sql, [decoded.ID]));
        res.status(200).send(result[0]);
    }
    catch (error) {
        console.log(error);
    }
});
exports.FindSurveyorByID = FindSurveyorByID;
