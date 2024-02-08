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
exports.addInsurance = void 0;
const server_1 = require("../../server");
const addInsurance = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { Policy_number, CustomerID, Policy_type, Start_date, End_date } = req.body;
        const addInsurance = `INSERT INTO Insurance (Policy_number , CustomerID , Policy_type , Start_date , End_date ,Status) VALUES (?,?,?,?,?,?)`;
        const DataInsurance = {
            Policy_number,
            CustomerID,
            Policy_type,
            Start_date,
            End_date,
            Status: "Active"
        };
        yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(addInsurance, [
            DataInsurance.Policy_number,
            DataInsurance.CustomerID,
            DataInsurance.Policy_type,
            DataInsurance.Start_date,
            DataInsurance.End_date,
            DataInsurance.Status
        ]));
        res.status(200).json({ message: "Add Insurance Success" });
    }
    catch (error) {
        console.log(error);
    }
});
exports.addInsurance = addInsurance;
