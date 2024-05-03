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
exports.getCarByID = void 0;
const server_1 = require("../../server");
const getCarByID = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { CarID, Province } = req.query;
        const sql = `
SELECT Cus.First_name , Cus.Last_name 
, C.CarID 
, Cus.image as Customer_image 
, C.image as Car_Image, Cus.Address 
, C.Model 
,C.Province as Province
, C.Brand
, C.Color 
, Insu.Policy_number 
, Insu.Policy_type 
, Insu.Start_date
, Insu.End_date 
,Cus.Email
,Cus.Phone_number
,Cus.Line
FROM Car AS C
JOIN Customer AS Cus ON C.CustomerID = Cus.CustomerID
JOIN Insurance AS Insu ON C.Policy_number = Insu.Policy_number
WHERE C.CarID = ? AND C.Province = ? 
    `;
        const result = yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(sql, [CarID, Province]));
        res.status(200).json(result[0]);
    }
    catch (error) {
        console.log(error);
    }
});
exports.getCarByID = getCarByID;
