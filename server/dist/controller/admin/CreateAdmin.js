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
Object.defineProperty(exports, "__esModule", { value: true });
exports.CreateAdmin = void 0;
const server_1 = require("../../server");
const UploadImage_1 = require("../../utils/UploadImage");
const ManagePassWord_1 = require("../../utils/ManagePassWord");
const CreateAdmin = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { First_name, Last_name, Birth_date, Phone_number, Email, Password } = req.body;
        const Images = req.files;
        const sql = `INSERT INTO Admin (First_name, Last_name, Birth_date, Phone_number, Email, Password, Image) VALUES (?,?,?,?,?,?,?)`;
        const ImageURL = yield Promise.all(Images.map((file) => __awaiter(void 0, void 0, void 0, function* () {
            const url = yield (0, UploadImage_1.upLoadeImageAdmin)(file.buffer);
            return url;
        })));
        const DataAdmin = {
            First_name,
            Last_name,
            Birth_date,
            Phone_number,
            Email,
            Password: yield (0, ManagePassWord_1.hashPassword)(Password),
            ImageURL,
        };
        yield (0, server_1.Connect)();
        yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(sql, [DataAdmin.First_name, DataAdmin.Last_name, DataAdmin.Birth_date, DataAdmin.Phone_number, DataAdmin.Email, DataAdmin.Password, DataAdmin.ImageURL[0]]));
        res.status(200).json({
            status: "success",
            data: DataAdmin,
        });
    }
    catch (error) {
        console.log(error);
    }
});
exports.CreateAdmin = CreateAdmin;
