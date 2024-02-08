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
exports.ChangePassWord = void 0;
const server_1 = require("../../server");
const ManagePassWord_1 = require("../../utils/ManagePassWord");
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const ChangePassWord = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        yield (0, server_1.Connect)();
        const { oldPassword, newPassword } = req.body;
        const secert = process.env.JWT_SECRET;
        const { token } = req.params;
        const decode = yield jsonwebtoken_1.default.verify(token, secert);
        const findsurveyorSQL = `SELECT * FROM Surveyor WHERE SurveyorID = ?`;
        const updatePasswordSQL = `UPDATE Surveyor SET Password = ? WHERE SurveyorID = ?`;
        const surveyor = yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(findsurveyorSQL, [decode.ID]));
        if (!surveyor) {
            res.status(400).json({ message: "Surveyor not found" });
            return;
        }
        const isMatch = yield (0, ManagePassWord_1.comparePassword)(oldPassword, surveyor[0][0].Password);
        if (!isMatch) {
            res.status(400).json({ message: "Old password is incorrect" });
            return;
        }
        const hash = yield (0, ManagePassWord_1.hashPassword)(newPassword);
        yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(updatePasswordSQL, [hash, decode.ID]));
        res.status(200).json({ message: "Change password success" });
    }
    catch (error) {
        console.log(error);
    }
});
exports.ChangePassWord = ChangePassWord;
