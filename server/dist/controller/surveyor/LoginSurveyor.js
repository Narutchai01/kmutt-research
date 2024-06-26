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
exports.LoginSurveyor = void 0;
const server_1 = require("../../server");
const ManagePassWord_1 = require("../../utils/ManagePassWord");
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const LoginSurveyor = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { email, PassWord } = req.body;
        const findSurveyorSQL = `SELECT * FROM Surveyor WHERE Email = ?`;
        const secret = String(process.env.JWT_SECRET);
        const findSurveyor = yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(findSurveyorSQL, [email]));
        if (!findSurveyor[0]) {
            res.status(400).json({ message: "Email not found" });
            return;
        }
        const checkPassword = yield (0, ManagePassWord_1.comparePassword)(PassWord, findSurveyor[0][0].Password);
        if (!checkPassword) {
            res.status(400).json({ message: "Password is incorrect" });
            return;
        }
        const payLoad = {
            ID: findSurveyor[0][0].SurveyorID,
        };
        const token = jsonwebtoken_1.default.sign(payLoad, secret, { expiresIn: "1y" });
        res.status(200).json({ token }); // Add the message field to the response
    }
    catch (error) {
        console.log(error);
    }
});
exports.LoginSurveyor = LoginSurveyor;
