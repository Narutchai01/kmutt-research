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
exports.EditCustomer = void 0;
const server_1 = require("./../../../server");
const ChackDataEdit_1 = require("../../../utils/ChackDataEdit");
const EditCustomer = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { id } = req.params;
        const { FirstName, LastName, Email, Phone_number, Address, Line } = req.body;
        const findCustomer = yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query("SELECT * FROM customer WHERE id = ?", [id]));
        if (!findCustomer) {
            return res.status(400).json({ message: "Customer not found" });
        }
        const data = {
            FirstName: (0, ChackDataEdit_1.CheckDataEdit)(FirstName) || findCustomer[0][0].FirstName,
            LastName: (0, ChackDataEdit_1.CheckDataEdit)(LastName) || findCustomer[0][0].LastName,
            Email: (0, ChackDataEdit_1.CheckDataEdit)(Email) || findCustomer[0][0].Email,
            Phone_number: (0, ChackDataEdit_1.CheckDataEdit)(Phone_number) || findCustomer[0][0].Phone_number,
            Address: (0, ChackDataEdit_1.CheckDataEdit)(Address) || findCustomer[0][0].Address,
            Line: (0, ChackDataEdit_1.CheckDataEdit)(Line) || findCustomer[0][0].Line,
        };
        yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query("UPDATE Customer SET ? WHERE id = ?", [data, id]));
        res.status(200).json({ message: "Edit Customer Success" });
    }
    catch (error) {
        console.log(error);
    }
});
exports.EditCustomer = EditCustomer;
