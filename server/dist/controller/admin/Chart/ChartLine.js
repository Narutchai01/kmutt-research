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
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ChartLine = void 0;
const server_1 = require("../../../server");
const dayjs_1 = __importDefault(require("dayjs"));
const ChartLine = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        yield (0, server_1.Connect)();
        const couter = [];
        const date = [];
        const sql = `SELECT DATE(Date_opened) AS case_day, COUNT(*) AS case_couter
FROM Cases
WHERE Date_opened >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
GROUP BY case_day
ORDER BY case_day DESC;
;`;
        const result = yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(sql));
        result[0].forEach((element) => {
            couter.push(element.case_couter);
            date.push((0, dayjs_1.default)(element.case_day).format("DD/MM/YYYY"));
        });
        res.status(200).json({ message: "Success", date: date, couter: couter });
    }
    catch (error) {
        console.log(error.message);
    }
});
exports.ChartLine = ChartLine;
