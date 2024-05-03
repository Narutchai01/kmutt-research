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
exports.loginAdmin = void 0;
const server_1 = require("../../server");
const ManagePassWord_1 = require("../../utils/ManagePassWord");
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const loginAdmin = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const secret = process.env.JWT_SECRET;
        const { Email, Password } = req.body;
        const findAdmin = yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(`SELECT * FROM Admin WHERE Email = ?`, [Email]));
        if (!findAdmin) {
            return res.status(404).json({
                status: "fail",
                message: "Admin not found",
            });
        }
        const Admin = findAdmin[0];
        const compare = yield (0, ManagePassWord_1.comparePassword)(Password, Admin[0].Password);
        if (!compare) {
            return res.status(404).json({
                status: "fail",
                message: "Password is not correct",
            });
        }
        const token = jsonwebtoken_1.default.sign({ id: Admin[0].AdminID }, secret, { expiresIn: "1d" });
        res.cookie("token", token, { httpOnly: true });
        return res.status(200).json({
            status: "success",
            message: "Login success",
            token,
        });
    }
    catch (error) {
        console.log(error);
    }
});
exports.loginAdmin = loginAdmin;
