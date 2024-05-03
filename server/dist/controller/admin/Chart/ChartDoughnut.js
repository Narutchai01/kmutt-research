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
exports.ChartDoughnut = void 0;
const server_1 = require("../../../server");
const ChartDoughnut = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const Province = [];
        const ProvinceCounter = [];
        const sql = `SELECT Province , COUNT(*) as counter FROM Cases GROUP by Province;`;
        const reult = yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(sql));
        reult[0].forEach((element) => {
            Province.push(element.Province);
            ProvinceCounter.push(element.counter);
        });
        res.status(200).json({ Province, ProvinceCounter });
    }
    catch (error) {
        console.log(error.message);
    }
});
exports.ChartDoughnut = ChartDoughnut;
