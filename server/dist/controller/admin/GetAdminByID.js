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
exports.getAdminByID = void 0;
const server_1 = require("../../server");
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const getAdminByID = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const Token = req.cookies.token;
        const secret = process.env.JWT_SECRET;
        const verifyToken = jsonwebtoken_1.default.verify(Token, String(secret));
        yield (0, server_1.Connect)();
        const findAdmin = yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(`SELECT * FROM Admin WHERE AdminID = ?`, [verifyToken.id]));
        if (!findAdmin) {
            return res.status(404).json({
                status: "fail",
                message: "Admin not found",
            });
        }
        const Admin = findAdmin[0][0];
        return res.status(200).send(Admin);
    }
    catch (error) {
        console.log(error);
    }
});
exports.getAdminByID = getAdminByID;
