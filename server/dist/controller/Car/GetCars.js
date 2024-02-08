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
exports.GetCars = void 0;
const server_1 = require("../../server");
const GetCars = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const sql = 'SELECT Cus.First_name , Cus.Last_name , Cus.image ,C.CarID ,C.Province FROM Car as C JOIN Customer as Cus USING(CustomerID)';
        const result = yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(sql));
        if (!result[0]) {
            res.status(404).json({ message: 'Not Found' });
        }
        res.status(200).send(result[0]);
    }
    catch (error) {
        console.log(error);
    }
});
exports.GetCars = GetCars;
