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
exports.cardCounter = void 0;
const server_1 = require("../../../server");
const cardCounter = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const caseSQL = `SELECT COUNT(*) TotalCase FROM Cases;`;
        const customerSQL = `SELECT COUNT(*) as TotalCustomer FROM Customer`;
        const insuranceSQL = `SELECT COUNT(*) as TotalInsurance FROM Insurance`;
        const carSQL = `SELECT COUNT(*) as TotalCar FROM Car`;
        const caseResult = yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(caseSQL));
        const customerResult = yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(customerSQL));
        const insuranceResult = yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(insuranceSQL));
        const carResult = yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(carSQL));
        const data = [
            {
                title: "Cases",
                value: caseResult[0][0].TotalCase,
            },
            {
                title: "Customers",
                value: customerResult[0][0].TotalCustomer,
            },
            {
                title: "Insurances",
                value: insuranceResult[0][0].TotalInsurance,
            },
            {
                title: "Cars",
                value: carResult[0][0].TotalCar,
            },
        ];
        res.status(200).json({
            status: "success",
            data: data,
        });
    }
    catch (error) {
        console.log(error.message);
    }
});
exports.cardCounter = cardCounter;
