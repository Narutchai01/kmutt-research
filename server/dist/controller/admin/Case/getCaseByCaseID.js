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
exports.getCaseByCaseID = void 0;
const server_1 = require("../../../server");
const getCaseByCaseID = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { caseId } = req.params;
        const sql = `SELECT * FROM Cases WHERE CaseID = ?`;
        yield (0, server_1.Connect)();
        const result = yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(sql, [caseId]));
        if (!result) {
            return res.status(400).json({ message: "Case not found" });
        }
        return res.status(200).json(result[0]);
    }
    catch (error) {
        console.log(error);
    }
});
exports.getCaseByCaseID = getCaseByCaseID;
