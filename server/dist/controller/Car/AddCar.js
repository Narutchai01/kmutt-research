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
exports.AddCar = void 0;
const server_1 = require("../../server");
const UploadImage_1 = require("../../utils/UploadImage");
const AddCar = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { CarID, Province, Policy_number, CustomerID, Brand, Model, Color, Status, } = req.body;
        const Image = req.files;
        const ImageURL = Promise.all(Image.map((file) => __awaiter(void 0, void 0, void 0, function* () {
            const url = yield (0, UploadImage_1.upLoadImageCar)(file.buffer);
            return url;
        })));
        const ImageURLs = yield ImageURL;
        const addSpace = (str) => {
            const symbol = " ";
            str = str.split(" ").join("");
            if (str.length === 6 || str.length === 7) {
                let newStr = str.slice(0, str.length - 4) + symbol + str.slice(str.length - 4);
                return newStr;
            }
        };
        const sql = `INSERT INTO Car (CarID,Province,CustomerID,Policy_number,Image,Brand,Model,Color,Status) VALUES (?,?,?,?,?,?,?,?,?)`;
        const data = {
            CarID: addSpace(CarID),
            Province,
            CustomerID,
            Policy_number,
            Image: ImageURLs[0],
            Brand,
            Model,
            Color,
            Status: "Active",
        };
        yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(sql, [
            data.CarID,
            data.Province,
            data.CustomerID,
            data.Policy_number,
            data.Image,
            data.Brand,
            data.Model,
            data.Color,
            data.Status,
        ]));
        res.status(200).json({ message: "Add Car Success" });
    }
    catch (error) {
        console.log(error);
    }
});
exports.AddCar = AddCar;
