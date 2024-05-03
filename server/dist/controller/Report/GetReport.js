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
exports.GetReport = void 0;
const server_1 = require("../../server");
const GetReport = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const sql = `SELECT Image_link FROM Image WHERE CaseID = ?`;
        const { caseID } = req.query;
        const ImgaeArr = yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(sql, [caseID]));
        const report = yield server_1.client
            .db("kmutt")
            .collection("report")
            .findOne({ CaseID: caseID });
        const newReportArr = [];
        yield ImgaeArr[0].map((item) => __awaiter(void 0, void 0, void 0, function* () {
            const car_partArr = [];
            const { Image_link } = item;
            const newReport = report.report[0][Image_link];
            const { car_part_results, report: reportData } = newReport;
            const { car_part, damage } = reportData;
            yield damage.map((item, index) => {
                if (item !== "") {
                    car_partArr.push(Object.assign(Object.assign({}, car_part_results[index]), { class: `${car_part[index]} ${item.split(" ")[1]}`, namePart: car_part[index], damage: item }));
                }
            });
            yield newReportArr.push({
                [Image_link]: car_partArr,
            });
            car_partArr.length = 0;
        }));
        res.status(200).send(newReportArr);
    }
    catch (error) {
        console.log(error);
    }
});
exports.GetReport = GetReport;
