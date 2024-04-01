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
exports.ChartBar = void 0;
const server_1 = require("../../../server");
const ChartBar = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        yield (0, server_1.Connect)();
        const Policy_type = [];
        const coun_policy = [];
        const sql = `SELECT Policy_type , COUNT(*) as coun_policy from Insurance GROUP by Policy_type;`;
        const result = yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(sql));
        result[0].forEach((element) => {
            Policy_type.push(element.Policy_type);
            coun_policy.push(element.coun_policy);
        });
        res.status(200).json({ Policy_type, coun_policy });
    }
    catch (error) {
        console.log(error.message);
    }
});
exports.ChartBar = ChartBar;
