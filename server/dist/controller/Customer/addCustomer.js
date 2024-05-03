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
exports.addCustomer = void 0;
const server_1 = require("../../server");
const UploadImage_1 = require("../../utils/UploadImage");
const addCustomer = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { First_name, Last_name, Email, Address, Phone_number, Line } = req.body;
        const Image = req.files;
        const addCustomer = `INSERT INTO Customer (First_name , Last_name , Email , Address , Phone_number , Line , Image) VALUES (?,?,?,?,?,?,?)`;
        const ImageURL = yield Promise.all(Image.map((file) => __awaiter(void 0, void 0, void 0, function* () {
            const url = yield (0, UploadImage_1.upLoadImageCustomer)(file.buffer);
            return url;
        })));
        const DataCustomer = {
            First_name,
            Last_name,
            Email,
            Address,
            Phone_number,
            Line,
            Image: ImageURL[0] || "https://firebasestorage.googleapis.com/v0/b/kmutt-recearch.appspot.com/o/user-icon-in-trendy-flat-style-isolated-on-grey-background-user-symbol-for-your-web-site-design-logo-app-ui-illustration-eps10-free-vector.jpg?alt=media&token=cab37aca-7b80-44b5-940c-cdab08f0f97c",
        };
        yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(addCustomer, [
            DataCustomer.First_name,
            DataCustomer.Last_name,
            DataCustomer.Email,
            DataCustomer.Address,
            DataCustomer.Phone_number,
            DataCustomer.Line,
            DataCustomer.Image,
        ]));
        res.status(200).json({ message: "Add Customer Success" });
    }
    catch (error) {
        console.log(error);
    }
});
exports.addCustomer = addCustomer;
