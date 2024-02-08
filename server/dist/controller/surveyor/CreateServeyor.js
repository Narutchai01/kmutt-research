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
exports.CreateSurveyor = void 0;
const server_1 = require("../../server");
const ManagePassWord_1 = require("../../utils/ManagePassWord");
const UploadImage_1 = require("../../utils/UploadImage");
const CreateSurveyor = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const Images = req.files;
        const { First_name, Last_name, Email, PassWord, Phone_number, Birth_date } = req.body;
        const sql = `INSERT INTO Surveyor ( First_name, Last_name, Image , Birth_date , Phone_number ,Email , Password) VALUES ( ?, ?, ?, ?, ?, ? ,?)`;
        const ImageURL = yield Promise.all(Images.map((file) => __awaiter(void 0, void 0, void 0, function* () {
            const url = yield (0, UploadImage_1.uploadImageSurveyor)(file.buffer);
            return url;
        })));
        const Image = ImageURL[0] || "https://firebasestorage.googleapis.com/v0/b/kmutt-recearch.appspot.com/o/user-icon-in-trendy-flat-style-isolated-on-grey-background-user-symbol-for-your-web-site-design-logo-app-ui-illustration-eps10-free-vector.jpg?alt=media&token=cab37aca-7b80-44b5-940c-cdab08f0f97c";
        const dataSurveyor = {
            First_name,
            Last_name,
            Image,
            Email,
            Birth_date,
            PassWord: yield (0, ManagePassWord_1.hashPassword)(PassWord),
            Phone_number,
        };
        yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(sql, [
            dataSurveyor.First_name,
            dataSurveyor.Last_name,
            dataSurveyor.Image,
            dataSurveyor.Birth_date,
            dataSurveyor.Phone_number,
            dataSurveyor.Email,
            dataSurveyor.PassWord,
        ]));
        res.status(200).json({ message: "Create Surveyor Success" });
    }
    catch (error) {
        console.log(error);
    }
});
exports.CreateSurveyor = CreateSurveyor;
